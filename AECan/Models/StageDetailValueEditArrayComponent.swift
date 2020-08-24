//
//  ComponentValueEditArray.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailValueEditArrayComponent: StageDetailComponent {
    
    // MARK: - Inner classes
    
    class Item: Mappable {
        
        var key: String?
        var value: String?
        var name: String?
        var itemAction: StageDetailComponentAction?
        
        required init?(map: Map) { }
        
        func mapping(map: Map) {
            key <- map["key"]
            value <- map["value"]
            name <- map["name"]
            itemAction <- map["item_action"]
        }
    }
   
    // MARK: - Properties
    
    var items: [Item] = []
    
    // MARK: - Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        items <- map["items"]
    }
}
