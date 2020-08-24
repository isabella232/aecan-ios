//
//  UIViewController+EmbeddedChildVC.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addChild(viewController: UIViewController, in view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        view.addEmbedded(view: viewController.view)
        viewController.didMove(toParent: self)
    }
}
