//
//  StageDetailTabViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailTabViewController: UIViewController, ViewControllerWithLoadingOverlay {
    
    // Presenter
    var presenter: StageDetailTabPresenterProtocol?
    
    // Data
    private var tab: StageDetailTab? {
        didSet {
            if components.isEmpty {
                emptyMessageLabel?.text = tab?.emptyMessage ?? ""
                tableView?.isHidden = true
            } else {
                tableView?.isHidden = false
                emptyMessageLabel?.isHidden = true
                tableView?.reloadData()
            }
        }
    }
    private var components: [StageDetailComponent] { tab?.components ?? [] }
    
    // Outlets
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var emptyMessageLabel: UILabel?
    
    // Loading
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.requestData()
    }
}

extension StageDetailTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTable() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 100
        tableView?.allowsSelection = false
        tableView?.separatorColor = .clear
       
        for componentType in StageDetailComponent.ComponentType.allCases {
            let cellName = componentType.cellName
            self.tableView?.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = components[indexPath.row]
        return getCellFor(component: component) ?? UITableViewCell()
    }
    
    private func getCellFor(component: StageDetailComponent) -> UITableViewCell? {
        var cell: StageDetailComponentCellProtocol?
        
        guard let componentType = component.componentType else {
            log.warning("componentType cant be nil")
            return nil
        }
        
        let cellName = componentType.cellName
        
        cell = tableView?.dequeueReusableCell(withIdentifier: cellName) as? StageDetailComponentCellProtocol
        cell?.setComponent(component)
        cell?.context = self.parent
        cell?.delegate = self
        
        return cell
    }
}

extension StageDetailTabViewController: StageDetailTabViewProtocol {
    
    func update(tab: StageDetailTab) {
        self.tab = tab
    }
}

extension StageDetailTabViewController: StageDetailComponentCellDelegate {
    
    func stageDetailComponentCellShouldBeUpdated<T: StageDetailComponent>(cell: StageDetailComponentCell<T>) {
        UIView.performWithoutAnimation {
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
    }
    
    func stageDetailComponentCellMustReloadParent() {
        presenter?.reloadParentUI()
    }
    
    func showLoadingUIForStageDetailComponent() {
        presenter?.blockUI()
    }
    
    func hideLoadingUIForStageDetailComponent() {
        presenter?.releaseUI()
    }
    
    func showError(_ error: String?) {
        parent?.showOkDialog(title: "", message: errorMessage(error))
    }
}
