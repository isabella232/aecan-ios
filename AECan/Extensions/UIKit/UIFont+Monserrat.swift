//
//  UIFont+Fonts.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 23/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static func montserratFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        switch weight {
        case .light:
            return UIFont(name: "Montserrat-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        case .semibold:
            return UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
        default:
            return systemFont(ofSize: size, weight: weight)
        }
    }
}
