//
//  ComponentKeyValueArray.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailKeyValueArrayComponent: StageDetailComponent {
    
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
    
    var items: [Item] = []
    
    // MARK: - Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        items <- map["items"]
    }
}
