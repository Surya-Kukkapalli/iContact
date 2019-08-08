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
//        image.blink()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let infoTextField: UITextField = {
        let field = UITextField()
        field.textColor = .lightGray
        field.font = UIFont.systemFont(ofSize: 15)
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
        infoTextField.text = withPlaceholder
        infoTextField.keyboardType = withKeyboardType
        self.addSubview(infoTextField)
        self.addSubview(separatorView)
        self.addSubview(addButtonImage)
        configureConstraints()
    }
    
    private func configureConstraints() {
        infoTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 36).isActive = true
        infoTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        infoTextField.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorView.topAnchor.constraint(equalTo: infoTextField.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addButtonImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        addButtonImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 4).isActive = true
        addButtonImage.rightAnchor.constraint(equalTo: infoTextField.leftAnchor, constant: -4).isActive = true
        addButtonImage.bottomAnchor.constraint(equalTo: infoTextField.bottomAnchor,constant: -4).isActive = true
        
        addButtonImage.frame = CGRect(x: 0, y: 0, width: 27, height: 27)
        addButtonImage.contentMode = .scaleAspectFit
    }
    
}

extension UIImageView {
    func blink() {
        self.alpha = 0.2
        UIImageView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
