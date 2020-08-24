//
//  ApiRepositoryError.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiRepositoryError: HttpRepositoryError {
    
    var httpStatusCode: Int?
    var message: String?
    var keyword: String?
    
    required init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        message <- map["message"]
        keyword <- map["keyword"]
    }
}
