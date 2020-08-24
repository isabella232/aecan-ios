//
//  LotResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class LotResponse: Mappable {
    var lot: Lot?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        lot <- map["lot"]
    }
}
