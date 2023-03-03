//
//  CustomViewController.swift
//  movie-app
//
//  Created by TuanDQ on 03/03/2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    @IBOutlet weak var customTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar.unselectedItemTintColor = .white.withAlphaComponent(0.75)
    }
}
