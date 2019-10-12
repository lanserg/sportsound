//
//  WhistleViewController.swift
//  SportSoundApp
//
//  Created by Elena Nazarova on 20.September.19.
//  Copyright © 2019 Elena Nazarova. All rights reserved.
//

import UIKit

class WhistleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func toIconsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "firstToSecond", sender: self)
    }
    
}
