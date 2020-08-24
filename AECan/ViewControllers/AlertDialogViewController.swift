//
//  AlertDialogViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 09/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDialogDelegate: class {
    func alertDialogDidTapAcceptButton(_ dialog: AlertDialogViewController)
}

class AlertDialogViewController: ModalViewController {
    
    var body: String = ""
    
    @IBOutlet private var bodyLabel: UILabel?
    
    var delegate: AlertDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel?.text = body
    }
    
    @IBAction private func acceptTapped() {
        buttonTapped()
        delegate?.alertDialogDidTapAcceptButton(self)
    }
}
