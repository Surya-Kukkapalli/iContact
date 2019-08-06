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
    
    @objc func showEditing(_ sender: UIBarButtonItem) {
        print("editing")
    }
    
}

// MARK: Navigation
extension ContactViewController {
    private func setupNavigationBarItems(){
        navigationItem.largeTitleDisplayMode = .never
        
        // Setting up edit button
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        self.navigationItem.rightBarButtonItem = editButton
    }
}
