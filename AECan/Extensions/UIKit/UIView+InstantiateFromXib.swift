//
//  UIView+InstantiateFromXib.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static func instantiateFromXib() -> Self {
        return UINib(nibName: String(describing: self), bundle: .main)
        .instantiate(withOwner: nil, options: nil).first as! Self
    }
}
