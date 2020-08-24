//
//  HeaderLotData.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 10/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class HeaderLotData: UITableViewCell {
    
    enum CellMode {
        case withBeacons
        case withoutBeacons
    }
    
    @IBOutlet private var lotIdentifierLabel: UILabel?
    @IBOutlet private var varietyShortNameLabel: UILabel?
    @IBOutlet private var varietyBackgroundView: UIView?
    @IBOutlet private var varietyViewTopConstraint: NSLayoutConstraint?
    @IBOutlet private var beaconsTappableView: TappableUIView?
    @IBOutlet private var beaconsTopConstraint: NSLayoutConstraint?
    
    var handleBeaconsTapped: (() -> Void)?
    
    var cellMode: CellMode? {
        didSet {
            if let cellMode = cellMode {
                switch cellMode {
                case .withBeacons:
                    varietyViewTopConstraint?.constant = 47
                    beaconsTappableView?.isHidden = false
                    beaconsTopConstraint?.constant = 16
                case .withoutBeacons:
                    varietyViewTopConstraint?.constant = 31
                    beaconsTappableView?.isHidden = true
                }
            }
        }
    }
    
    var lotIdentifierText: String? {
        didSet {
            lotIdentifierLabel?.text = lotIdentifierText
        }
    }
    
    var varietyShortNameText: String? {
        didSet {
            varietyShortNameLabel?.text = varietyShortNameText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCornerRadiusToVarietyView()
        handleBeaconsViewTapped()
    }
    
    private func handleBeaconsViewTapped() {
        beaconsTappableView?.handleTap = {
            self.handleBeaconsTapped?()
        }
    }
    
    private func setupCornerRadiusToVarietyView() {
        varietyBackgroundView?.layer.cornerRadius = (varietyBackgroundView?.bounds.height ?? 0) / 2
    }
}
