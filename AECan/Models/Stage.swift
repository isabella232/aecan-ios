//
//  Stage.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 05/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class Stage: Mappable {
    enum StageState: String {
        case pending = "not_started"
        case inProgress = "started"
        case finished = "finished"
    }
    
    var id: Int?
    var name: String?
    var startDate: Date?
    var state: StageState?
    var stateText: String? {
        didSet {
            state = StageState(rawValue: stateText ?? "")
        }
    }
    var endDate: Date?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        startDate <- (map["start_date"], ISODateTransform())
        stateText <- map["state"]
        endDate <- (map["end_date"], ISODateTransform())
    }
}
