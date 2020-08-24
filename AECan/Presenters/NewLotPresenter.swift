//
//  NewLotPresenter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol NewLotPresenterProtocol: class {
    func fetchData()
    func changeBeaconsTapped()
    func changeBeaconsSelection(beacons: [Beacon])
    func changeVarietyTapped()
    func changeVarietySelection(variety: Variety?)
    func changeNumberTapped()
    func changeNumber(_ number: String?)
    func createLot()
    func resetData()
}

protocol NewLotViewProtocol: class {
    func showDataFetchingSuccess()
    func showDataFetchingError(message: String?)
    func showInformation(start: String, end: String, plants: String?, irrigation: String)
    func showBeaconsSelector(options: [Beacon], selected: [Beacon])
    func showVarietySelector(options: [Variety], selected: Variety?)
    func showLotNumberEditor(number: String)
    func showCreationSuccess(lotId: Int)
    func showCreation(error: String?)
}

class NewLotPresenter: NewLotPresenterProtocol {
    
    private weak var view: NewLotViewProtocol?
    
    private var beacons: [Beacon] = []
    private var varieties: [Variety] = []
    private var newLot: NewLotRequest = NewLotRequest()
    
    private var defaultDataFetched = false { didSet { checkIfAllDataIsFetched() }}
    private var beaconsFetched = false { didSet { checkIfAllDataIsFetched() }}
    private var varitiesFetched = false { didSet { checkIfAllDataIsFetched() }}
    
    init(view: NewLotViewProtocol) {
        self.view = view
    }
    
    // MARK: - Data fetching
    
    func fetchData() {
        fetchDefaultData()
        fetchVarieties()
        fetchBeacons()
    }
    
    private func checkIfAllDataIsFetched() {
        if defaultDataFetched && beaconsFetched && varitiesFetched {
            view?.showDataFetchingSuccess()
        }
    }
    
    // MARK: - Default data
    
    private func fetchDefaultData() {
        LotRepository().fetchDefaultData(completion: { [weak self] (success, response, error) in
            guard success else {
                self?.view?.showDataFetchingError(message: error?.message)
                return
            }
            self?.newLot.plantsQuantity = response?.plantsQuantity
            self?.newLot.startDate = response?.startDateString
            let start = response?.startDate?.longFormat1 ?? response?.startDateString ?? ""
            let end = response?.endDate?.longFormat1 ?? response?.endDateString ?? ""
            var plants: String?
            if let plantsInt = response?.plantsQuantity {
                plants = "\(plantsInt)"
            }
            let irrigation = response?.irrigationType ?? ""
            self?.view?.showInformation(start: start, end: end, plants: plants, irrigation: irrigation)
            self?.defaultDataFetched = true
        })
    }
    
    // MARK: - Beacons
    
    private func fetchBeacons() {
        BeaconsRepository().fetchBeacons(completion: { [weak self] (success, response, error) in
            guard success, let beacons = response else {
                self?.view?.showDataFetchingError(message: error?.message)
                return
            }
            self?.beacons = beacons
            self?.beaconsFetched = true
        })
    }
    
    func changeBeaconsTapped() {
        view?.showBeaconsSelector(options: beacons, selected: newLot.beacons)
    }
    
    func changeBeaconsSelection(beacons: [Beacon]) {
        self.newLot.beacons = beacons
    }
    
    // MARK: - Varieties
    
    private func fetchVarieties() {
        VarietiesRepository().fetchVarieties(completion: { [weak self] (success, response, error) in
            guard success, let varieties = response else {
                self?.view?.showDataFetchingError(message: error?.message)
                return
            }
            
            self?.varieties = varieties
            self?.varitiesFetched = true
        })
    }
    
    func changeVarietyTapped() {
        view?.showVarietySelector(options: varieties, selected: newLot.variety)
    }
    
    func changeVarietySelection(variety: Variety?) {
        self.newLot.variety = variety
    }
    
    // MARK: - Lot number
    
    func changeNumberTapped() {
        view?.showLotNumberEditor(number: newLot.identifier ?? "")
    }
    
    func changeNumber(_ number: String?) {
        newLot.identifier = number
    }
    
    // MARK: - Lot creation
    
    func createLot() {
        LotRepository().createLot(request: newLot) { [weak self] (success, response, error) in
            guard success, let lotId = response?.id else {
                self?.view?.showCreation(error: error?.message)
                return
            }
            self?.view?.showCreationSuccess(lotId: lotId)
        }
    }
    
    func resetData() {
        newLot = NewLotRequest()
    }
}
