//
//  StageDetailValueListArrayComponentCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 27/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailValueListArrayComponentCell: StageDetailComponentCell<StageDetailValueListArrayComponent>, CellWithCard {

    @IBOutlet var card: UIView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var expandButton: UIButton?
    @IBOutlet var contentLabel: UILabel?
    @IBOutlet var createButton: UIButton?
    @IBOutlet var deleteButton: UIButton?
    
    private var expanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createButton?.layer.cornerRadius = 12
        deleteButton?.layer.cornerRadius = 12
        setupCard()
        presenter = StageDetailValueListArrayComponentPresenter(view: self)
    }
    
    override func componentUpdated() {
        presenter?.setComponent(component)
        setupInfo()
    }
    
    private func setupInfo() {
        guard let component = self.component else { return }
        
        createButton?.isHidden = !component.editable
        deleteButton?.isHidden = !component.editable
        
        expandButton?.setTitle(expanded ? "Mostrar menos" : "Mostrar todas", for: .normal)
        
        titleLabel?.text = component.title
        
        var itemsToShow = component.items
        let minAmountOfItemsToShow = component.minAmountOfItemsToShow ?? 5
        
        if !expanded {
            itemsToShow = Array(component.items.prefix(minAmountOfItemsToShow))
        }
        
        if component.items.count <= minAmountOfItemsToShow {
            expandButton?.isHidden = true
        } else {
            expandButton?.isHidden = false
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let text = NSMutableAttributedString()
        
        for item in itemsToShow {
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

        contentLabel?.attributedText = text
    }
    
    @IBAction private func toggleTapped() {
        expanded = !expanded
        setupInfo()
        delegate?.stageDetailComponentCellShouldBeUpdated(cell: self)
    }
    
    @IBAction private func createTapped() {
        guard let action = component?.componentAction else { return }
        presenter?.execute(action: action)
    }
    
    @IBAction private func deleteTapped() {
        guard let action = component?.deleteAction else { return }
        presenter?.execute(action: action)
    }
}

extension StageDetailValueListArrayComponentCell: StageDetailValueListArrayComponentViewProtocol {
    
}
