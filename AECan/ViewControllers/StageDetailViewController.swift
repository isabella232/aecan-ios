//
//  StageDetailViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 11/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailViewController: UIViewController, ScrollableTopTabsViewController, ViewControllerWithLoadingOverlay {
    
    var tabsPageViewController: UIPageViewController?
    var tabsPageVCDataSource: PageViewControllerDataSource?
    @IBOutlet private var lotIdentifierLabel: UILabel?
    @IBOutlet private var finishStage: RoundedButton?
    @IBOutlet var tabBarContainer: UIView?
    var tabBarView: ScrollableTopTabBar?
    @IBOutlet var tabContentContainer: UIView?
    @IBOutlet var finishedStageLabel: UILabel?
    @IBOutlet var endDateLabel: UILabel?
    var containedViewControllers: [UIViewController] = []
    var tabsTitles: [ScrollableTopTabBar.ScrollableTopTab] = []
    @IBOutlet var beaconsButton: TappableUIView?
    var admitsBeacons: Bool? {
        didSet {
            if let finished = finished, !finished {
                beaconsButton?.isHidden = !(admitsBeacons ?? false)
            }
        }
    }
    var stageName: String? {
        didSet {
            navBarHelper.configureNavigationBar(title: stageName ?? "")
        }
    }
    var endDate: String? {
        didSet {
            endDateLabel?.text = endDate
        }
    }
    var finished: Bool? {
        didSet {
            if finished == true {
                finishStage?.isHidden = true
                endDateLabel?.isHidden = false
                finishedStageLabel?.isHidden = false
                beaconsButton?.isHidden = true
            } else {
                finishStage?.isHidden = false
                endDateLabel?.isHidden = true
                finishedStageLabel?.isHidden = true
                beaconsButton?.isHidden = false
            }
            // TODO: move this to presenter
            if Environment.currentUserRole == .usuario {
                finishStage?.isHidden = true
            }
        }
    }
    var tabs: [StageDetailTab]? = [] {
        didSet {
            setupControllers()
            setupTopTabBar()
            if lastDisplayedTab < containedViewControllers.count {
                tabBarView?.selectTab(at: lastDisplayedTab)
                showControllerForTab(at: lastDisplayedTab)
            }
        }
    }
    var lotIdentifierText: String?
    var currentContainedViewController: UIViewController?
    var presenter: StageDetailPresenterProtocol?
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    private var lastDisplayedTab = 0
    
    var beaconsOptions: [Beacon] = []
    var beacons: [Beacon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBeaconsSelector()
        lotIdentifierLabel?.text = "#\(lotIdentifierText ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        finishStage?.isHidden = true
        endDateLabel?.isHidden = true
        finishedStageLabel?.isHidden = true
        beaconsButton?.isHidden = true
        showLoadingOverlay()
        presenter?.fetchComponents()
    }
    
    private func setupControllers() {
        tabsTitles = []
        containedViewControllers.forEach({ $0.removeFromParentAndSuperview() })
        containedViewControllers = []
        tabs?.forEach({ tab in
            let topTab = ScrollableTopTabBar.ScrollableTopTab(title: tab.title, badgeText: String(describing: tab.badge ?? ""))
            tabsTitles.append(topTab)
            containedViewControllers.append(getTabContentController(forTab: tab))
        })
    }
    
    private func getTabContentController(forTab tab: StageDetailTab) -> UIViewController {
        return StageDetailTabWireframe.getViewController(tab: tab, delegate: self)
    }
        
    func tabWasChanged(to index: Int) { }
    
    func tabWasManuallyChanged(to index: Int) {
        lastDisplayedTab = index
    }
    
    @IBAction private func finishStageTapped() {
        showLoadingOverlay()
        presenter?.finishTapped()
    }
    
    private func setupBeaconsSelector() {
        beaconsButton?.handleTap = {
            let selected = self.beaconsOptions.filter({ beacon in
                return self.beacons.contains(where: { $0.id == beacon.id })
            })
            self.showSelector(mode: .multipleSelection, options: self.beaconsOptions, selectedOptions: selected, title: "Actualizar Beacons")
        }
    }
    
    private func showSelector(mode: SelectorDialogMode, options: [SelectorDialogOption], selectedOptions: [SelectorDialogOption], title: String) -> SelectorDialogViewController {
        let vc = SelectorDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = title
        vc.buttonText = "Guardar"
        vc.mode = mode
        vc.options = options
        vc.preselectedOptions = selectedOptions
        vc.delegate = self
        addChild(viewController: vc, in: view)
        return vc
    }
}

extension StageDetailViewController: SelectorDialogDelegate {
    func selector(dialog: SelectorDialogViewController, didTapButtonWith selectedOptions: [SelectorDialogOption]) {
        let selectedBeacons = selectedOptions.compactMap({ $0 as? Beacon })
        showLoadingOverlay()
        presenter?.updateBeacons(selectedBeacons)
    }
}

extension StageDetailViewController: StageDetailViewProtocol {
    
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateUI(stageName: String?, endDate: String?, finished: Bool?, tabs: [StageDetailTab]?, admitsBeacons: Bool?) {
        self.stageName = stageName
        self.endDate = endDate
        self.finished = finished
        self.tabs = tabs
        self.admitsBeacons = admitsBeacons
        hideLoadingOverlay()
    }
    
    func askFinishingConfirmation(message: String) {
        hideLoadingOverlay()
        let vc = ConfirmDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = "Finalizar Etapa"
        vc.body = message
        vc.buttonText = "Aceptar"
        vc.cancelButtonText = "Cancelar"
        vc.delegate = self
        addChild(viewController: vc, in: view)
    }
    
    func showImposibleFinishingMessage(message: String) {
        hideLoadingOverlay()
        let vc = AlertDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = "Finalizar Etapa"
        vc.body = message
        vc.buttonText = "Aceptar"
        vc.delegate = self
        addChild(viewController: vc, in: view)
    }
    
    func showFinishigSuccess() {
        hideLoadingOverlay()
        navigationController?.popViewController(animated: true)
    }
    
    func set(beaconsOptions: [Beacon], selectedBeacons: [Beacon]) {
        self.beaconsOptions = beaconsOptions
        self.beacons = selectedBeacons
    }
    
    func showBeaconsUpdateSuccess() {
        hideLoadingOverlay()
    }
}

extension StageDetailViewController: StageDetailTabPresenterDelegate {
    func stageDetailTabPresenterRequestFullUIReload() {
        showLoadingOverlay()
        presenter?.fetchComponents()
    }
}

extension StageDetailViewController: ConfirmDialogDelegate {

    func confirmDialogDidTapAcceptButton(_ dialog: ConfirmDialogViewController) {
        showLoadingOverlay()
        presenter?.finishConfirmationTapped()
    }
    
    func confirmDialogDidTapCancelButton(_ dialog: ConfirmDialogViewController) {
        // nothing
    }
}

extension StageDetailViewController: AlertDialogDelegate {

    func alertDialogDidTapAcceptButton(_ dialog: AlertDialogViewController) {
        // nothing
    }
}
