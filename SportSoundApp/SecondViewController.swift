//
//  SecondViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 28.01.2019.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // таблица
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = coreArray[indexPath.row]
        return cell
    }

    var arrData: [String] = [] // получаемый массив с данными о матче
    var clearLg: [String] = []
    var coreArray : [String] = [] // массив CoreData
    var result : [Any] = []
    var vcClear : String = ""

    // сравнивание массива в памяти и нового поступившего на наличие отличий
    
    func coreArrayCheck() {
        if (coreArray == arrData) {
            print("Arrays equal")
        } else if (arrData != coreArray) {
            print("Arrays have difference")
        }
    }
    
    // for sharing log
    
    func arr () -> String {
        var str: String = ""
        for i in coreArray {
            str += "\(i) \n"
        }
        return str
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    lazy var context = appDelegate.persistentContainer.viewContext
    
    var localArray : [String] = []
    
    func savingData() {
        if (arrData.count == 0) {
           print("Arrays empty")
        } else if (arrData.count > 0) {
            saveData()
            print("Array saved, temp array removed")
        }
    }

   // ф-и сохранения, извлечения и удаления данных из массива в CoreData
    
    func saveData() {

        for item in arrData {
            
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context)
        
                newUser.setValue(item, forKey: "matches")
        
            do {
                try context.save()
                print ("SAVED")
            }
            
            catch  {
                print ("Error saving")
            }
        }
    }
    
    func getData ()   {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    
                    if let matches = item.value (forKey: "matches") as? String {
                        coreArray.insert(matches, at: 0)
                        print(matches)
                    }
                    
                }
            }
            
        } catch  {
            print ("Geting Data Error")
    }
        print("coreArray is \n \(coreArray)")
    }
    
    func deleteData ()  {
        
        let deleteMatches = NSFetchRequest<NSFetchRequestResult> (entityName: "Log")
        
        deleteMatches.returnsObjectsAsFaults = false
        
        do
        {
            let fetchedResults =  try context.fetch(deleteMatches) as? [NSManagedObject]
            
            for match in fetchedResults! {
                
                context.delete(match)
                try! context.save()
            }
            
        }
        catch {
            print("Could not delete")
            
        }
    }
    
    //поделиться
    
    @IBAction func ShareButton(_ sender: Any) {
        if (coreArray.isEmpty == false) {
        let shareActivity = UIActivityViewController (activityItems: [arr()], applicationActivities: nil)
        shareActivity.popoverPresentationController?.sourceView = self.view
        
        self.present (shareActivity, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var logLBL: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func deleteRecord()
    {
        tableView.reloadData()
        deleteData()
        vcClear = "1"
        arrData.removeAll()
    }
    
    // очистка таблица с Alert вопросом подтверждения
    
    @IBAction func ClearLogButton(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: NSLocalizedString("Deleting history", comment: ""), message: NSLocalizedString("Are you sure you want to delete the history?", comment: ""), preferredStyle: .alert)

        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteData()
            self.vcClear = "1"
            self.coreArray.removeAll()
            self.tableView.reloadData()
        })
            
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        
        self.present(dialogMessage, animated: true, completion: nil)
        }

 // прячем navigationBar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
  
    // перезапись массива CoreData в случае, если он отличается от вновь полученного
    
    func checkRewrite () {
        if (arrData.count > 0) {
            saveData()
            arrData.removeAll()
        }
    }
    
    // свайп обратно на главную (от Сани)
    
    func swipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savingData()
        getData()
        swipe()
    }
    
}
