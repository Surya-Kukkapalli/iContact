//
//  FavoritesViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {

    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
    }
    
    private func setupNavigationBarItems(){
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let profileButton = UIButton(type: .contactAdd)
        profileButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        profileButton.contentMode = .scaleAspectFit
        //        profileButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        // Setting up edit button
        let editButton = UIButton(type: .custom)
        editButton.setTitle("Edit", for: .normal)
        let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        editButton.setTitleColor(systemBlue, for: .normal)
        editButton.contentMode = .scaleAspectFit
        //        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editButton)
    }
    
}

// MARK: Refresh control
extension FavoritesViewController {
    
    func configureRefreshControl () {
        // Add the refresh control to your UIScrollView object.
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        // TODO: Update conten
        print("hello world")
        
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
}
