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

    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = coreArray[indexPath.row]
        return cell
    }

    var arrData: [String] = []
    var clearLg: [String] = []
    var coreArray : [String] = []
    var result : [Any] = []
    var vcClear : String = ""

    
    
    func coreArrayCheck() {
        if (coreArray == arrData) {
            print("Arrays equal")
        } else if (arrData != coreArray) {
            print("Arrays have difference")
        }
    }
    
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
                        coreArray.append(matches)
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
    
    @IBAction func ShareButton(_ sender: Any) {
        let shareActivity = UIActivityViewController (activityItems: [arr()], applicationActivities: nil)
        shareActivity.popoverPresentationController?.sourceView = self.view
        
        self.present (shareActivity, animated: true, completion: nil)
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
    
    @IBAction func ClearLogButton(_ sender: UIButton) {
    
        let dialogMessage = UIAlertController(title: "Deleting history", message: "Are you sure you want to delete the history?", preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteData()
            self.vcClear = "1"
            self.coreArray.removeAll()
            self.tableView.reloadData()
        })
            
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destDataArr : ViewController =  segue.destination as! ViewController
//        destDataArr.coreArr = coreArray
//            if (vcClear == "1") {
//                let destData : ViewController =  segue.destination as! ViewController
//                destData.clear2 = vcClear
//        }
//    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
  
    func checkRewrite () {
        if (arrData.count > 0) {
            saveData()
            arrData.removeAll()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savingData()
        getData()

    }
    
}
