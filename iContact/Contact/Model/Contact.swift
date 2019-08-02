//
//  Contact.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/28/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

struct Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        if lhs.lastName!.first! != rhs.lastName!.first! {
            return lhs.lastName!.first! < rhs.lastName!.first!
        } else {
            return lhs.firstName!.first! < rhs.firstName!.first!
        }
    }
    
    let firstName: String?
    let lastName: String?
    // make type Circle?
    let circle: String?
    let phone: String?
    let email: String?
    let image: UIImage?
}
