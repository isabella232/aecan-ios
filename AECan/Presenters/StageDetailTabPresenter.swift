//
//  StageDetailTabPresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol StageDetailTabPresenterDelegate: class {
    func stageDetailTabPresenterRequestFullUIReload()
    func showLoadingOverlay()
    func hideLoadingOverlay()
}

protocol StageDetailTabPresenterProtocol: class {
    func reloadParentUI()
    func requestData()
    func blockUI()
    func releaseUI()
}

protocol StageDetailTabViewProtocol: class {
    func update(tab: StageDetailTab)
}

class StageDetailTabPresenter: StageDetailTabPresenterProtocol {
    
    // View
    private weak var view: StageDetailTabViewProtocol?
    
    // Delegate
    weak var delegate: StageDetailTabPresenterDelegate?
    
    // Data
    private let tab: StageDetailTab
    
    init(view: StageDetailTabViewProtocol, tab: StageDetailTab) {
        self.view = view
        self.tab = tab
    }
    
    func requestData() {
        view?.update(tab: tab)
    }
    
    func reloadParentUI() {
        delegate?.stageDetailTabPresenterRequestFullUIReload()
    }
    
    func blockUI() {
        delegate?.showLoadingOverlay()
    }
    
    func releaseUI() {
        delegate?.hideLoadingOverlay()
    }
}
