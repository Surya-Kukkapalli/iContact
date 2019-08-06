//
//  MyCardCell.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 8/5/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class MyCardTableViewCell: UITableViewCell {
    
    public let profilePic: UIImageView = {
        let pic = UIImageView()
        pic.backgroundColor = .gray
        pic.roundedImage()
        pic.image = UIImage(named: "profile_pic")
        pic.layer.cornerRadius = 35
        pic.layer.masksToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 19)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.bringSubviewToFront(label)
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Card"
        label.superview?.bringSubviewToFront(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(profilePic)
        
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(profilePic)
        
        configureContraints()
        
//        self.superview?.bringSubviewToFront(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContraints() {
        let distAwayFromLeft: CGFloat = 90
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: distAwayFromLeft).isActive = true
//        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/3).isActive = true
//        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: -40).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: distAwayFromLeft).isActive = true
//        descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
//        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        profilePic.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profilePic.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
//        profilePic.rightAnchor.constraint(equalTo: self.nameLabel.leftAnchor, constant: -15).isActive = true
//        profilePic.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        profilePic.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -17).isActive = true
        profilePic.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -17).isActive = true
    }
    
}
