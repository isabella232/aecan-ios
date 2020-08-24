//
//  ModalViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    
    // Properties
    var dialogTitle: String = ""
    var buttonText: String = ""
    
    // Outlets
    @IBOutlet var backView: TappableUIView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackViewTap()
        titleLabel?.text = dialogTitle
        button?.setTitle(buttonText, for: .normal)
        button?.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupBackViewTap() {
        backView?.handleTap = {
            self.removeFromParentAndSuperview()
        }
    }
    
    @objc func buttonTapped() {
        self.removeFromParentAndSuperview()
    }
}
