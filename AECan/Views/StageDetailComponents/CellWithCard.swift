//
//  CellWithCard.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol CellWithCard {
    var card: UIView? { get }
}

extension CellWithCard {
    func setupCard() {
        card?.layer.masksToBounds = false
        card?.layer.shadowColor = UIColor.black.cgColor
        card?.layer.shadowOpacity = 0.10
        card?.layer.shadowOffset = CGSize(width: 0, height: 0)
        card?.layer.shadowRadius = 10
    }
}
