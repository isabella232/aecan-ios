//
//  StageDetail.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 10/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetail: UITableViewCell {
    
    @IBOutlet private var currentStatusView: UIView?
    @IBOutlet private var stageNameLabel: UILabel?
    @IBOutlet private var endDateLabel: UILabel?
    @IBOutlet private var startDateLabel: UILabel?
    @IBOutlet private var subDetailView: UIView?
    @IBOutlet private var stageNameBottomConstraint: NSLayoutConstraint?
    @IBOutlet private var stageNameBottomToSubDetailViewConstraint: NSLayoutConstraint?
    @IBOutlet private var externalCircleIndicator: UIView?
    @IBOutlet private var internalCircleIndicator: UIView?
    @IBOutlet private var chevronImageView: UIImageView?
    @IBOutlet private var pathIndicatorView: UIView?
    @IBOutlet private var tailStageNameToFinishDateConstraint: NSLayoutConstraint?
    @IBOutlet private var tailStageNameToCurrentStatusConstraint: NSLayoutConstraint?
    
    var lastStage: Bool = false {
        didSet {
            pathIndicatorView?.isHidden = lastStage
        }
    }
    
    // May can be improved (?
    var cellMode: Stage.StageState? {
        didSet {
            guard let cellMode = cellMode else { return }
            switch cellMode {
            case .pending:
                stageNameLabel?.textColor = UIColor.ucGrey280
                stageNameBottomToSubDetailViewConstraint?.isActive = false
                stageNameBottomConstraint?.isActive = true
                stageNameBottomConstraint?.constant = 18
                currentStatusView?.isHidden = true
                endDateLabel?.isHidden = true
                subDetailView?.isHidden = true
                internalCircleIndicator?.isHidden = true
                chevronImageView?.isHidden = true
                internalCircleIndicator?.backgroundColor = UIColor.ucGrey280
                externalCircleIndicator?.layer.borderColor = UIColor.ucGrey280.cgColor
                tailStageNameToFinishDateConstraint?.isActive = false
                tailStageNameToCurrentStatusConstraint?.isActive = false
            case .inProgress:
                stageNameLabel?.textColor = UIColor.mainColor150
                stageNameBottomToSubDetailViewConstraint?.isActive = true
                stageNameBottomConstraint?.isActive = false
                stageNameBottomToSubDetailViewConstraint?.constant = 15
                currentStatusView?.isHidden = false
                endDateLabel?.isHidden = true
                subDetailView?.isHidden = false
                internalCircleIndicator?.isHidden = false
                chevronImageView?.isHidden = false
                internalCircleIndicator?.backgroundColor = UIColor.mainColor150
                externalCircleIndicator?.layer.borderColor = UIColor.mainColor150.cgColor
                tailStageNameToFinishDateConstraint?.isActive = false
                tailStageNameToCurrentStatusConstraint?.isActive = true
            case .finished:
                stageNameLabel?.textColor = UIColor.mainColor400
                stageNameBottomToSubDetailViewConstraint?.isActive = false
                stageNameBottomConstraint?.isActive = true
                stageNameBottomConstraint?.constant = 18
                currentStatusView?.isHidden = true
                endDateLabel?.isHidden = false
                subDetailView?.isHidden = true
                internalCircleIndicator?.isHidden = false
                chevronImageView?.isHidden = false
                internalCircleIndicator?.backgroundColor = UIColor.mainColor400
                externalCircleIndicator?.layer.borderColor = UIColor.mainColor400.cgColor
                tailStageNameToFinishDateConstraint?.isActive = true
                tailStageNameToCurrentStatusConstraint?.isActive = false
            }
        }
    }
    
    var stageNameText: String? {
        didSet {
            stageNameLabel?.text = stageNameText
        }
    }
    
    var endDateText: String? {
        didSet {
            endDateLabel?.text = "Fin: \(endDateText ?? "")"
        }
    }
    
    var startDateText: String? {
        didSet {
            startDateLabel?.text = "Inicio: \(startDateText ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCircleIndicators()
        setupCornerRadiusToCurrentStatusView()
    }
    
    private func setupCircleIndicators() {
        externalCircleIndicator?.layer.cornerRadius = (externalCircleIndicator?.frame.size.width ?? 0) / 2
        externalCircleIndicator?.layer.borderWidth = 1.0
        
        internalCircleIndicator?.layer.cornerRadius = (internalCircleIndicator?.frame.size.width ?? 0) / 2
    }
    
    private func setupCornerRadiusToCurrentStatusView() {
        currentStatusView?.layer.cornerRadius = (currentStatusView?.bounds.height ?? 0) / 2
    }
}
