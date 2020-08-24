//
//  Variety.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class Variety: Mappable {
    var id: Int?
    var name: String?
    var shortName: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        shortName <- map["short_name"]
    }
}

extension Variety: SelectorDialogOption {
   
    var textForSelector: String? {
        return shortName
    }
}
