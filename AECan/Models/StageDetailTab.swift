//
//  StageDetailTabTab.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailTab: Mappable {
    
    var title: String?
    var badge: String?
    var emptyMessage: String?
    var components: [StageDetailComponent] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        badge <- map["badge"]
        emptyMessage <- map["empty_message"]
        components <- (map["components"], ComponentArrayTransform())
    }
}
