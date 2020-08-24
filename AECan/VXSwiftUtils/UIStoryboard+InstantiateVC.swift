//
//  UIStoryboard+InstantiateVC.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 23/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func instantiate(viewController viewControllerName: String) -> UIViewController {
        return UIStoryboard(name: viewControllerName, bundle: .main).instantiateViewController(withIdentifier: viewControllerName)
    }
}
