//
//  ComponentKeyValueArrayCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailKeyValueArrayComponentCell: StageDetailComponentCell<StageDetailKeyValueArrayComponent>, CellWithCard {
    
    @IBOutlet var card: UIView?
    @IBOutlet private var label: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
    }
    
    override func componentUpdated() {
        setupInfo()
    }
    
    private func setupInfo() {
        guard let component = self.component else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let text = NSMutableAttributedString()
        
        for item in component.items {
            text.append(NSAttributedString(string: "\(item.name ?? "") ", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucGrey450,
                .paragraphStyle: paragraphStyle
            ]))
            text.append(NSAttributedString(string: "\(item.value ?? "")\n", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucBlackText100,
                .paragraphStyle: paragraphStyle
            ]))
        }
        
        if text.length > 0 {
            text.deleteCharacters(in: NSRange(location:(text.length) - 1, length: 1))
        }
        label?.attributedText = text
    }
}
