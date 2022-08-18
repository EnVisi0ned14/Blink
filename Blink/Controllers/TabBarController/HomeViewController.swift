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
        
        //Set background color to white
        tabBar.barTintColor = .white
        
        // Remove default border line
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.white
        
        //Create a list of view controllers
        let vcs = [MatchScreenViewController(), BlinkPlusViewController(), ConversationViewController()]
        
        //Create a list of tab bar item images
        let unselectedImages: [UIImage] = [#imageLiteral(resourceName: "Unselected Card Icon").withRenderingMode(.alwaysOriginal),
                                           #imageLiteral(resourceName: "Unselected Heart Icon").withRenderingMode(.alwaysOriginal),
                                           #imageLiteral(resourceName: "Unselected Message Icon").withRenderingMode(.alwaysOriginal)]
        
        let selectedImages: [UIImage] = [#imageLiteral(resourceName: "Selected Card Icon").withRenderingMode(.alwaysOriginal),
                                         #imageLiteral(resourceName: "Selected Heart Icon").withRenderingMode(.alwaysOriginal),
                                         #imageLiteral(resourceName: "Selected Message Icon").withRenderingMode(.alwaysOriginal)]
        
        
        //Assign the list of view controllers
        viewControllers = vcs.enumerated().map { (index, vc) in
            //TODO: Replace tab bar item's with updated images, and gradients for selected
            let navVC = UINavigationController(rootViewController: vc)
            navVC.tabBarItem.image = unselectedImages[index]
            navVC.tabBarItem.selectedImage = selectedImages[index]
            return navVC
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }


}
