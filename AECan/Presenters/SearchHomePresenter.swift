//
//  SearchHomePresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 06/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol SearchHomePresenterProtocol: class {
    func searchLotByIdentifier(identifier: String)
    func goToLotDetail()
}

protocol SearchHomeViewProtocol: class {
    func showError(message: String?)
    func redirectOnSuccess(lot: Lot)
    func navigateToLotDetail(lotId: Int)
}

class SearchHomePresenter: SearchHomePresenterProtocol {
    
    weak var view: SearchHomeViewProtocol?
    var searchRepo = SearchHomeRepository()
    private var lastLot: Lot?
    
    init(view: SearchHomeViewProtocol) {
        self.view = view
    }
    
    func searchLotByIdentifier(identifier: String) {
        searchRepo.searchLotByIdentifier(identifier: identifier, completion: { [weak self] (success, response, error) in
            guard success, let lot = response else {
                self?.view?.showError(message: error?.message)
                return
            }
            self?.lastLot = lot
            self?.view?.redirectOnSuccess(lot: lot)
        })
    }
    
    func goToLotDetail() {
        guard let lotId = lastLot?.id else { return }
        view?.navigateToLotDetail(lotId: lotId)
    }
}
