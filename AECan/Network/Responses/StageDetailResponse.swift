//
//  StageDetailComponentResponse.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailResponse: Mappable {
    
    var stageName: String?
    var endDate: String?
    var finished: Bool?
    var tabs: [StageDetailTab]?
    var beacons: [Beacon] = []
    var beaconsOptions: [Beacon] = []
    var admitsBeacons: Bool?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        stageName <- map["stage_name"]
        endDate <- map["end_date"]
        finished <- map["finished"]
        tabs <- map["tabs"]
        beaconsOptions <- map["beacons_options"]
        beacons <- map["beacons"]
        admitsBeacons <- map["admits_beacons"]
    }
}
