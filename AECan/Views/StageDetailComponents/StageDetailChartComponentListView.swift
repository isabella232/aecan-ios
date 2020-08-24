//
//  StageDetailChartComponentListView.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailChartComponentListView: UIView {
    
    @IBOutlet private var entriesLabel: UILabel?
    
    var component: StageDetailChartComponent? { didSet { setupInfo() }}
    
    private func setupInfo() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let text = NSMutableAttributedString()
        
        for entry in component?.entries ?? [] {
            text.append(NSAttributedString(string: "\(entry.label ?? ""): ", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucGrey450,
                .paragraphStyle: paragraphStyle
            ]))
            let value = String(format: "%.2f", entry.value ?? 0)
            let unit = component?.unit ?? ""
            text.append(NSAttributedString(string: "\(value) \(unit)\n", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucBlackText100,
                .paragraphStyle: paragraphStyle
            ]))
        }

        entriesLabel?.attributedText = text
    }
}
