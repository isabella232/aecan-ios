//
//  ConfirmDialogViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 02/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol ConfirmDialogDelegate: class {
    func confirmDialogDidTapCancelButton(_ dialog: ConfirmDialogViewController)
    func confirmDialogDidTapAcceptButton(_ dialog: ConfirmDialogViewController)
}

class ConfirmDialogViewController: ModalViewController {
    
    var body: String = ""
    var cancelButtonText: String = ""
    
    @IBOutlet private var bodyLabel: UILabel?
    @IBOutlet private var cancelButton: UIButton?
    
    var delegate: ConfirmDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel?.text = body
        cancelButton?.setTitle(cancelButtonText, for: .normal)
    }
    
    @IBAction private func acceptTapped() {
        buttonTapped()
        delegate?.confirmDialogDidTapAcceptButton(self)
    }
    
    @IBAction private func cancelTapped() {
        buttonTapped()
        delegate?.confirmDialogDidTapCancelButton(self)
    }
}
