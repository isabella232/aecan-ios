//
//  StageDetailChartComponent.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailChartComponent: StageDetailComponent {
    
    class Entry: Mappable {
        var index: Int?
        var label: String?
        var value: Double?
        
        required init?(map: Map) {}
        func mapping(map: Map) {
            index <- map["index"]
            label <- map["label"]
            value <- map["value"]
            
        }
    }
    
    class Series: Mappable {
        var label: String?
        var entries: [Entry] = []
        
        required init?(map: Map) {}
        func mapping(map: Map) {
            label <- map["label"]
            entries <- map["entries"]
        }
    }

    var title: String?
    var series: [Series] = []
    var entries: [Entry] = []
    var unit: String?
    var componentAction: StageDetailComponentAction?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["title"]
        entries <- map["entries_list"]
        series <- map["chart_series"]
        unit <- map["unit"]
        componentAction <- map["component_action"]
    }
}
