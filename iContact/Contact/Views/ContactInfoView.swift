//
//  ContactInfoTextField.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/31/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class ContactInfoView: UIView {
    
    let addButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "add")
        return image
    }()
    
    let infoTextField: UITextField = {
        let field = UITextField()
        field.textColor = .lightGray
        field.font = UIFont.systemFont(ofSize: 17)
        field.textAlignment = .left
        field.clearButtonMode = .whileEditing
        field.textColor = .black
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public func configure(withPlaceholder: String, withKeyboardType: UIKeyboardType) {
        // TODO: change color of placeholder text to black
        let changedString: NSString = withPlaceholder as NSString
        let range = (changedString).range(of: withPlaceholder)
        let attribute = NSMutableAttributedString.init(string: withPlaceholder)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        infoTextField.placeholder = attribute.string
        infoTextField.keyboardType = withKeyboardType
        self.addSubview(infoTextField)
        self.addSubview(separatorView)
        self.addSubview(addButtonImage)
        configureConstraints()
    }
    
    private func configureConstraints() {
        infoTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36).isActive = true
        infoTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        infoTextField.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: infoTextField.leftAnchor, constant: 13).isActive = true
        separatorView.topAnchor.constraint(equalTo: infoTextField.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addButtonImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        addButtonImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        addButtonImage.rightAnchor.constraint(equalTo: infoTextField.leftAnchor).isActive = true
        addButtonImage.bottomAnchor.constraint(equalTo: infoTextField.bottomAnchor).isActive = true
    }
    
}
