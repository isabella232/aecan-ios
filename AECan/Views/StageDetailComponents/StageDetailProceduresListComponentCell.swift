//
//  StageDetailProceduresListComponentCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailProceduresListComponentCell: StageDetailComponentCell<StageDetailProceduresListComponent>, CellWithCard {

    @IBOutlet var card: UIView?
    @IBOutlet var stackView: UIStackView?
    @IBOutlet private var titleLabel: UILabel?
    
    private var currentlyExpandedItemView: StageDetailProceduresListComponenentItemView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = StageDetailProceduresListComponentPresenter<StageDetailProceduresListComponentCell>(view: self)
        setupCard()
    }
    
    override func componentUpdated() {
        presenter?.setComponent(component)
        setupInfo()
   }
    
    private func setupInfo() {
        guard let component = component else { return }
        titleLabel?.text = component.title ?? ""
        stackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for item in component.items {
            print("\(item)")
            let view = StageDetailProceduresListComponenentItemView.instantiateFromXib()
            view.editable = component.editable
            view.delegate = self
            view.item = item
            view.handleButtonTap = {
                self.itemWasTapped(item)
            }
            stackView?.addArrangedSubview(view)
        }
    }
    
    private func itemWasTapped(_ item: StageDetailProceduresListComponent.Item) {
        (presenter as? StageDetailProceduresListComponentPresenter<StageDetailProceduresListComponentCell>)?.itemTapped(item)
    }
}

extension StageDetailProceduresListComponentCell: StageDetailProceduresListComponenentItemViewDelegate {
    func stageDetailProceduresListComponenent(itemView: StageDetailProceduresListComponenentItemView, toogleStateChangedTo expanded: Bool) {
        if expanded {
            if self.currentlyExpandedItemView != itemView {
                self.currentlyExpandedItemView?.close()
            }
            self.currentlyExpandedItemView = itemView
        }
        delegate?.stageDetailComponentCellShouldBeUpdated(cell: self)
    }
}

extension StageDetailProceduresListComponentCell: StageDetailProceduresListComponentViewProtocol {}
