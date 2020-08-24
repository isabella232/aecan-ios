//
//  UIApplication+RootViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    func setRootViewController(_ viewController: UIViewController) {
        (delegate as? AppDelegate)?.window?.rootViewController = viewController
    }
}
