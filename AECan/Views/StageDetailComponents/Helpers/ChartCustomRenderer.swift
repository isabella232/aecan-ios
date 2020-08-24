//
//  ChartCustomRenderer.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Charts

class ChartCustomRenderer: LineChartRenderer {
    
    var entries: [StageDetailChartComponent.Entry]?
    var unit: String?
    
    override func drawHighlighted(context: CGContext, indices: [Highlight]) {
        guard
            let dataProvider = dataProvider,
            let lineData = dataProvider.lineData
            else { return }
        
        context.saveGState()
        
        for high in indices
        {
            guard let set = lineData.getDataSetByIndex(high.dataSetIndex) as? ILineChartDataSet
                , set.isHighlightEnabled
                else { continue }
            
            guard let e = set.entryForXValue(high.x, closestToY: high.y) else { continue }
            
            if !isInBoundsX(entry: e, dataSet: set)
            {
                continue
            }
            
            let entry = entries?.first(where: { $0.index == Int(e.x) })
            
            context.setStrokeColor(set.highlightColor.cgColor)
            context.setLineWidth(set.highlightLineWidth)
            
            let x = e.x // get the x-position
            let y = e.y * Double(animator.phaseY)
            
            let trans = dataProvider.getTransformer(forAxis: set.axisDependency)
            let pt = trans.pixelForValues(x: x, y: y)
            
            // Vertical line
            if set.isVerticalHighlightIndicatorEnabled
            {
                context.beginPath()
                context.move(to: CGPoint(x: pt.x, y: viewPortHandler.contentTop))
                context.addLine(to: CGPoint(x: pt.x, y: viewPortHandler.contentBottom))
                context.strokePath()
            }
            
            if let marker = UIImage(named: "chart_marker")?.cgImage {
                context.draw(marker, in: CGRect(x: pt.x - 5.5, y: pt.y - 5.5, width: 11, height: 11))
            }
            
            // Value Text
            let valueAttributes = [
                NSAttributedString.Key.font: UIFont.montserratFont(ofSize: 12, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.ucBlackText100
            ]
            let valueString = NSAttributedString(string: String(format: "%.2f\(unit ?? "")", entry?.value ?? 0), attributes: valueAttributes)
            let valueSize = valueString.size()
            
            let valuePoint = CGPoint(x: defineXPositionValueLabel(pointX: pt.x, valueSize: valueSize.width), y:8)
            valueString.draw(at: valuePoint)
                
            // Label Text and Background
            let labelAttributes = [
                NSAttributedString.Key.font: UIFont.montserratFont(ofSize: 10, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            let labelString = NSAttributedString(string: entry?.label ?? "", attributes: labelAttributes)
            let labelSize = labelString.size()
            
            let labelTextSidesMargin: CGFloat = 5
            let labelBackgroundHeight: CGFloat = 20
            
            let labelBackgroundRect = CGRect(x: defineXPositionBackgroundLabel(pointX: pt.x, labelSize: labelSize.width, sidesMargin: labelTextSidesMargin), y: 8 + valueSize.height + 6, width: labelSize.width + labelTextSidesMargin * 2, height: labelBackgroundHeight)
            let path = UIBezierPath(roundedRect: labelBackgroundRect, cornerRadius: labelBackgroundHeight / 2)
            context.setFillColor(UIColor.mainColor150.cgColor)
            path.fill()
            
            let labelTextTopMargin = (labelBackgroundHeight - labelSize.height) / 2
            let labelPoint = CGPoint(x: labelBackgroundRect.minX + labelTextSidesMargin, y: labelBackgroundRect.minY + labelTextTopMargin)
            labelString.draw(at: labelPoint)
        }
        
        context.restoreGState()
    }
    
    private func defineXPositionValueLabel(pointX: CGFloat, valueSize: CGFloat) -> CGFloat {
        if (pointX - 6 - valueSize) > valueSize {
            return pointX - 6 - valueSize
        } else {
            return pointX + 6
        }
    }
    
    // invert sides green label
    private func defineXPositionBackgroundLabel(pointX: CGFloat, labelSize: CGFloat, sidesMargin: CGFloat) -> CGFloat {
        if (pointX - 6 - labelSize - sidesMargin * 2) > (labelSize - sidesMargin * 2) {
            return pointX - 6 - labelSize - sidesMargin * 2
        } else {
            return pointX + 6
        }
    }
    
    func isInBoundsX(entry e: ChartDataEntry, dataSet: IBarLineScatterCandleBubbleChartDataSet) -> Bool
    {
        let entryIndex = dataSet.entryIndex(entry: e)
        return Double(entryIndex) < Double(dataSet.entryCount) * animator.phaseX
    }
}
