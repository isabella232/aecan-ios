//
//  LotsResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class LotsResponse: Mappable {
    var lots: [Lot]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        lots <- map["lots"]
    }
}
