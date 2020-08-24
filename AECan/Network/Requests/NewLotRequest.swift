//
//  NewLotRequest.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class NewLotRequest: Mappable {
    
    var identifier: String?
    
    var beacons: [Beacon] = [] {
        didSet { beaconsIds = beacons.compactMap({ $0.id }) }
    }
    private var beaconsIds: [Int] = []
    
    var variety: Variety? {
        didSet { varietyId = variety?.id }
    }
    private var varietyId: Int?
    
    var startDate: String?
    var plantsQuantity: Int?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        identifier <- map["identifier"]
        beaconsIds <- map["beacon_ids"]
        varietyId <- map["variety_id"]
        startDate <- map["start_date"]
        plantsQuantity <- map["plants_quantity"]
    }
}
