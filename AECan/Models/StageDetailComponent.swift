//
//  StageDetailComponent.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailComponent: Mappable {
    
    enum ComponentType: String, CaseIterable { // Component type and its key in the JSON
        case keyValueArray = "component_key_value_array"
        case valueEditArray = "component_value_edit_array"
        case valueListArray = "component_value_list_array"
        case proceduresList = "component_procedures_list"
        case chart = "component_chart"
    }
    
    var componentType: ComponentType?
    var order: Int?
    var editable: Bool = false
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        componentType <- (map["component_type"], EnumTransform<ComponentType>())
        order <- map["order"]
        editable <- map["editable"]
    }
}
