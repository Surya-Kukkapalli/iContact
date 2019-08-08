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
    private let ringtoneView = ToneInfoView()
    private let texttoneView = ToneInfoView()
    private let urlTextFieldView = ContactInfoView()
    private let addressTextFieldView = ContactInfoView()
    private let birthdayTextFieldView = ContactInfoView()
    private let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
    private let systemBlue = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItems()
        
        view.addSubview(picNameGroupView)
        view.addSubview(phoneTextFieldView)
        view.addSubview(emailTextFieldView)
        view.addSubview(ringtoneView)
        view.addSubview(texttoneView)
        view.addSubview(urlTextFieldView)
        view.addSubview(addressTextFieldView)
        view.addSubview(birthdayTextFieldView)
        picNameGroupView.configure()
        phoneTextFieldView.configure(withPlaceholder: "add phone", withKeyboardType: UIKeyboardType.numberPad)
        emailTextFieldView.configure(withPlaceholder: "add email", withKeyboardType: UIKeyboardType.alphabet)
        ringtoneView.configure(withTone: "Ringtone")
        texttoneView.configure(withTone: "Text Tone")
        urlTextFieldView.configure(withPlaceholder: "add url", withKeyboardType: .alphabet)
        addressTextFieldView.configure(withPlaceholder: "add address", withKeyboardType: .alphabet)
        birthdayTextFieldView.configure(withPlaceholder: "add birthday", withKeyboardType: .alphabet)
        // Clears text field when user clicks
        phoneTextFieldView.infoTextField.addTarget(self, action: #selector(phoneFieldDidBeginEditing), for: .editingDidBegin)
        emailTextFieldView.infoTextField.addTarget(self, action: #selector(emailFieldDidBeginEditing), for: .editingDidBegin)
        urlTextFieldView.infoTextField.addTarget(self, action: #selector(urlFieldDidBeginEditing), for: .editingDidBegin)
        addressTextFieldView.infoTextField.addTarget(self, action: #selector(addressFieldDidBeginEditing), for: .editingDidBegin)
        birthdayTextFieldView.infoTextField.addTarget(self, action: #selector(birthdayFieldDidBeginEditing), for: .editingDidBegin)
        setupViews()
        
        picNameGroupView.firstNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.lastNameTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
        picNameGroupView.circlesTextField.addTarget(self, action: #selector(changeTextToBlack), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    @objc public func phoneFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = "Phone"
    }
    
    @objc public func emailFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = "Email"
    }
    
    @objc public func urlFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = "URL"
    }
    
    @objc public func addressFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = "Address"
    }
    
    @objc public func birthdayFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.placeholder = "Birthday"
    }
    
    @objc private func changeTextToBlack(_ textField: UITextField) {
        if textField.text == "" {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = systemBlue
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
        
        ringtoneView.translatesAutoresizingMaskIntoConstraints = false
        ringtoneView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 45).isActive = true
        ringtoneView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        ringtoneView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        ringtoneView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        texttoneView.translatesAutoresizingMaskIntoConstraints = false
        texttoneView.topAnchor.constraint(equalTo: ringtoneView.bottomAnchor, constant: 42).isActive = true
        texttoneView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        texttoneView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        texttoneView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        urlTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        urlTextFieldView.topAnchor.constraint(equalTo: texttoneView.bottomAnchor, constant: 48).isActive = true
        urlTextFieldView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        urlTextFieldView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        urlTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addressTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        addressTextFieldView.topAnchor.constraint(equalTo: urlTextFieldView.bottomAnchor, constant: 40).isActive = true
        addressTextFieldView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        addressTextFieldView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        addressTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        birthdayTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        birthdayTextFieldView.topAnchor.constraint(equalTo: addressTextFieldView.bottomAnchor, constant: 40).isActive = true
        birthdayTextFieldView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 13).isActive = true
        birthdayTextFieldView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -20).isActive = true
        birthdayTextFieldView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}

// MARK: Navigation
extension AddContactViewController {
    private func setupNavigationBarItems() {
        navigationItem.title = "New Contact"
        navigationItem.largeTitleDisplayMode = .never
        
        // Setting up done button
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
    }
}

// TODO: get phone number and email formatting to work
extension String {
    
    public func phoneNumberInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.maximumIntegerDigits = 10
        formatter.minimumIntegerDigits = 10
        
        var amountWithPrefix = self
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: "")
        
        let num = (amountWithPrefix as NSString).intValue
        number = NSNumber(value: num)
        
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
