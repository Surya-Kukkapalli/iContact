//
//  AddContactViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let picNameGroupView = PicNameGroupView()
    let doneButton = UIButton(type: .custom)
    let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItems()
        
        view.addSubview(picNameGroupView)
        setupViews()
        picNameGroupView.configure()
        
        picNameGroupView.firstNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.lastNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.circlesTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
    }
    
    @objc private func changeTextToBlack(_ textField: UITextField) {
        if textField.text == "" {
            doneButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            doneButton.setTitleColor(systemBlue, for: .normal)
        }
        textField.textColor = .black
    }
    
    @objc private func doneButtonPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

// MARK: View Configuration
extension AddContactViewController {
    private func setupViews() {
        let picNameGroupViewHeight: CGFloat = 143
        let safeArea = view.safeAreaLayoutGuide
        picNameGroupView.translatesAutoresizingMaskIntoConstraints = false
        picNameGroupView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        picNameGroupView.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: picNameGroupViewHeight).isActive = true
        picNameGroupView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        picNameGroupView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: Navigation
extension AddContactViewController {
    private func setupNavigationBarItems() {
        navigationItem.title = "New Contact"
        navigationItem.largeTitleDisplayMode = .never
        
        // Setting up done button
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.lightGray, for: .normal)
        doneButton.contentMode = .scaleAspectFit
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
}
