//
//  LotDetailPresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 10/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol LotDetailPresenterProtocol: class {
    func fetchLotDetail()
}

protocol LotDetailViewProtocol: class {
    func showError(message: String?)
    func updateView(lot: Lot?)
}

class LotDetailPresenter: LotDetailPresenterProtocol {
    private weak var view: LotDetailViewProtocol?
    private var lotId: Int?
    
    init(view: LotDetailViewProtocol, lotId: Int?) {
        self.view = view
        self.lotId = lotId
    }
    
    func fetchLotDetail() {
        guard let lotId = self.lotId else { return }
        LotRepository().fetchLotDetail(lotId: lotId, completion: { [weak self] (success, response, error) in
            guard success else {
                self?.view?.showError(message: error?.message)
                return
            }
            
            self?.view?.updateView(lot: response)
        })
    }
}
