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
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
