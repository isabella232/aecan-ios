//
//  StageDetailPresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 11/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol StageDetailPresenterProtocol: class {
    func fetchComponents()
    func finishTapped()
    func finishConfirmationTapped()
    func updateBeacons(_ beacons: [Beacon])
}

protocol StageDetailViewProtocol: class {
    func showError(message: String?)
    func updateUI(stageName: String?, endDate: String?, finished: Bool?, tabs: [StageDetailTab]?, admitsBeacons: Bool?)
    func askFinishingConfirmation(message: String)
    func showImposibleFinishingMessage(message: String)
    func showFinishigSuccess()
    func set(beaconsOptions: [Beacon], selectedBeacons: [Beacon])
    func showBeaconsUpdateSuccess()
}

class StageDetailPresenter: StageDetailPresenterProtocol {
    
    private weak var view: StageDetailViewProtocol?
    private var stageId: Int?
    private var tabs: [StageDetailTab]?
    private var stageName: String?
    private var endDate: String?
    private var finished: Bool?
    private var repository = StagesRepository()
    private var beaconsRepository = BeaconsRepository()
    
    init(view: StageDetailViewProtocol, stageId: Int?) {
        self.view = view
        self.stageId = stageId
    }
    
    func fetchComponents() {
        guard let stageId = stageId else { return }
        repository.fetchStageDetail(stageId: stageId, completion: { [weak self] (success, response, error) in
            
            guard success, let tabs = response?.tabs else {
                self?.view?.showError(message: error?.message)
                return
            }
            
            self?.view?.updateUI(stageName: response?.stageName, endDate: response?.endDate, finished: response?.finished, tabs: tabs, admitsBeacons: response?.admitsBeacons)
            self?.view?.set(beaconsOptions: response?.beaconsOptions ?? [], selectedBeacons: response?.beacons ?? [])
        })
    }
    
    func finishTapped() {
        guard let stageId = stageId else { return }
        repository.checkIfStageCanBeFinished(stageId: stageId, completion: { [weak self] (success, response, error) in
            guard success, let result = response else {
                self?.view?.showError(message: error?.message)
                return
            }
            if response?.canBeFinished ?? false {
                self?.view?.askFinishingConfirmation(message: result.message ?? "")
            } else {
                self?.view?.showImposibleFinishingMessage(message: result.message ?? "")
            }
        })
    }
    
    func finishConfirmationTapped() {
        guard let stageId = stageId else { return }
        repository.finishStage(stageId: stageId) { [weak self] (success, error) in
            guard success else {
                self?.view?.showError(message: error?.message)
                return
            }
            self?.view?.showFinishigSuccess()
        }
    }
    
    func updateBeacons(_ beacons: [Beacon]) {
        guard let stageId = stageId else { return }
        beaconsRepository.updateBeacons(beacons, forLotStageId: String(stageId)) { [weak self] (success, error) in
            guard success else {
                self?.view?.showError(message: error?.message)
                return
            }
            self?.repository.fetchStageDetail(stageId: stageId, completion: { [weak self] (success, response, error) in
                
                guard success, let _ = response?.tabs else {
                    self?.view?.showError(message: error?.message)
                    return
                }
                self?.view?.set(beaconsOptions: response?.beaconsOptions ?? [], selectedBeacons: response?.beacons ?? [])
                self?.view?.showBeaconsUpdateSuccess()
            })
        }
    }
}
