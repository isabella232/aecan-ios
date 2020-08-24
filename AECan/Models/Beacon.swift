//
//  Beacon.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class Beacon: Mappable {
    var id: Int?
    var identifier: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        identifier <- map["identifier"]
    }
}

extension Beacon: SelectorDialogOption {
   
    var textForSelector: String? {
        return identifier
    }
}
