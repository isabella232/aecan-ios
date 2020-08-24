//
//  UIViewController+RemoveFromParentAndSuperview.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func removeFromParentAndSuperview() {
        view.removeFromSuperview()
        removeFromParent()
        didMove(toParent: nil)
    }
}
