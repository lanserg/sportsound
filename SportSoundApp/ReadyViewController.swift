//
//  ReadyViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 20.September.19.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func toAppButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let  mainVC = storyboard.instantiateViewController(withIdentifier: "NaviVC") as! UINavigationController
        mainVC.modalTransitionStyle = .flipHorizontal
        self.present(mainVC, animated: true, completion: nil)
        
    }
    
}
