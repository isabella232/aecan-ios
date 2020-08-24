//
//  ComponentEditValueArrayItem.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailEditValueArrayComponentItemView: UIView {
    
    var item: StageDetailValueEditArrayComponent.Item? { didSet { itemUpdated() }}
    var editable = false
    
    var handleTap: (() -> Void)?
    
    @IBOutlet private var tappableView: TappableUIView?
    @IBOutlet private var label: UILabel?
    @IBOutlet private var chevron: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tappableView?.handleTap = {
            if self.editable {
                self.handleTap?()
            }
        }
    }
    
    private func itemUpdated() {
        chevron?.isHidden = !editable
        
        guard let item = item else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let text = NSMutableAttributedString()

        text.append(NSAttributedString(string: "\(item.name ?? ""): ", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucGrey450,
            .paragraphStyle: paragraphStyle
        ]))

        text.append(NSAttributedString(string: "\(item.value ?? "")", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucBlackText100,
            .paragraphStyle: paragraphStyle
        ]))
        
        self.label?.attributedText = text
    }
}
