//
//  FormTextField.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 23/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class FormTextField: ViewOwnerOfXib {
    
    // MARK: - Outlets
    
    @IBOutlet private var iconImageView: UIImageView?
    @IBOutlet var textField: UITextField?
    
    // MARK: - Inspectables
    
    @IBInspectable var image: String? {
        didSet {
            if let imageName = image {
                iconImageView?.image = UIImage(named: imageName)
            }
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            textField?.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
                .foregroundColor: UIColor.ucBlackText100
            ])
        }
    }
    
    @IBInspectable var isSecureTextEntry: Bool = false {
        didSet {
            textField?.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    // MARK: - Properties
    
    var text: String? {
        return textField?.text
    }
    
    // MARK: - Initialization

    override func commonInit() {
        super.commonInit()
        textField?.font = UIFont.montserratFont(ofSize: 16, weight: .regular)
        textField?.textColor = .ucBlackText100
    }
}
