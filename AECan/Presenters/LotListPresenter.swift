//
//  LotListPresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 03/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol LotListPresenterProtocol: class {
    func fetchData()
}

protocol LotListViewProtocol: class {
    func showError(message: String?)
    func updateLotsUI(lots: [Lot])
}

class LotListPresenter: LotListPresenterProtocol {
    enum ListMode {
        case userList
        case startedList
        case finishedList
    }
    
    var view: LotListViewProtocol?
    var mode: ListMode?
    
    init(view: LotListViewProtocol) {
        self.view = view
    }
    
    func fetchData() {
        if let mode = mode {
            switch mode {
            case .userList:
                fetchUserLots()
            case .startedList:
                fetchStartedLots()
            case .finishedList:
                fetcFinishedLots()
            }
        }
    }
    
    private func fetchUserLots() {
        LotRepository().fetchUserLots(completion: { [weak self] (success, response, error) in
            self?.lotsListHandler(success: success, response: response, error: error)
        })
    }
    
    private func fetchStartedLots() {
        LotRepository().fetchStartedLots(completion: { [weak self] (success, response, error) in
            self?.lotsListHandler(success: success, response: response, error: error)
        })
    }
    
    private func fetcFinishedLots() {
        LotRepository().fetchFinishedLots(completion: { [weak self] (success, response, error) in
            self?.lotsListHandler(success: success, response: response, error: error)
        })
    }
    
    private func lotsListHandler(success: Bool, response: [Lot]?, error: ApiRepositoryError?) {
        guard success, let lots = response else {
            view?.showError(message: error?.message)
            return
        }
        view?.updateLotsUI(lots: lots)
    }
}
