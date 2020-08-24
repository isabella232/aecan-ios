//
//  StageDetailComponentBasePresenter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol StageDetailComponentViewProtocol: class {
    func openInputModal(modal: InputModal)
    func openSelectionModal(modal: SelectionModal)
    func openConfirmModal(modal: ConfirmModal)
    func showLoadingUI()
    func hideLoadingUI()
    func actionDidExecuteRequest()
    func showError(_ error: String?)
}

protocol StageDetailComponentBasePresenterProtocol {
    func setComponent(_ component: StageDetailComponent?)
    func execute(action: StageDetailComponentAction)
    func selectorModalButtonTapped(option: SelectionModal.Option?)
    func inputModalButtonTapped(text: String)
    func confirmModalAcceptButtonTapped()
}

class StageDetailComponentBasePresenter<T: StageDetailComponent, U: StageDetailComponentViewProtocol>: StageDetailComponentBasePresenterProtocol {
    
    var currentAction: StageDetailComponentAction?
    var actionRepository = ComponentActionRepository()
    var component: T?
    weak var view: U?
    
    init(view: U) {
        self.view = view
    }
    
    func setComponent(_ component: StageDetailComponent?) {
        self.component = component as? T
    }
    
    func execute(action: StageDetailComponentAction) {
        switch action.actionType {
        case .openInputModal:
            if let modal = action.inputModal {
                view?.openInputModal(modal: modal)
                currentAction = action
            }
        case .openSelectionModal:
            if let modal = action.selectionModal {
                view?.openSelectionModal(modal: modal)
                currentAction = action
            }
        case .openConfirmModal:
            if let modal = action.confirmModal {
                view?.openConfirmModal(modal: modal)
                currentAction = action
            }
        case .none:
            log.warning("Item doesnt have a valid action type")
        }
    }
    
    func selectorModalButtonTapped(option: SelectionModal.Option?) {
        sendRequestToBackend(withValue: option?.id?.toString())
        self.currentAction = nil
    }
    
    func inputModalButtonTapped(text: String) {
        sendRequestToBackend(withValue: text)
        self.currentAction = nil
    }
    
    func confirmModalAcceptButtonTapped() {
        sendRequestToBackend(withValue: nil)
        self.currentAction = nil
    }
    
    private func sendRequestToBackend(withValue value: String?) {
        guard let urlPath = getActionTargetUrl() else { return }
       
        view?.showLoadingUI()
        
        actionRepository.sendValue(urlPath: urlPath, value: value) { [weak self] (success, error) in
            guard success else {
                self?.view?.hideLoadingUI()
                self?.view?.showError(error?.message)
                return
            }
            self?.view?.hideLoadingUI()
            self?.view?.actionDidExecuteRequest()
        }
    }
    
    private func getActionTargetUrl() -> String? {
        guard let currentAction = currentAction, let currentActionType = currentAction.actionType else { return nil }
        
        switch currentActionType {
        case .openInputModal:
            return currentAction.inputModal?.urlPath
        case .openSelectionModal:
            return currentAction.selectionModal?.urlPath
        case .openConfirmModal:
            return currentAction.confirmModal?.urlPath
        }
    }
}

fileprivate extension Int {
    func toString() -> String {
        return String(self)
    }
}
