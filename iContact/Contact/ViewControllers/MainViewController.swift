//
//  ViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

/* Todo:
 *      swipe to add to fav
 */

class MainViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var contacts = [Contact]()
    var firstLetterArray = [Character]()
    var filteredContacts = [Contact]()
    let cellId = "ContactTableViewCell"
    let cardId = "LargePictureTableViewCell"
    var isFavorites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        refreshControl = UIRefreshControl()
        configureRefreshControl()
        
        contacts = createContactsArray()
        
        self.tableView.register(LargePictureTableViewCell.self, forCellReuseIdentifier: cardId)
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellId)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isFavorites {
            self.reduceContactsArray()
        }
        
        tableView.reloadData()
    }
    
    func reduceContactsArray() {
        let sortedContacts = contacts.sorted(by: { $0.lastName! < $1.lastName! })
        if let favoritesArray = UserDefaults.standard.array(forKey: "Favorite") as? [String] {
            let filtered = sortedContacts.filter { favoritesArray.contains($0.firstName!) }
            self.contacts = filtered
        }
    }

    @objc func addButtonPressed() {
        let addContactVC = AddContactViewController()
        navigationController?.pushViewController(addContactVC, animated: true)
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
extension MainViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        for contact in contacts {
            let firstLetter = contact.lastName!.first!
            if !firstLetterArray.contains(firstLetter) {
                firstLetterArray.append(firstLetter)
            }
        }
        
        return firstLetterArray.count + 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        var numberOfNames: Int = 0
        
        if section == 0 {
            if isFiltering() {
                return 0
            } else {
                return 1
            }
        } else {
            if !isFiltering() {
                for contact in contacts {
                    let sortedFirstLetterArray = firstLetterArray.sorted(by: <)
                    if sortedFirstLetterArray[section - 1] == contact.lastName!.first! {
                        numberOfNames+=1
                    }
                }
            } else {
                for contact in filteredContacts {
                    let sortedFirstLetterArray = firstLetterArray.sorted(by: <)
                    if sortedFirstLetterArray[section - 1] == contact.lastName!.first! {
                        numberOfNames+=1
                    }
                }
            }
            
            return numberOfNames
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ContactTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellId)")
        }
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: cardId) as? LargePictureTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cardId)")
        }
        
        if indexPath.section == 0 {
            myCell.nameLabel.text = "Surya Kukkapalli"
            myCell.descriptionLabel.text = "My Card"
            myCell.profilePic.image = UIImage(named: "profile_pic")
            return myCell
        } else {
            let sortedContacts = contacts.sorted(by: { $0.lastName! < $1.lastName! })
            let sortedLetterArray = firstLetterArray.sorted(by: <)
            var shortenedArray = [Contact]()
            
            // Creating an array of contacts that have the same last name letter as the section header
            for contact in sortedContacts {
                if contact.lastName!.first! == sortedLetterArray[indexPath.section - 1] {
                    shortenedArray.append(contact)
                }
            }
            
            if !isFavorites {
                
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
            } else {
                for contact in sortedContacts {
                    let firstNameArray = UserDefaults.standard.stringArray(forKey: "Favorite") ?? [String]()
                    if contact.firstName! == firstNameArray[indexPath.row] {
                        let name = shortenedArray[indexPath.row].firstName! + " " + shortenedArray[indexPath.row].lastName!
                        cell.nameLabel.boldChange(fullText: name, boldText: shortenedArray[indexPath.row].lastName!, ofSize: 15)
                    }
                }
                return cell
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
            let sortedArray = firstLetterArray.sorted(by: <)
            return String(sortedArray[section - 1])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 45
        }
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
extension MainViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactVC = ContactViewController(nibName: nil, bundle: nil)
        let sortedContacts = contacts.sorted(by: { $0.lastName! < $1.lastName! })
        let sortedLetterArray = firstLetterArray.sorted(by: <)
        var shortenedArray = [Contact]()
        
        if indexPath.section == 0 {
            contactVC.navigationItem.title = "Surya Kukkapalli"
            navigationController?.pushViewController(contactVC, animated: true)
        } else {
            // Creating an array of contacts that have the same last name letter as the section header
            for contact in sortedContacts {
                if contact.lastName!.first! == sortedLetterArray[indexPath.section - 1] {
                    shortenedArray.append(contact)
                }
            }
            contactVC.navigationItem.title = shortenedArray[indexPath.row].firstName! + " " + shortenedArray[indexPath.row].lastName!
            navigationController?.pushViewController(contactVC, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
   
        let confirmDelete = UIAlertController()
        confirmDelete.title = "Are you sure you want to delete this contact?"
        confirmDelete.message = "This cannot be undone."
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            let sortedContacts = self.contacts.sorted(by: { $0.lastName! < $1.lastName! })
            if let firstName = sortedContacts[indexPath.row].firstName {
                var favoritesArray = [firstName]
                // appending this new favorite to the existing favorites array
                if let favorites = UserDefaults.standard.array(forKey: "Favorite") as? [String] {
                    favoritesArray.append(contentsOf: favorites)
                }
                UserDefaults.standard.setValue(favoritesArray, forKey: "Favorite")
                print(favoritesArray)
            }

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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        // If user goes to different view controller, search bar will disappear
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setting up add button
        let addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: addButton)
        
        // Setting up edit button
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.leftBarButtonItem = editButton
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
//        self.tableView.reloadData()
        print("hello, world")
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
}

// MARK: Search Bar methods
extension MainViewController: UISearchResultsUpdating {
    
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

// MARK: Making data
extension MainViewController {
    private func makeFakeContact(firstName: String?, lastName: String?, circle: Circle?, phone: String?, email: String?, image: UIImage?) -> Contact {
        return Contact(firstName: firstName, lastName: lastName, circle: circle, phone: phone, email: email, image: image)
    }
    
    private func makeCircle(name: String, count: Int) -> Circle {
        return Circle(name: name, picture: nil, memberCount: count)
    }
    
    public func createContactsArray() -> [Contact] {
        var contactArray = [Contact]()
        contactArray.append(makeFakeContact(firstName: "Frank", lastName: "Underwood", circle: makeCircle(name: "The White House", count: 0), phone: "630-418-7666", email: "iampresident@thewhitehouse.gov", image: nil))
        contactArray.append(makeFakeContact(firstName: "Claire", lastName: "Underwood", circle: makeCircle(name: "The White House", count: 0), phone: "630-342-4957", email: "iamfirstlady@thewhitehouse.gov", image: nil))
        contactArray.append(makeFakeContact(firstName: "Remy", lastName: "Danton", circle: makeCircle(name: "Glendon Hill", count: 0), phone: "603-683-5895", email: "iamprettycool@glendonhill.net", image: nil))
        contactArray.append(makeFakeContact(firstName: "Bob", lastName: "Birch", circle: makeCircle(name: "The White House", count: 0), phone: "493-324-3523", email: "irunthehouse@thewhitehouse.gov", image: nil))
        contactArray.append(makeFakeContact(firstName: "Doug", lastName: "Stamper", circle: makeCircle(name: "The White House", count: 0), phone: "502-239-2348", email: "ihearttheprez@thewhitehouse.gov", image: nil))
        contactArray.append(makeFakeContact(firstName: "Cathy", lastName: "Durant", circle: makeCircle(name: "The White House", count: 0), phone: "432-325-3251", email: "iamsecretaryofstate@thewhitehouse.gov", image: nil))
        contactArray.append(makeFakeContact(firstName: "Seth", lastName: "Grayson", circle: makeCircle(name: "The White House", count: 0), phone: "512-324-1413", email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Zoe", lastName: "Barnes", circle: makeCircle(name: "The Washington Post", count: 0), phone: "342-513-7653", email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Tom", lastName: "Hammersmidt", circle: makeCircle(name: "The Washington Post", count: 0), phone: "352-613-1613", email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Jackie", lastName: "Sharp", circle: makeCircle(name: "The White House", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Heather", lastName: "Dunbar", circle: makeCircle(name: "The White House", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Janine", lastName: "Skorsky", circle: makeCircle(name: "The Washington Post", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Fake", lastName: "Sname", circle: makeCircle(name: "Glendon Hill", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Fake", lastName: "Dname", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Leann", lastName: "Harvey", circle: makeCircle(name: "The White House", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Rachel", lastName: "Posner", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Ed", lastName: "Meechum", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Garrett", lastName: "Walker", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Linda", lastName: "Vasquez", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Lucas", lastName: "Goodwin", circle: makeCircle(name: "The Washington Post", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Tom", lastName: "Yates", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Christina", lastName: "Gallager", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Peter", lastName: "Russo", circle: makeCircle(name: "The White House", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Raymond", lastName: "Tusk", circle: nil, phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Gavin", lastName: "Orsay", circle: makeCircle(name: "NSA", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Aiden", lastName: "McAllen", circle: makeCircle(name: "NSA", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Terry", lastName: "Womack", circle: makeCircle(name: "The White House", count: 0), phone: nil, email: nil, image: nil))
        contactArray.append(makeFakeContact(firstName: "Nathan", lastName: "Green", circle: makeCircle(name: "NSA", count: 0), phone: nil, email: "topsecretemail.nsa.gov", image: nil))
        return contactArray
    }
}
