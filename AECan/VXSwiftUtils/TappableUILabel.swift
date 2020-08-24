//
//  TappableUILabel.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

// This is a duplicate of TappableUIView
// Refactors have to be made to reuse the code

class TappableUILabel: UILabel {

    var handleTap: (() -> Void)?

    private var initialOpacityBeforeTouch: CGFloat?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isUserInteractionEnabled = true
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        recognizer.minimumPressDuration = 0.0
        addGestureRecognizer(recognizer)
    }

    @objc private func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            highlight()
        }
        if sender.state == .ended {
            unhighlight()

            let touchedPoint = sender.location(in: self)
            if self.bounds.contains(touchedPoint) {
                handleTap?()
            }
        }
    }

    func highlight() {
        initialOpacityBeforeTouch = alpha
        alpha = alpha / 2
    }

    func unhighlight() {
        alpha = initialOpacityBeforeTouch ?? 1

    }
}


