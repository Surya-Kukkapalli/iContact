//
//  TabBarViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup custom view controllers
        let mainVC = MainViewController()
        let contactsNavController = UINavigationController(rootViewController: mainVC)
        contactsNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let circlesVC = CirclesViewController()
        let circlesNavController = UINavigationController(rootViewController: circlesVC)
        circlesNavController.tabBarItem = UITabBarItem(title: "Cirlces", image: UIImage(named: "circles"), tag: 1)
        
        
        
        let favoritesVC = FavoritesViewController()
        let favoritesNavController = UINavigationController(rootViewController: favoritesVC)
        favoritesNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        viewControllers = [contactsNavController, circlesNavController, favoritesNavController]
    }
    
}
