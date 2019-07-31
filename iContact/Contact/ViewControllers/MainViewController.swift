//
//  ViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

/* Todo:
 *      configure cells
 *      search bar
 *      swipe to add to fav
 *
 */

class MainViewController: UITableViewController {

    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    
    var contacts = [[Contact]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        refreshControl = UIRefreshControl()
        configureRefreshControl()
    }
    
    @objc func addButtonPressed() {
        let addContactVC = AddContactViewController()
        navigationController?.pushViewController(addContactVC, animated: true)
    }
    

}

// MARK: TableView Data Source Methods
extension MainViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return contacts.count
        return 5
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
//        return contacts[section].count
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ask for a cell of the appropriate type.
//        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let cell = UITableViewCell()
        // Configure the cell’s contents with the row and section number.
        // The Basic cell style guarantees a label view is present in textLabel.
        cell.textLabel!.text = "Contact \(indexPath.row)"
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let alphabetArray = ["A","B","C","D","E"]
        return alphabetArray[section]
    }
}

// MARK: TableView Delegate Methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactVC = ContactViewController(nibName: nil, bundle: nil)
        // TODO: Pass data over based on indexPath.row
        navigationController?.pushViewController(contactVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // TODO: FIGURE OUT HOW TO DO THIS
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
//        let completeAction = UIContextualAction(style: .normal, title: "Favorite") { (action:UIContextualAction, sourceView:UIView, actionPerformed:(Bool) -> Void) in
//            if let dbn = self.schools[indexPath.row].dbn {
//                var favoritesArray = [dbn]
//                // creating new array and adding this school to the array, if the array already exists then just add to it
//                if let favorites = UserDefaults.standard.array(forKey: "Favorite") as? [String] {
//                    favoritesArray.append(contentsOf: favorites)
//                }
//                // line to store it on the phone
//                UserDefaults.standard.setValue(favoritesArray, forKey: "Favorite")
//            }
//            actionPerformed(true)
//        }
//
//        return UISwipeActionsConfiguration(actions: [completeAction])
//    }
}

// MARK: Navigation
extension MainViewController {
    private func setupNavigationBarItems(){
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: addButton)
        
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
extension MainViewController {
    
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
