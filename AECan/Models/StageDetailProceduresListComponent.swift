//
//  StageDetailProceduresListComponent.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailProceduresListComponent: StageDetailComponent {
    
    class Item: Mappable {
        
        enum State: String {
            case notStarted = "not_started"
            case started = "started"
            case finished = "finished"
            case expired = "expired"
            case cancelled = "cancelled"
        }
        
        var title: String?
        var description: [String] = []
        var message: String?
        var state: State?
        var itemAction: StageDetailComponentAction?
        var buttonText: String?
        
        required init?(map: Map) {}
        func mapping(map: Map) {
            title <- map["title"]
            description <- map["description"]
            message <- map["green_message"]
            state <- (map["state"], EnumTransform<State>())
            itemAction <- map["item_action"]
            buttonText <- map["button_text"]
        }
    }
 
    var title: String?
    var items: [Item] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["title"]
        items <- map["items"]
    }
}
