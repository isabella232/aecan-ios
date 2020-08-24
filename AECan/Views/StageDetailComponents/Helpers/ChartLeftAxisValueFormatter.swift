//
//  ChartLeftAxisValueFormatter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Charts

class ChartLeftAxisValueFormatter: IAxisValueFormatter {
    let unit: String
    
    init(unit: String) {
        self.unit = unit
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(format: "%.2f", value) + " \(unit)"
    }

}
