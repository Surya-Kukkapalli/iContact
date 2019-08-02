//
//  PicNameGroupView.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/30/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class PicNameGroupView: UIView {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contactPic: UIImageView = {
        let pic = UIImageView()
        pic.backgroundColor = .gray
        pic.layer.borderWidth = 1
        pic.layer.borderColor = UIColor.lightGray.cgColor
        pic.roundedImage()
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    let firstNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "First name"
        field.textColor = .lightGray
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .left
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let lastNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last name"
        field.textColor = .lightGray
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .left
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let circlesTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Company"
        field.textColor = .lightGray
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .left
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public func configure() {
//        self.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        self.addSubview(inputsContainerView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        inputsContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputsContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true
        inputsContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        inputsContainerView.addSubview(firstNameTextField)
        inputsContainerView.addSubview(contactPic)
        inputsContainerView.addSubview(separatorView1)
        inputsContainerView.addSubview(lastNameTextField)
        inputsContainerView.addSubview(separatorView2)
        inputsContainerView.addSubview(circlesTextField)
        inputsContainerView.addSubview(separatorView3)
        
        firstNameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        contactPic.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        contactPic.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contactPic.widthAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        contactPic.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView1.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lastNameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView2.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        circlesTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        circlesTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor).isActive = true
        circlesTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        circlesTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        separatorView3.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        separatorView3.topAnchor.constraint(equalTo: circlesTextField.bottomAnchor).isActive = true
        separatorView3.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
}

extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}
