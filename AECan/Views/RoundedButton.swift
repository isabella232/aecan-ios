//
//  RoundedButton.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 23/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    
    var height: CGFloat = 45
    var fontSize: CGFloat = 18
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.titleLabel?.font = UIFont.montserratFont(ofSize: fontSize, weight: .regular)
        self.setTitleColor(.white, for: .normal)
        self.addConstraint(heightAnchor.constraint(equalToConstant: height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
