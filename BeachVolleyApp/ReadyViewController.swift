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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "NaviVC") 
            mainVC.modalTransitionStyle = .flipHorizontal
//            self.present(mainVC, animated: true, completion: nil)
            
            self.present(mainVC, animated: true)
        } else if gesture.direction == .right {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let iconsVC = storyboard.instantiateViewController(withIdentifier: "IconsViewController")
            self.present(iconsVC, animated: true)
        }
    }

    @IBAction func toAppButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let  mainVC = storyboard.instantiateViewController(withIdentifier: "NaviVC")  as! UINavigationController
        mainVC.modalTransitionStyle = .flipHorizontal
        self.present(mainVC, animated: true, completion: nil)

    }
    
}
