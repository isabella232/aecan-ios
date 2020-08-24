//
//  VarietiesResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class VarietiesResponse: Mappable {
    var varieties: [Variety]?
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        varieties <- map["varieties"]
    }
}
