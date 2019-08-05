//
//  ContactViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Should I hide the navig
        view.backgroundColor = .white
        
        setupNavigationBarItems()
    }
    
}

// MARK: Navigation
extension ContactViewController {
    private func setupNavigationBarItems(){
        navigationItem.largeTitleDisplayMode = .never
        
        // Setting up edit button
        let editButton = UIButton(type: .custom)
        editButton.setTitle("Edit", for: .normal)
        let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        editButton.setTitleColor(systemBlue, for: .normal)
        editButton.contentMode = .scaleAspectFit
        //        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
    }
}
