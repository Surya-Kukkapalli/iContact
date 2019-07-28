//
//  AddContactViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItems()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBarItems() {
        navigationItem.title = "New Contact"
        navigationItem.largeTitleDisplayMode = .never
        
        // Setting up done button
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("Done", for: .normal)
        let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        doneButton.setTitleColor(systemBlue, for: .normal)
        doneButton.contentMode = .scaleAspectFit
        //        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
        
    }
}
