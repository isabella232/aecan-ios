//
//  LotDetailViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 10/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotDetailViewController: UIViewController, ViewControllerWithLoadingOverlay {
    
    enum CellType {
        case header
        case separator
        case detail(Int)
    }
    
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var analysisButton: UIButton?
    @IBOutlet private var aeternityButton: UIButton?
    
    var presenter: LotDetailPresenterProtocol?
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    private var cells: [CellType] = []
    private var lot: Lot? {
        didSet {
            updateUI()
        }
    }
    private var beaconsModal: SelectorDialogViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navBarHelper.configureNavigationBar(title: "Detalle del lote")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingOverlay()
        presenter?.fetchLotDetail()
    }
    
    private func updateUI() {
        cells = []
        cells.append(.header)
        cells.append(.separator)
        lot?.stages?.enumerated().forEach({ (index, _) in
            cells.append(.detail(index))
        })
        tableView?.reloadData()
        analysisButton?.isHidden = !(lot?.hasPdf ?? false)
        let showAeternityButton: Bool = Environment.currentUserRole == .usuario && (lot?.hasAeternityLink ?? false)
        aeternityButton?.isHidden = !showAeternityButton
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "HeaderLotData", bundle: .main), forCellReuseIdentifier: "header")
        tableView?.register(UINib(nibName: "StagesSeparator", bundle: .main), forCellReuseIdentifier: "separator")
        tableView?.register(UINib(nibName: "StageDetail", bundle: .main), forCellReuseIdentifier: "detail")
        tableView?.separatorColor = .clear
        tableView?.estimatedRowHeight = 30
        tableView?.separatorInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        tableView?.allowsSelection = true
    }
    
    func showSelector(mode: SelectorDialogMode, options: [SelectorDialogOption], selectedOptions: [SelectorDialogOption], title: String) -> SelectorDialogViewController {
        let vc = SelectorDialogViewController.instantiateFromStoryboard()
        vc.dialogTitle = title
        vc.buttonText = "Aceptar"
        vc.mode = mode
        vc.options = options
        vc.preselectedOptions = selectedOptions
        addChild(viewController: vc, in: view)
        return vc
    }
    
    func showBeaconsSelector(options: [Beacon], selected: [Beacon]) {
        beaconsModal = showSelector(mode: .readOnly, options: options, selectedOptions: selected, title: "Beacons asociados")
    }
    
    @IBAction private func showAnalysisTapped() {
        let vc = WebViewViewController()
        vc.url = lot?.pdfUrl
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func showAeternityTransactionTapped() {
        let vc = WebViewViewController()
        vc.url = lot?.aeternityLink
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LotDetailViewController: LotDetailViewProtocol {
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateView(lot: Lot?) {
        self.lot = lot
        hideLoadingOverlay()
    }
}

extension LotDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        
        switch cellType {
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "header") as? HeaderLotData {
                if let isEmpty = lot?.beacons?.isEmpty, isEmpty == false {
                    cell.cellMode = .withBeacons
                } else {
                    cell.cellMode = .withoutBeacons
                }
                cell.selectionStyle = .none
                cell.lotIdentifierText = "#\(lot?.identifier ?? "")"
                cell.varietyShortNameText = lot?.varietyShortName
                cell.handleBeaconsTapped = {
                    self.showBeaconsSelector(options: self.lot?.beacons ?? [], selected: self.lot?.beacons ?? [])
                }
                return cell
            }
        case .separator:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "separator") as? StagesSeparator {
                cell.selectionStyle = .none
                return cell
            }
        case .detail(let stageIndex):
            let stage = lot?.stages?[stageIndex]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as? StageDetail, let stage = stage {
                cell.selectionStyle = .none
                if (stageIndex == (lot?.stages?.endIndex ?? 0) - 1) {
                    cell.lastStage = true
                }
                cell.cellMode = stage.state
                cell.stageNameText = stage.name
                cell.startDateText = stage.startDate?.shortFormat1
                cell.endDateText = stage.endDate?.shortFormat1
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = cells[indexPath.row]
        
        switch cellType {
        case .header:
            print("nothing to do")
        case .separator:
            print("nothing to do")
        case .detail(let stageIndex):
            if let stage = lot?.stages?[stageIndex], stage.state != .pending {
                let vc = StageDetailWireframe.getViewController(stageId: stage.id, lotIdentifier: lot?.identifier)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
