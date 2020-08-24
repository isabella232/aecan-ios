//
//  SmallBlueButton.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class SmallBlueButton: RoundedButton {
    
    override func commonInit() {
        self.fontSize = 14
        self.height = 35
        super.commonInit()
        self.contentEdgeInsets = UIEdgeInsets(top: 9, left: 24, bottom: 9, right: 24)
        self.backgroundColor = .accentColor100
    }
}



