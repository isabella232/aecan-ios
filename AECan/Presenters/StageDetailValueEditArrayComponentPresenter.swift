//
//  StageDetailValueEditArrayComponentController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol StageDetailValueEditArrayComponentViewProtocol: StageDetailComponentViewProtocol {
    
}

class StageDetailValueEditArrayComponentPresenter<U: StageDetailValueEditArrayComponentViewProtocol>: StageDetailComponentBasePresenter<StageDetailValueEditArrayComponent, U> {
    
    func itemTappedAt(_ index: Int) {
        if let item = component?.items[index] {
            itemTapped(item)
        }
    }
    
    private func itemTapped(_ item: StageDetailValueEditArrayComponent.Item) {
        if let action = item.itemAction {
            execute(action: action)
        }
    }
}
