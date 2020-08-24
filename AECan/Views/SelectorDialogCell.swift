//
//  SelectorDialogCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class SelectorDialogCell: UITableViewCell {
    
    @IBOutlet private var borderView: UIView?
    @IBOutlet private var label: UILabel?
    
    var labelText: String? {
        get { return label?.text }
        set { label?.text = newValue }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        borderView?.layer.borderWidth = selected ? 2 : 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        borderView?.layer.borderColor = UIColor.mainColor100.cgColor
        borderView?.layer.cornerRadius = 20
    }
}
