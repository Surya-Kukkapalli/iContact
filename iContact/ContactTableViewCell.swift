//
//  ContactTableViewCell.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 8/1/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        
        configureContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContraints() {
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // TODO: move text over when in editing mode
        if self.isEditing {
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35).isActive = true
        } else {
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        }
    }
    
}

extension UILabel {
    func boldChange(fullText: String, boldText: String, ofSize: CGFloat) {
        let strNumber: NSString = fullText as NSString
        let boldRange = (strNumber).range(of: boldText)
        let attribute = NSMutableAttributedString(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: ofSize), range: boldRange)
        
        self.attributedText = attribute
    }
}
