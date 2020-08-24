//
//  AeternityButton.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 27/04/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class AeternityButton: RoundedButton {
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .white
        layer.borderColor = UIColor.ucGrey280.cgColor
        layer.borderWidth = 1
        imageView?.contentMode = .scaleAspectFit
    }
}
