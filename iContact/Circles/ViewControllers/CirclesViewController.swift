//
//  GroupsViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class CirclesViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let mainVC = MainViewController()
    var contacts = [Contact]()
    var circles = [Circle]()
    let circleId = "LargePictureTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        contacts = mainVC.createContactsArray()
        
        // TODO: FIGURE OUT HOW TO GET MEMBER COUNT
        for contact in contacts {
            // If the contact has a circle
            if var optionalCircle = contact.circle {
                if !circles.contains(optionalCircle) {
                    optionalCircle.memberCount = 1
                    circles.append(optionalCircle)
                } else {
                    if let i = circles.firstIndex(where: {$0 == optionalCircle}) {
                        circles[i].memberCount += 1
                    }
                }
            }
        }
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
        
        self.tableView.register(LargePictureTableViewCell.self, forCellReuseIdentifier: circleId)

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

// MARK: TableView Data Source Methods
extension CirclesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let circleCell = tableView.dequeueReusableCell(withIdentifier: circleId) as? LargePictureTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(circleId)")
        }
        
        var sortedCircles = circles.sorted(by: {$0.name < $1.name})
        
        circleCell.nameLabel.text = sortedCircles[indexPath.row].name
        circleCell.descriptionLabel.text = String(sortedCircles[indexPath.row].memberCount) + " members"
        if sortedCircles[indexPath.row].name == "The Washington Post" {
            circleCell.profilePic.image = UIImage(named: "washington_post")
        } else if sortedCircles[indexPath.row].name == "The White House" {
            circleCell.profilePic.image = UIImage(named: "the_white_house")
        } else if sortedCircles[indexPath.row].name == "NSA" {
            circleCell.profilePic.image = UIImage(named: "nsa")
        } else {
            circleCell.profilePic.image = UIImage(named: "circles")
        }
        
        return circleCell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

// MARK: TableView Delegate Methods
extension CirclesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var sortedCircles = circles.sorted(by: {$0.name < $1.name})
        let detailVC = CircleDetailViewController(nibName: nil, bundle: nil)
        let rowCircleName = sortedCircles[indexPath.row].name
        for contact in contacts {
            if let loopCircleName = contact.circle?.name {
                if rowCircleName == loopCircleName {
                    detailVC.circleName = rowCircleName
                    detailVC.contacts.append(contact)
                }
            }
        }
        
        detailVC.navigationItem.title = rowCircleName
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let confirmDelete = UIAlertController()
        confirmDelete.title = "Are you sure you want to delete this circle?"
        confirmDelete.message = "This cannot be undone."
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action: UIContextualAction, sourceView: UIView, actionPerformed: @escaping (Bool) -> Void) in
            
            // configuring actions inside here so actionPerformed can be evaluated upon alert selection
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                actionPerformed(true)
            })
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: { action in
                actionPerformed(false)
            })
            confirmDelete.addAction(yesAction)
            confirmDelete.addAction(noAction)
            self.present(confirmDelete, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
}

// MARK: Navigation
extension CirclesViewController {
    private func setupNavigationBarItems(){
        navigationItem.title = "Circles"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        //        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: addButton)
        
        // Setting up edit button
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.leftBarButtonItem = editButton
    }
}

// MARK: Refresh control
extension CirclesViewController {
    
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
