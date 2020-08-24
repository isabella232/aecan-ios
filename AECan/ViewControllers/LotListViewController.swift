//
//  LotListViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 03/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotListViewController: UIViewController, UITableViewDelegate, ViewControllerWithLoadingOverlay {
    
    enum CellType {
        case lot(Int)
    }
    
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var emptyLabel: UILabel?
    var presenter: LotListPresenterProtocol?
    var cells: [CellType] = []
    var lots: [Lot] = [] {
        didSet {
            updateUI()
            emptyLabel?.isHidden = !lots.isEmpty
        }
    }
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func fetchData() {
        showLoadingOverlay()
        presenter?.fetchData()
    }
    
    private func updateUI() {
        cells = []
        lots.enumerated().forEach({ (index, _) in
            cells.append(.lot(index))
        })
        
        tableView?.reloadData()
        hideLoadingOverlay()
    }
        
    private func setupTable() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "LotListCell", bundle: .main), forCellReuseIdentifier: "cell")
        tableView?.separatorColor = .clear
        tableView?.estimatedRowHeight = 30
        tableView?.separatorInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        tableView?.allowsSelection = true
    }
}

extension LotListViewController: LotListViewProtocol {
    
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message)
    }
    
    func updateLotsUI(lots: [Lot]) {
        self.lots = lots
    }
}

extension LotListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        
        switch cellType {
        case .lot(let lotOptionIndex):
            let lotOption = lots[lotOptionIndex]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LotListCell, let status = lotOption.status {
                cell.lotIdentifierText = lotOption.identifier
                cell.varietyShortNameText = lotOption.varietyShortName
                cell.selectionStyle = .none
                cell.hasAttachement = lotOption.hasPdf

                switch status {
                case .started:
                    cell.mode = .inProgress
                    cell.topDescText = lotOption.currentStage?.name
                    cell.bottomDescText = lotOption.startDate?.shortFormat1
                case .finished:
                    cell.mode = .finished
                    cell.topDescText = lotOption.startDate?.shortFormat1
                    cell.bottomDescText = lotOption.endDate?.shortFormat1 ?? ""
                    cell.weightText = (lotOption.weight ?? "") + " kg"
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let lotOption = lots[indexPath.row]

        let vc = LotDetailWireframe.getViewController(lotId: lotOption.id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}
