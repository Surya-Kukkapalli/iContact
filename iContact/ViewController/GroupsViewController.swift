//
//  GroupsViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class GroupsViewController: UITableViewController {

    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
    }
    
    private func setupNavigationBarItems(){
        navigationItem.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        //        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: addButton)
    }

}

// MARK: Refresh control
extension GroupsViewController {
    
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
