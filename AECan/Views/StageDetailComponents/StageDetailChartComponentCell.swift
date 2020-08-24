//
//  StageDetailChartComponentCell.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailChartComponentCell: StageDetailComponentCell<StageDetailChartComponent>, CellWithCard {

    // MARK: - Properties
    
    @IBOutlet var card: UIView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var chartButton: UIButton?
    @IBOutlet var listButton: UIButton?
    @IBOutlet var mainViewContainer: UIView?
    @IBOutlet var createButton: UIButton?

    // MARK: - Callbacks
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = StageDetailChartComponentPresenter(view: self)
        createButton?.layer.cornerRadius = 12
        setupCard()
    }
    
    override func componentUpdated() {
        super.componentUpdated()
        createButton?.isHidden = !(component?.editable ?? false)
        presenter?.setComponent(component)
        titleLabel?.text = component?.title
        chartViewButtonTapped()
    }
    
    // MARK: - Tabs general management
    
    private func removeCurrentTab() {
        mainViewContainer?.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func show(view: UIView) {
        mainViewContainer?.addEmbedded(view: view)
        delegate?.stageDetailComponentCellShouldBeUpdated(cell: self)
    }
    
    
    // MARK: - Chart view
    
    @IBAction private func chartViewButtonTapped() {
        showChartButtonAsSelected()
        showChart()
    }
    
    private func showChart() {
        removeCurrentTab()
        let view = StageDetailChartComponentChartView.instantiateFromXib()
        show(view: view)
        view.component = component
    }
    
    private func showChartButtonAsSelected() {
        chartButton?.tintColor = UIColor.mainColor300
        listButton?.tintColor = UIColor.ucGrey250
    }
    
    // MARK: - List view
    
    @IBAction private func listViewButtonTapped() {
        showListButtonAsSelected()
        showList()
    }
    
    private func showList() {
        removeCurrentTab()
        let view = StageDetailChartComponentListView.instantiateFromXib()
        print(">>>>>>>>\(component)")
        view.component = component
        show(view: view)
    }
    
    private func showListButtonAsSelected() {
        chartButton?.tintColor = UIColor.ucGrey250
        listButton?.tintColor = UIColor.mainColor300
    }
    
    // MARK: - Add value
    
    @IBAction private func addValueTapped() {
        guard let action = component?.componentAction else { return }
        presenter?.execute(action: action)
    }
}

extension StageDetailChartComponentCell: StageDetailChartComponentViewProtocol { }
