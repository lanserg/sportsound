//
//  SecondViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 28.01.2019.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrData: [String] = []
    var clearLg: [String] = []
    var lang2 = "eng"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = arrData[indexPath.row]
        return cell
        }

    @IBOutlet weak var clearLBL: UILabel!
    
    @IBOutlet weak var logLBL: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func ClearLogButton(_ sender: UIButton) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! ViewController
        vc.clear = "1"
        self.navigationController?.pushViewController(vc, animated: true)
        arrData.removeAll()
        tableView.reloadData()
    }
    func langChange () {
        if lang2 == "eng" || lang2 == "" {
            logLBL.text = "Log"
            clearLBL.text = "Clear"
        } else {
            logLBL.text = "История"
            clearLBL.text = "Очистить"
        }
    }
   //      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //    let destdata: ViewController = segue.destination as! ViewController
   //     destdata.clear = "1"
           
    //}

    override func viewDidLoad() {
        super.viewDidLoad()
        print(arrData)
        print(lang2)
        langChange()
    }
}
