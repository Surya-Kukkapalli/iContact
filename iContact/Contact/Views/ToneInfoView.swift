//
//  ToneInfoView.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 8/8/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class ToneInfoView: UIView {
    
    let toneNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let defaultLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        label.font = .systemFont(ofSize: 18)
        label.text = "Default"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let disclosureImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "disclosure")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public func configure(withTone: String) {
        toneNameLabel.text = withTone
        self.addSubview(toneNameLabel)
        self.addSubview(defaultLabel)
        self.addSubview(disclosureImage)
        self.addSubview(separatorView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        toneNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        toneNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        toneNameLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        toneNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1).isActive = true
        
        defaultLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        defaultLabel.leftAnchor.constraint(equalTo: toneNameLabel.rightAnchor, constant: 20).isActive = true
        defaultLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        defaultLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -1).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        separatorView.topAnchor.constraint(equalTo: toneNameLabel.bottomAnchor, constant: -2).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        disclosureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        disclosureImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        disclosureImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 20).isActive = true
        disclosureImage.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        disclosureImage.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        disclosureImage.contentMode = .scaleAspectFit
        
    }
    
}
