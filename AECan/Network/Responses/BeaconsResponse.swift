//
//  BeaconsResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class BeaconsResponse: Mappable {
    var beacons: [Beacon]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        beacons <- map["beacons"]
    }
}
