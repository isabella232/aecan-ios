//
//  DatePickerDialogViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 09/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerDialogDelegate: class {
    func datePicker(dialog: DatePickerDialogViewController, didTapButtonWithDate date: Date)
}

class DatePickerDialogViewController: ModalViewController {
    
    // Outlets
    @IBOutlet private var datePicker: UIDatePicker?
    
    // Delegate
    weak var delegate: DatePickerDialogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker?.datePickerMode = .date
    }
    
    override func buttonTapped() {
        super.buttonTapped()
        guard let datePicker = datePicker else { return }
        delegate?.datePicker(dialog: self, didTapButtonWithDate: datePicker.date)
    }
}
