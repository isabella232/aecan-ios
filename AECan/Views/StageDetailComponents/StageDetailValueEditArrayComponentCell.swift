//
//  ComponentValueEditArrayCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailValueEditArrayComponentCell: StageDetailComponentCell<StageDetailValueEditArrayComponent>, CellWithCard {
    
    @IBOutlet var card: UIView?
    @IBOutlet var stackView: UIStackView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = StageDetailValueEditArrayComponentPresenter(view: self)
        setupCard()
    }
    
    override func componentUpdated() {
        presenter?.setComponent(component)
        setupInfo()
    }
    
    private func setupInfo() {
        guard let component = self.component else { return }
        
        stackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for i in 0..<component.items.count {
            let view = StageDetailEditValueArrayComponentItemView.instantiateFromXib()
            view.handleTap = {
                self.itemWasTapped(at: i)
            }
            view.editable = component.editable
            view.item = component.items[i]
            stackView?.addArrangedSubview(view)
            if i < component.items.count - 1 {
                // We add a separator after each item, except the last one
                stackView?.addArrangedSubview(StageDetailEditValueArrayComponentSeparatorView.instantiateFromXib())
            }
        }
    }
    
    private func itemWasTapped(at index: Int) {
        (presenter as? StageDetailValueEditArrayComponentPresenter<StageDetailValueEditArrayComponentCell>)?.itemTappedAt(index)
    }
}

extension StageDetailValueEditArrayComponentCell: StageDetailValueEditArrayComponentViewProtocol { }
