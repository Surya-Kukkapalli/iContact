//
//  Group.swift
//  iContact
//
//  Created by Kukkapalli, Surya on 7/28/19.
//  Copyright © 2019 Kukkapalli, Surya. All rights reserved.
//

import UIKit

struct Circle: Equatable {
    
    static func == (lhs: Circle, rhs: Circle) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var picture: UIImage?
    var memberCount: Int
}
