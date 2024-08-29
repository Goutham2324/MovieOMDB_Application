//
//  SplashViewController.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(navigateToTabBar), userInfo: nil, repeats: false)
    }
    
    @objc func navigateToTabBar() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "OMDBTabBarController") as? OMDBTabBarController
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
    }

}


