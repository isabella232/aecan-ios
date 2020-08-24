//
//  StageDetailComponentCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol StageDetailComponentCellDelegate: class {
    func stageDetailComponentCellShouldBeUpdated<T: StageDetailComponent>(cell: StageDetailComponentCell<T>)
    func stageDetailComponentCellMustReloadParent()
    func showLoadingUIForStageDetailComponent()
    func hideLoadingUIForStageDetailComponent()
    func showError(_ error: String?)
}

protocol StageDetailComponentCellProtocol where Self: UITableViewCell {
    func setComponent(_ component: StageDetailComponent?)
    var delegate: StageDetailComponentCellDelegate? { get set }
    var context: UIViewController? { get set }
}

class StageDetailComponentCell<T: StageDetailComponent>: UITableViewCell, StageDetailComponentCellProtocol {
    var delegate: StageDetailComponentCellDelegate?
    var component: T? { didSet { componentUpdated() }}
    var context: UIViewController? { didSet { contextUpdated() }}
    var presenter: StageDetailComponentBasePresenterProtocol?
    
    func componentUpdated() { /* To be overriden */ }
    
    func contextUpdated() { /* To be overriden */ }
    
    func setComponent(_ component: StageDetailComponent?) {
        self.component = component as? T
    }
}

extension StageDetailComponentCell: SelectorDialogDelegate {
    func selector(dialog: SelectorDialogViewController, didTapButtonWith selectedOptions: [SelectorDialogOption]) {
        guard let selectedOption = selectedOptions.first as? SelectionModal.Option else { return }
        presenter?.selectorModalButtonTapped(option: selectedOption)
    }
}

extension StageDetailComponentCell: InputDialogDelegate {
    func input(dialog: InputDialogViewController, didTapButtonWith text: String) {
        presenter?.inputModalButtonTapped(text: text)
    }
}

extension StageDetailComponentCell: DatePickerDialogDelegate {
    func datePicker(dialog: DatePickerDialogViewController, didTapButtonWithDate date: Date) {
        let text = date.dbFormat1
        presenter?.inputModalButtonTapped(text: text)
    }
}

extension StageDetailComponentCell: ConfirmDialogDelegate {
    func confirmDialogDidTapAcceptButton(_ dialog: ConfirmDialogViewController) {
        presenter?.confirmModalAcceptButtonTapped()
    }
    
    func confirmDialogDidTapCancelButton(_ dialog: ConfirmDialogViewController) {
        // nothing here
    }
}

extension StageDetailComponentCell {
    
    func openSelectionModal(modal: SelectionModal) {
        let vc = SelectorDialogViewController.instantiateFromStoryboard()
        
        let selectedOptions: [SelectorDialogOption] = modal.options.filter({ $0.id?.toString() == modal.value })
        
        vc.dialogTitle = modal.title ?? ""
        vc.buttonText = modal.buttonText ?? ""
        vc.mode = .singleSelection // The modal dialog supports only single selection for now
        vc.options = modal.options
        vc.preselectedOptions = selectedOptions
        vc.delegate = self
        
        if let context = context {
            context.addChild(viewController: vc, in: context.view)
        }
    }
    
    func openInputModal(modal: InputModal) {
        if modal.inputType == .date {
            // TODO: this should be refactores into a new modal instead of a new input type
            openDatePicker(modal: modal)
            return
        }
        
        let vc = InputDialogViewController.instantiateFromStoryboard()
        
        vc.dialogTitle = modal.title ?? ""
        vc.buttonText = modal.buttonText ?? ""
        vc.prefilledText = ""
        vc.prefix = modal.prefix
        vc.suffix = modal.suffix
        vc.delegate = self
        vc.inputType = modal.inputType?.dialogInputType
        
        if let context = context {
            context.addChild(viewController: vc, in: context.view)
        }
    }
    
    private func openDatePicker(modal: InputModal) {
        let vc = DatePickerDialogViewController.instantiateFromStoryboard()
        
        vc.dialogTitle = modal.title ?? ""
        vc.buttonText = modal.buttonText ?? ""
        vc.delegate = self
        
        if let context = context {
            context.addChild(viewController: vc, in: context.view)
        }
    }
    
    func openConfirmModal(modal: ConfirmModal) {
        let vc = ConfirmDialogViewController.instantiateFromStoryboard()
        
        vc.dialogTitle = modal.title ?? ""
        vc.body = modal.body ?? ""
        vc.buttonText = modal.buttonText ?? ""
        vc.cancelButtonText = "Cancelar"
        vc.delegate = self
        
        if let context = context {
            context.addChild(viewController: vc, in: context.view)
        }
    }
    
    func showLoadingUI() {
        delegate?.showLoadingUIForStageDetailComponent()
    }
    
    func hideLoadingUI() {
        delegate?.hideLoadingUIForStageDetailComponent()
    }
    
    func actionDidExecuteRequest() {
        delegate?.stageDetailComponentCellMustReloadParent()
    }
    
    func showError(_ error: String?) {
        delegate?.showError(error)
    }
}

fileprivate extension InputModal.InputType {
    
    var dialogInputType: InputDialogViewController.InputType? {
        switch self {
        case .number:
            return .number
        case .text:
            return .text
        case .date:
            return nil
        }
    }
}

fileprivate extension Int {
    func toString() -> String {
        return String(self)
    }
}
