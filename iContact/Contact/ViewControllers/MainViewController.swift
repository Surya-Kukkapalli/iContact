//
//  ViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

/* Todo:
 *      search bar
 *      swipe to add to fav
 */

class MainViewController: UITableViewController {

    // TODO: replace with custom search controller like in map app
    let searchController = UISearchController(searchResultsController: nil)
    
    var contacts = [Contact]()
    var firstLetterArray = [Character]()
    let cellId = "ContactTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        refreshControl = UIRefreshControl()
        configureRefreshControl()
        
        createContactsArray()
        
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func addButtonPressed() {
        let addContactVC = AddContactViewController()
        navigationController?.pushViewController(addContactVC, animated: true)
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
        
        return firstLetterArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        var numberOfNames: Int = 0
        for contact in contacts {
            let sortedFirstLetterArray = firstLetterArray.sorted(by: <)
            if sortedFirstLetterArray[section] == contact.lastName!.first! {
                numberOfNames+=1
            }
        }
        return numberOfNames
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ContactTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellId)")
        }
        
        let sortedContacts = contacts.sorted(by: <)
        let sortedLetterArray = firstLetterArray.sorted(by: <)
        var shortenedArray = [Contact]()
        
        // Creating an array of contacts that have the same last name letter as the section header
        for contact in sortedContacts {
            if contact.lastName!.first! == sortedLetterArray[indexPath.section] {
                shortenedArray.append(contact)
            }
        }
        
        // Setting the cell to the person's name from the above array depending on which cell. Last name is bold
        let name = shortenedArray[indexPath.row].firstName! + " " + shortenedArray[indexPath.row].lastName!
        cell.nameLabel.boldChange(fullText: name, boldText: shortenedArray[indexPath.row].lastName!, ofSize: 15)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedArray = firstLetterArray.sorted(by: <)
        return String(sortedArray[section])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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

extension MainViewController {
    private func makeFakeContact(firstName: String?, lastName: String?, circle: String?, phone: String?, email: String?, image: UIImage?) -> Contact {
        return Contact(firstName: firstName, lastName: lastName, circle: circle, phone: phone, email: email, image: image)
    }
    
    private func createContactsArray() {
        contacts.append(makeFakeContact(firstName: "Frank", lastName: "Underwood", circle: "The White House", phone: "630-418-7666", email: "iampresident@thewhitehouse.gov", image: nil))
        contacts.append(makeFakeContact(firstName: "Claire", lastName: "Underwood", circle: "The White House", phone: "630-342-4957", email: "iamfirstlady@thewhitehouse.gov", image: nil))
        contacts.append(makeFakeContact(firstName: "Remy", lastName: "Danton", circle: "Glendon Hill", phone: "603-683-5895", email: "iamprettycool@glendonhill.net", image: nil))
        contacts.append(makeFakeContact(firstName: "Bob", lastName: "Birch", circle: "The White House", phone: "493-324-3523", email: "irunthehouse@thewhitehouse.gov", image: nil))
        contacts.append(makeFakeContact(firstName: "Doug", lastName: "Stamper", circle: "The White House", phone: "502-239-2348", email: "ihearttheprez@thewhitehouse.gov", image: nil))
        contacts.append(makeFakeContact(firstName: "Cathy", lastName: "Durant", circle: "The White House", phone: "432-325-3251", email: "iamsecretaryofstate@thewhitehouse.gov", image: nil))
        contacts.append(makeFakeContact(firstName: "Seth", lastName: "Grayson", circle: "The White House", phone: "512-324-1413", email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Zoe", lastName: "Barnes", circle: "The Washington Post", phone: "342-513-7653", email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Tom", lastName: "Hammersmidt", circle: "The Washington Post", phone: "352-613-1613", email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Jackie", lastName: "Sharp", circle: "The White House", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Heather", lastName: "Dunbar", circle: "The White House", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Janine", lastName: "Skorsky", circle: "The Washington Post", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Fake", lastName: "Sname", circle: "Glendon Hill", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Fake", lastName: "Dname", circle: "Glendon Hill", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Leann", lastName: "Harvey", circle: "The White House", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Rachel", lastName: "Posner", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Ed", lastName: "Meechum", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Garrett", lastName: "Walker", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Linda", lastName: "Vasquez", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Lucas", lastName: "Goodwin", circle: "The Washington Post", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Tom", lastName: "Yates", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Christina", lastName: "Gallager", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Peter", lastName: "Russo", circle: "The White House", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Raymond", lastName: "Tusk", circle: nil, phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Gavin", lastName: "Orsay", circle: "NSA", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Aiden", lastName: "McAllen", circle: "NSA", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Terry", lastName: "Womack", circle: "The White House", phone: nil, email: nil, image: nil))
        contacts.append(makeFakeContact(firstName: "Nathan", lastName: "Green", circle: "NSA", phone: nil, email: "topsecretemail.nsa.gov", image: nil))
    }
}
