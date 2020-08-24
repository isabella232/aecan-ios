//
//  OAuthRepositoryError.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class OAuthRepositoryError: HttpRepositoryError {
    
    var httpStatusCode: Int?
    var message: String?
    
    required init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        message <- map["error_description"]
    }
}
