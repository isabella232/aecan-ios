//
//  SignUpResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 11/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class SignUpResponse: Mappable {
    var email: String?
    var successMessage: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        email <- map["email"]
        successMessage <- map["message"]
    }
}
