//
//  StageDetailChartComponentChartView.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit
import Charts

class StageDetailChartComponentChartView: UIView {
    
    @IBOutlet var lineChartView: LineChartView?
    @IBOutlet var buttonsStackView: UIStackView?
    @IBOutlet var emptyLabel: UILabel?
    
    var component: StageDetailChartComponent? { didSet { setupInfo() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emptyLabel?.isHidden = true
        configureChart()
    }
    
    private func setupInfo() {
        DispatchQueue.main.async {
            self.configureSeriesButtons()
            self.showSeries(at: 0)
        }
    }
    
    private func configureSeriesButtons() {
        buttonsStackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        component?.series.enumerated().forEach({ (index, series) in
            let button = ChartSeriesSelectionButton()
            button.setTitle(series.label, for: .normal)
            button.tag = index
            buttonsStackView?.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        })
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        showSeries(at: sender.tag)
    }
    
    private func showSeries(at index: Int) {
        guard let chart = lineChartView else { return }
        guard index < (component?.series ?? []).count else { return }
        
        if index < buttonsStackView?.arrangedSubviews.count ?? 0 {
            buttonsStackView?.arrangedSubviews.forEach({ (view) in
                (view as? UIButton)?.backgroundColor = .ucGrey250
            })
            (buttonsStackView?.arrangedSubviews[index] as? UIButton)?.backgroundColor = .mainColor150
        }
        
        if let series = component?.series[index] {
            configureSet(series: series)
        }
        
        chart.highlightValue(nil)
    }
    
    private func configureChart() {
        guard let chart = lineChartView else { return }
        
        chart.xAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.legend.enabled = false
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        chart.leftAxis.labelPosition = .outsideChart
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.labelTextColor = .ucGrey400
        chart.leftAxis.valueFormatter = ChartLeftAxisValueFormatter(unit: "")
    }
    
    private func configureSet(series: StageDetailChartComponent.Series) {
        guard let chart = lineChartView else { return }
        
        let entries = series.entries
        
        let chartDataEntries = entries.compactMap { (entry) -> ChartDataEntry? in
            guard let index = entry.index, let y = entry.value else { return nil }
            let x = Double(index)
            return ChartDataEntry(x: x, y: y)
        }
        
        let set1 = LineChartDataSet(entries: chartDataEntries, label: "")
        set1.axisDependency = .left
        set1.setColor(.mainColor300)
        set1.lineWidth = 2.0
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.highlightColor = .ucGrey400
        set1.highlightEnabled = true
        set1.highlightLineWidth = 1.0
        
         if set1.entries.count == 1 {
                set1.drawCirclesEnabled = true
                set1.circleRadius = 5
                set1.setCircleColors(.white)
                set1.circleHoleColor = .mainColor300
            }
        if set1.entries.isEmpty {
            emptyLabel?.isHidden = false
        } else {
            emptyLabel?.isHidden = true
        }

        
        let renderer = ChartCustomRenderer(dataProvider: chart, animator: chart.chartAnimator, viewPortHandler: chart.viewPortHandler)
        renderer.entries = entries
        renderer.unit = component?.unit
        chart.renderer = renderer
        chart.leftAxis.valueFormatter = ChartLeftAxisValueFormatter(unit: component?.unit ?? "")
        
        let data = LineChartData(dataSet: set1)
        lineChartView?.data = data
    }
}
