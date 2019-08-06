//
//  CircleDetailViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 8/6/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class CircleDetailViewController: UITableViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    var circleName: String = ""
    var contacts = [Contact]()
    var firstLetterArray = [Character]()
    var filteredContacts = [Contact]()
    let cellId = "ContactTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        refreshControl = UIRefreshControl()
        configureRefreshControl()
        
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func addButtonPressed() {
        // TODO: Change later, temporarily this
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
}

// MARK: TableView Data Source Methods
extension CircleDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        for contact in contacts {
            let firstLetter = contact.lastName!.first!
            if !firstLetterArray.contains(firstLetter) {
                firstLetterArray.append(firstLetter)
            }
        }
        
        return firstLetterArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        var numberOfNames: Int = 0
        
        if !isFiltering() {
            for contact in contacts {
                let sortedFirstLetterArray = firstLetterArray.sorted(by: <)
                if sortedFirstLetterArray[section] == contact.lastName!.first! {
                    numberOfNames+=1
                }
            }
        } else {
            for contact in filteredContacts {
                let sortedFirstLetterArray = firstLetterArray.sorted(by: <)
                if sortedFirstLetterArray[section] == contact.lastName!.first! {
                    numberOfNames+=1
                }
            }
        }
        
        return numberOfNames
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellId)")
        }
        
        let sortedContacts = contacts.sorted(by: { $0.lastName! < $1.lastName! })
        let sortedLetterArray = firstLetterArray.sorted(by: <)
        var shortenedArray = [Contact]()
        
        // Creating an array of contacts that have the same last name letter as the section header
        for contact in sortedContacts {
            if contact.lastName!.first! == sortedLetterArray[indexPath.section] {
                shortenedArray.append(contact)
            }
        }
        
        // Setting the cell to the person's name from the above array depending on which cell. Last name is bold
        var name: String
        if !isFiltering() {
            name = shortenedArray[indexPath.row].firstName! + " " + shortenedArray[indexPath.row].lastName!
            cell.nameLabel.boldChange(fullText: name, boldText: shortenedArray[indexPath.row].lastName!, ofSize: 15)
        } else {
            name = filteredContacts[indexPath.row].firstName! + " " + filteredContacts[indexPath.row].lastName!
            cell.nameLabel.boldChange(fullText: name, boldText: filteredContacts[indexPath.row].lastName!, ofSize: 15)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedArray = firstLetterArray.sorted(by: <)
        return String(sortedArray[section])
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Removes other headers when user searches for contact
        if tableView.numberOfRows(inSection: section) > 0 {
            return 24
        } else {
            return 0
        }
    }
}

// MARK: TableView Delegate Methods
extension CircleDetailViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactVC = ContactViewController(nibName: nil, bundle: nil)
        let sortedContacts = contacts.sorted(by: { $0.lastName! < $1.lastName! })
        let sortedLetterArray = firstLetterArray.sorted(by: <)
        var shortenedArray = [Contact]()
        
        
        // Creating an array of contacts that have the same last name letter as the section header
        for contact in sortedContacts {
            if contact.lastName!.first! == sortedLetterArray[indexPath.section] {
                shortenedArray.append(contact)
            }
        }
        contactVC.navigationItem.title = shortenedArray[indexPath.row].firstName! + " " + shortenedArray[indexPath.row].lastName!
        navigationController?.pushViewController(contactVC, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let confirmDelete = UIAlertController()
        confirmDelete.title = "Are you sure you want to delete this contact?"
        confirmDelete.message = "This cannot be undone."
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            actionPerformed(true)
        }
        
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
        
        return UISwipeActionsConfiguration(actions: [favoriteAction,deleteAction])
        
        
    }
}

// MARK: Search Bar methods
extension CircleDetailViewController: UISearchResultsUpdating {
    
    // UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // Private instance methods
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter({ ( contact : Contact ) -> Bool in
            // TODO: figure out how to do by last name too
            return contact.firstName!.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

// MARK: Navigation
extension CircleDetailViewController {
    private func setupNavigationBarItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)

    }
}

// MARK: Refresh control
extension CircleDetailViewController {
    
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


