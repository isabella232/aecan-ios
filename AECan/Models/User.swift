//
//  User.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var password: String?
    
    init() {}
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
    
    }
}
