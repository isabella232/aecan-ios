//
//  LotHeaderBackground.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotHeaderBackground: ViewOwnerOfXib {

    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = contentView {
            sendSubviewToBack(contentView)
        }
    }
}
