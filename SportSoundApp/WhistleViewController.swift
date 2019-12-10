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
        swipe()
        // Do any additional setup after loading the view.
    }
    
    func swipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let iconsVC = storyboard.instantiateViewController(withIdentifier: "IconsViewController")
            self.present(iconsVC, animated: true)
        }
    }

//    @IBAction func toIconsButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "firstToSecond", sender: self)
//    }
    
}
