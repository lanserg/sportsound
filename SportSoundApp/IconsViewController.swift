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
        swipe()
        // Do any additional setup after loading the view.
    }
    
    func swipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let readyVC = storyboard.instantiateViewController(withIdentifier: "ReadyViewController")
            self.present(readyVC, animated: true)
        } else if gesture.direction == .right {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let whistleVC = storyboard.instantiateViewController(withIdentifier: "notificationStoryboard")
            self.present(whistleVC, animated: true)
        }
    }

//    @IBAction func toReadyButton(_ sender: Any) {
//         self.performSegue (withIdentifier: "secondToReady", sender: self)
//    }
    
}
