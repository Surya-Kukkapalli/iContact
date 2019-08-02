//
//  AddContactViewController.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/27/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

// TODO: configure phone number entry to format as they type

class AddContactViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let picNameGroupView = PicNameGroupView()
    private let phoneTextFieldView = ContactInfoView()
    private let emailTextFieldView = ContactInfoView()
    private let doneButton = UIButton(type: .custom)
    private let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItems()
        
        view.addSubview(picNameGroupView)
        view.addSubview(phoneTextFieldView)
        view.addSubview(emailTextFieldView)
        picNameGroupView.configure()
        phoneTextFieldView.configure(withPlaceholder: "add phone", withKeyboardType: UIKeyboardType.numberPad)
        emailTextFieldView.configure(withPlaceholder: "add email", withKeyboardType: UIKeyboardType.alphabet)
        setupViews()
        
        
        picNameGroupView.firstNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.lastNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.circlesTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
    }
    
    @objc private func changeTextToBlack(_ textField: UITextField) {
        if textField.text == "" {
            doneButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            doneButton.setTitleColor(systemBlue, for: .normal)
            doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
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
        
        
        phoneTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        phoneTextFieldView.topAnchor.constraint(equalTo: picNameGroupView.bottomAnchor, constant: 20).isActive = true
        phoneTextFieldView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        phoneTextFieldView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        phoneTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.topAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor, constant: 40).isActive = true
        emailTextFieldView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        emailTextFieldView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
}
