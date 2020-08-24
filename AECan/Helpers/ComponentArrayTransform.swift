//
//  ComponentArrayTransform.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class ComponentArrayTransform: TransformType {
    
    public typealias Object = [StageDetailComponent]
    public typealias JSON = String
    
    public init() {}

    open func transformFromJSON(_ value: Any?) -> [StageDetailComponent]? {
        // Cast the JSON array
        guard let jsonArray = value as? [[String: Any]] else { return nil }
        
        // Loop through the JSON array
        return jsonArray.compactMap { (jsonObject) -> StageDetailComponent? in
            
            // For each JSON object inside the array, we instantiate a StageDetailComponent (the general Type)
            // in order to retrieve the component type
            let plainComponent = StageDetailComponent(JSON: jsonObject)
            
            // We instantiate the definitive Type that corresponds to the key
            guard let componentType = plainComponent?.componentType else {
                log.warning("Error retrieving the component type for component json: \(jsonObject)")
                return nil
            }
            
            return componentType.instantiateComponent(from: jsonObject)
        }
    }

    open func transformToJSON(_ value: [StageDetailComponent]?) -> String? {
        fatalError("Not yet implemented")
    }
}
