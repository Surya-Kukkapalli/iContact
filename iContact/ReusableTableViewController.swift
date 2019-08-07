//
//  ReusableTableViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 8/6/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class ReusableTableViewController: UITableViewController {
    
    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
    }
    
    @objc func addButtonPressed() {
        // TODO: Change later, temporarily this
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func showEditing(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing {
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
        } else {
            self.tableView.isEditing = true
            self.navigationItem.leftBarButtonItem?.title = "Done"
        }
        //        self.tableView.reloadData()
    }
    
}

// MARK: Navigation
extension ReusableTableViewController {
    private func setupNavigationBarItems(){
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
        // Setting up edit button
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.leftBarButtonItem = editButton
    }
}

// MARK: Refresh control
extension ReusableTableViewController {
    
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
