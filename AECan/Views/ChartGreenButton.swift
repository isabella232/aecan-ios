//
//  ChartGreenButton.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class ChartSeriesSelectionButton: RoundedButton {
    
    override func commonInit() {
        self.fontSize = 14
        self.height = 24
        super.commonInit()
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        self.backgroundColor = .mainColor150
    }
}



