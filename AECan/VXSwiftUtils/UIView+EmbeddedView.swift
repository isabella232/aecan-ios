//
//  UIView+EmbeddedView.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addEmbedded(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraint(self.topAnchor.constraint(equalTo: view.topAnchor))
        self.addConstraint(self.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        self.addConstraint(self.leftAnchor.constraint(equalTo: view.leftAnchor))
        self.addConstraint(self.rightAnchor.constraint(equalTo: view.rightAnchor))
    }
}
