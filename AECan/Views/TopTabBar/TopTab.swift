//
//  TopTab.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class TopTab: UIView {
    
    @IBOutlet private var label: UILabel?
    @IBOutlet private var selectionIndicator: UIView?
    @IBOutlet private var badgeLabel: UILabel?
    @IBOutlet private var badgeBackgroundView: UIView?
    @IBOutlet private var leadingLabelConstraint: NSLayoutConstraint?
    @IBOutlet private var leadingLabelConstraintToBadge: NSLayoutConstraint?
    
    var handleTap: (() -> Void)?
    var isSelected: Bool = false {
        didSet {
            label?.textColor = isSelected ? .accentColor100 : .ucGrey280
            selectionIndicator?.backgroundColor = isSelected ? .accentColor100 : .clear 
        }
    }
    
    var badgeText: String? {
        didSet {
            badgeLabel?.text = badgeText
            setupUI()
        }
    }
    
    var title: String? {
        get { label?.text }
        set { label?.text = newValue }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRoundedView()
        setupUI()
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    private func setupRoundedView() {
        badgeBackgroundView?.layer.cornerRadius = (badgeBackgroundView?.frame.size.width ?? 0) / 2
    }
    
    private func setupUI() {
        if let badgeText = badgeText, !badgeText.isEmpty {
           leadingLabelConstraint?.constant = 33
            badgeBackgroundView?.isHidden = false
        } else {
            badgeBackgroundView?.isHidden = true
            leadingLabelConstraint?.constant = 0
        }
        setNeedsUpdateConstraints()
    }
    
    @objc private func tapped() {
        self.handleTap?()
    }
}
