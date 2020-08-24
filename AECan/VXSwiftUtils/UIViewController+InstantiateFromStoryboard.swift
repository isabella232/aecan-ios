//
//  UIViewController+InstantiateFromStoryboard.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateFromStoryboard() -> Self {
        return UIStoryboard.instantiate(viewController: String(describing: self)) as! Self
    }
}
