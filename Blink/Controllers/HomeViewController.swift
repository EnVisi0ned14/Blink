//
//  HomeViewController.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a list of view controllers
        let vcs = [MatchScreenViewController(), BlinkPlusViewController(), BlinkPlusViewController()]
        
        //Create a list of tab bar item images
        let images = ["person.fill", "heart.fill", "message.fill"]
        
        //Assign the list of view controllers
        viewControllers = vcs.enumerated().map { (index, vc) in
            //TODO: Replace tab bar item's with updated images, and gradients for selected
            let navVC = UINavigationController(rootViewController: vc)
            navVC.tabBarItem.image = UIImage(systemName: images[index])
            return navVC
        }
        
        
        



        
    }
    


}
