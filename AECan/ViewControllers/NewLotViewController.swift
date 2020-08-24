//
//  NewLotViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class NewLotViewController: UIViewController, SelectorDialogDelegate, InputDialogDelegate, ViewControllerWithLoadingOverlay {
    
    var presenter: NewLotPresenterProtocol?
    
    @IBOutlet var numberLabel: TappableUILabel?
    @IBOutlet var beaconsDropDown: TappableUIView?
    @IBOutlet var beaconsLabel: UILabel?
    @IBOutlet var varietiesDropDown: TappableUIView?
    @IBOutlet var varietiesLabel: UILabel?
    @IBOutlet var informationCard: UIView?
    @IBOutlet var informationLabel: UILabel?
    
    private var beaconsSelectorVC: SelectorDialogViewController?
    private var varietySelectorVC: SelectorDialogViewController?
    
    var loadingOverlay = LoadingOverlay()
    
    // MARK: - Callbacks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel?.handleTap = {
            self.changeNumberTapped()
        }
        
        beaconsDropDown?.handleTap = {
            self.changeBeaconsTapped()
        }
        
        varietiesDropDown?.handleTap = {
            self.changeVarietyTapped()
        }
        
        numberLabel?.text = "#"
        beaconsLabel?.text = "-"
        varietiesLabel?.text = "-"
        informationLabel?.text = ""
        
        informationCard?.layer.masksToBounds = false
        informationCard?.layer.shadowColor = UIColor.black.cgColor
        informationCard?.layer.shadowOpacity = 0.10
        informationCard?.layer.shadowOffset = CGSize(width: 0, height: 0)
        informationCard?.layer.shadowRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarHelper.configureNavigationBar(title: "Nuevo lote")
        showLoadingOverlay()
        presenter?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let vc = HomeTabsViewController.instantiateFromStoryboard()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UI Setup
    
    private func setupInfo(start: String, end: String, plants: String?, irrigation: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let text = NSMutableAttributedString(string: "Inicio: ", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucGrey450.cgColor,
            .paragraphStyle: paragraphStyle
        ])
        
        text.append(NSAttributedString(string: "\(start)\n", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucBlackText100.cgColor,
            .paragraphStyle: paragraphStyle
        ]))
        
        text.append(NSAttributedString(string: "Finalización: ", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucGrey450.cgColor,
            .paragraphStyle: paragraphStyle
        ]))
        
        text.append(NSAttributedString(string: "\(end)\n", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucBlackText100.cgColor,
            .paragraphStyle: paragraphStyle
        ]))
        
        if let plants = plants {
            text.append(NSAttributedString(string: "Plantas/m2: ", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucGrey450.cgColor,
                .paragraphStyle: paragraphStyle
            ]))
            
            text.append(NSAttributedString(string: "\(plants)\n", attributes: [
                .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.ucBlackText100.cgColor,
                .paragraphStyle: paragraphStyle
            ]))
        }
        
        text.append(NSAttributedString(string: "Riego: ", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucGrey450.cgColor,
            .paragraphStyle: paragraphStyle
        ]))
        
        text.append(NSAttributedString(string: "\(irrigation)", attributes: [
            .font: UIFont.montserratFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.ucBlackText100.cgColor,
            .paragraphStyle: paragraphStyle
        ]))
        
        informationLabel?.attributedText = text
    }
    
    private func resetForm() {
        numberLabel?.text = "#"
        beaconsLabel?.text = "-"
        varietiesLabel?.text = "-"
        presenter?.resetData()
    }
    
    // MARK: - Actions
    
    private func changeNumberTapped() {
        presenter?.changeNumberTapped()
    }
    
    private func changeBeaconsTapped() {
        presenter?.changeBeaconsTapped()
    }
    
    private func changeVarietyTapped() {
        presenter?.changeVarietyTapped()
    }
    
    @IBAction private func createLot() {
        showLoadingOverlay()
        presenter?.createLot()
    }
    
    // MARK: - Dialogs

    func showSelector(mode: SelectorDialogMode, options: [SelectorDialogOption], selectedOptions: [SelectorDialogOption], title: String) -> SelectorDialogViewController {
        let vc = SelectorDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = title
        vc.buttonText = "Agregar"
        vc.mode = mode
        vc.options = options
        vc.preselectedOptions = selectedOptions
        vc.delegate = self
        addChild(viewController: vc, in: view)
        return vc
    }
    
    func selector(dialog: SelectorDialogViewController, didTapButtonWith selectedOptions: [SelectorDialogOption]) {
        if dialog == beaconsSelectorVC {
            let selectedBeacons = selectedOptions.compactMap({ $0 as? Beacon })
            beaconsLabel?.text = "\(selectedBeacons.count)"
            presenter?.changeBeaconsSelection(beacons: selectedBeacons)
        }
        if dialog == varietySelectorVC {
            let selectedVariety = selectedOptions.first as? Variety
            varietiesLabel?.text = selectedVariety?.shortName
            presenter?.changeVarietySelection(variety: selectedVariety)
        }
    }
    
    func showInput(number: String) {
        let vc = InputDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = "Ingresar número de lote"
        vc.buttonText = "Agregar"
        vc.prefix = "#"
        vc.prefilledText = number
        vc.delegate = self
        addChild(viewController: vc, in: view)
    }
    
    func input(dialog: InputDialogViewController, didTapButtonWith text: String) {
        numberLabel?.text = "#\(text)"
        presenter?.changeNumber(text)
    }
}

// MARK: - NewLotViewProtocol

extension NewLotViewController: NewLotViewProtocol {
    
    func showDataFetchingSuccess() {
        hideLoadingOverlay()
    }
    
    func showDataFetchingError(message: String?) {
        hideLoadingOverlay()
        displayError(message) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showInformation(start: String, end: String, plants: String?, irrigation: String) {
        setupInfo(start: start, end: end, plants: plants, irrigation: irrigation)
    }
    
    func showBeaconsSelector(options: [Beacon], selected: [Beacon]) {
        beaconsSelectorVC = showSelector(mode: .multipleSelection, options: options, selectedOptions: selected, title: "Seleccionar beacons")
    }
    
    func showVarietySelector(options: [Variety], selected: Variety?) {
        let selectedOptions = [selected].compactMap({ $0 })
        varietySelectorVC = showSelector(mode: .singleSelection, options: options, selectedOptions: selectedOptions, title: "Seleccionar variedad")
    }
    
    func showLotNumberEditor(number: String) {
        showInput(number: number)
    }
    
    func showCreationSuccess(lotId: Int) {
        hideLoadingOverlay()
        resetForm()
        navigateToDetail(lotId: lotId)
    }
    
    private func navigateToDetail(lotId: Int) {
        var navigationStack: [UIViewController] = []
        let vc = LotDetailWireframe.getViewController(lotId: lotId)
        if let rootVC = navigationController?.viewControllers.first {
            navigationStack.append(rootVC)
        }
        navigationStack.append(vc)
        
        navigationController?.setViewControllers(navigationStack, animated: true)
    }
    
    func showCreation(error: String?) {
        hideLoadingOverlay()
        displayError(error)
    }
}
