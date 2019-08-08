//
//  Contact.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/28/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

struct Contact: Equatable {
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    let firstName: String?
    let lastName: String?
    // make type Circle?
    let circle: Circle?
    let phone: String?
    let email: String?
    let image: UIImage?
}

