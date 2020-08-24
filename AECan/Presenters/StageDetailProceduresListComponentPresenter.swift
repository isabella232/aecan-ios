//
//  StageDetailProceduresListComponentPresenter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol StageDetailProceduresListComponentViewProtocol: StageDetailComponentViewProtocol {
    
}

class StageDetailProceduresListComponentPresenter<U: StageDetailProceduresListComponentViewProtocol>: StageDetailComponentBasePresenter<StageDetailProceduresListComponent, U> {
    
    func itemTapped(_ item: StageDetailProceduresListComponent.Item) {
        if let action = item.itemAction {
            execute(action: action)
        }
    }
}
