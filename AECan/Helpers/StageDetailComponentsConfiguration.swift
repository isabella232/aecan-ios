//
//  StageDetailComponentsConfiguration.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

extension StageDetailComponent.ComponentType {
    
    var cellName: String {
        switch self {
        case .keyValueArray: return "StageDetailKeyValueArrayComponentCell"
        case .valueEditArray: return "StageDetailValueEditArrayComponentCell"
        case .valueListArray: return "StageDetailValueListArrayComponentCell"
        case .proceduresList: return "StageDetailProceduresListComponentCell"
        case .chart: return "StageDetailChartComponentCell"
        }
    }
    
    func instantiateComponent(from json: [String: Any]) -> StageDetailComponent? {
        switch self {
        case .keyValueArray: return StageDetailKeyValueArrayComponent(JSON: json)
        case .valueEditArray: return StageDetailValueEditArrayComponent(JSON: json)
        case .valueListArray: return StageDetailValueListArrayComponent(JSON: json)
        case .proceduresList: return StageDetailProceduresListComponent(JSON: json)
        case .chart: return StageDetailChartComponent(JSON: json)
        }
    }
}
