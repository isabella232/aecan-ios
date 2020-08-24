//
//  StageFinishCheckResponse.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 02/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageFinishCheckResponse: Mappable {

    var message: String?
    var canBeFinished = false
    
    required init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        message <- map["message"]
        canBeFinished <- map["can_finished"]
    }
}
