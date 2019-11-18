//
//  IconsViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 20.September.19.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit

class IconsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toReadyButton(_ sender: Any) {
         self.performSegue (withIdentifier: "secondToReady", sender: self)
    }
    
}
