//
//  ProcedureBodyView.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 17/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class ProcedureBodyView: UIView {
    @IBOutlet private var bodyLabel: UILabel?
    @IBOutlet var leftLabelConstraint: NSLayoutConstraint?
    
    var bodyText: NSMutableAttributedString? {
        didSet {
            bodyLabel?.attributedText = bodyText
        }
    }
}
