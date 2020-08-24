//
//  StageDetailValueListArrayComponent.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 27/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailValueListArrayComponent: StageDetailComponent {
    
    // MARK: - Inner classes
    
    class Item: Mappable {
        var name: String?
        var value: String?
        
        required init?(map: Map) { }
        func mapping(map: Map) {
            name <- map["name"]
            value <- map["value"]
        }
    }
    
    // MARK: - Properties

    var title: String?
    var minAmountOfItemsToShow: Int?
    var items: [Item] = []
    var componentAction: StageDetailComponentAction?
    var deleteAction: StageDetailComponentAction?
    
    // MARK: - Mappping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["title"]
        minAmountOfItemsToShow <- map["min_amount_of_items_to_show"]
        items <- map["items"]
        componentAction <- map["component_action"]
        deleteAction <- map["delete_action"]
    }
}
