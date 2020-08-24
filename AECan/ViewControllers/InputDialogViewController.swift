//
//  InputDialogViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol InputDialogDelegate: class {
    func input(dialog: InputDialogViewController, didTapButtonWith text: String)
}

class InputDialogViewController: ModalViewController {
    
    enum InputType {
        case number
        case text
    }
    
    // Properties
    var prefix: String?
    var suffix: String?
    var prefilledText: String = ""
    var inputType: InputType?
    
    // Outlets
    @IBOutlet private var prefixLabel: UILabel?
    @IBOutlet private var suffixLabel: UILabel?
    @IBOutlet private var textField: UITextField?
    
    // Delegate
    weak var delegate: InputDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefixLabel?.text = prefix ?? ""
        suffixLabel?.text = suffix ?? ""
        textField?.text = prefilledText
        
        switch inputType {
        case .number:
            textField?.keyboardType = .decimalPad
        case .text:
            textField?.keyboardType = .default
        case .none:
            textField?.keyboardType = .default
        }
        
        if prefix != nil {
            textField?.textAlignment = .left
        }
        
        if suffix != nil {
            textField?.textAlignment = .right
        }
    }
    
    override func buttonTapped() {
        if let text = textField?.text, !text.isEmpty {
            super.buttonTapped()
            delegate?.input(dialog: self, didTapButtonWith: text)
        }
    }
}
