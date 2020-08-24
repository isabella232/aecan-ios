//
//  Lot.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class Lot: Mappable {
    
    enum Status: String {
        case started = "started"
        case finished = "finished"
    }
    
    var id: Int?
    var plantsQuantity: Int?
    var startDate: Date?
    var startDateString: String?
    var endDate: Date?
    var endDateString: String?
    var irrigationType: String? // should be improved
    var identifier: String?
    var varietyShortName: String?
    var weight: String?
    var status: Status?
    var statusString: String? {
        didSet {
            status = Status(rawValue: statusString ?? "")
        }
    }
    var currentStage: Stage?
    var stages: [Stage]?
    var beacons: [Beacon]?
    var pdfUrl: String?
    var hasPdf = false
    var aeternityLink: String?
    
    var hasAeternityLink: Bool {
        if let aeternityLink = aeternityLink {
            return !aeternityLink.isEmpty
        }
        return false
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        plantsQuantity <- map["plants_quantity"]
        startDate <- (map["start_date"], ISODateTransform())
        startDateString <- map["start_date"]
        endDateString <- map["end_date"]
        endDate <- (map["end_date"], ISODateTransform())
        irrigationType <- map["irrigation_type"]
        identifier <- map["identifier"]
        varietyShortName <- map["variety_short_name"]
        weight <- map["weight"]
        statusString <- map["status"]
        currentStage <- map["current_stage"]
        stages <- map["stages"]
        beacons <- map["beacons"]
        pdfUrl <- map["pdf_url"]
        hasPdf <- map["has_pdf"]
        aeternityLink <- map["aeternity_link"]
    }
}
