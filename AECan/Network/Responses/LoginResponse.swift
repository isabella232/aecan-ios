//
//  LoginResponse.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 28/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {
    
    var accessToken: String?
    var refreshToken: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }
}
