//
//  StageDetailProceduresListComponenentItemView.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol StageDetailProceduresListComponenentItemViewDelegate: class {
    func stageDetailProceduresListComponenent(itemView: StageDetailProceduresListComponenentItemView, toogleStateChangedTo expanded: Bool)
}

class StageDetailProceduresListComponenentItemView: UIView {
    
    // Outlets
    @IBOutlet private var tappableView: UIView?
    @IBOutlet private var iconImageView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var chevronImageView: UIImageView?
    @IBOutlet private var stackView: UIStackView?
    @IBOutlet private var greenMessageLabel: UILabel?
    @IBOutlet private var button: UIButton?
    /// Constraint between the action button and the bottom. It should be active when expanded
    @IBOutlet private var buttonAndBottomConstraint: NSLayoutConstraint?
    /// Constraint between the title and the bottom. It should be active when collapsed
    @IBOutlet private var titleAndBottomConstraint: NSLayoutConstraint?
    @IBOutlet private var stackViewAndBottomConstraint: NSLayoutConstraint?
    
    // Delegate
    var delegate: StageDetailProceduresListComponenentItemViewDelegate?
    
    // Data
    var item: StageDetailProceduresListComponent.Item? { didSet { itemUpdated() }}
    var editable = false
    
    // State
    private var expanded = false { didSet { updateToggleState() }}
    
    // Clousures
    var handleButtonTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateToggleState()
        setupTap()
    }
    
    private func setupTap() {
        tappableView?.isUserInteractionEnabled = true
        tappableView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggle)))
    }
    
    @objc private func toggle() {
        self.expanded = !self.expanded
        self.delegate?.stageDetailProceduresListComponenent(itemView: self, toogleStateChangedTo: expanded)
    }
    
    /// Collapses the item
    func close() {
        self.expanded = false
    }
    
    private func updateToggleState() {
        buttonAndBottomConstraint?.isActive = expanded
        titleAndBottomConstraint?.isActive = !expanded
        titleAndBottomConstraint?.constant = 20
        stackView?.isHidden = !expanded
        greenMessageLabel?.isHidden = !expanded || (item?.message?.isEmpty ?? false)
        updateButtonVisibility()
        chevronImageView?.transform = CGAffineTransform(rotationAngle: expanded ? CGFloat.pi : 0)
        updateBottomConstraints()
    }
    
    private func itemUpdated() {
        stackView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        titleLabel?.text = item?.title
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        for text in item?.description ?? [] {
            guard !text.isEmpty else { continue }
            let numberOfTabs = text.components(separatedBy: "\t").count - 1 // a way to count occurences of "\t"
            let timmedText = text.replacingOccurrences(of: "\t", with: "")
            let newText = NSMutableAttributedString(string: timmedText, attributes: [
                .paragraphStyle: paragraphStyle
            ])
            let view = ProcedureBodyView.instantiateFromXib()
            view.bodyText = newText
            view.leftLabelConstraint?.constant = CGFloat(numberOfTabs * 20)
            
            stackView?.addArrangedSubview(view)
        }
    
        if let message = item?.message, !message.isEmpty {
            greenMessageLabel?.text = message
        } else {
            greenMessageLabel?.isHidden = true
        }
        
        updateButtonVisibility()
        updateUIFromItemState()
        updateBottomConstraints()
    }
    
    private func updateButtonVisibility() {
        if let buttonText = item?.buttonText {
            button?.setTitle(buttonText, for: .normal)
            button?.isHidden = !expanded || !editable
        } else {
            button?.isHidden = true
        }
    }
    
    private func updateBottomConstraints() {
        guard expanded else { return }
        if (button?.isHidden ?? false) && (greenMessageLabel?.isHidden ?? false) {
            stackViewAndBottomConstraint?.isActive = true
            stackViewAndBottomConstraint?.constant = 16
            buttonAndBottomConstraint?.isActive = false
        } else {
            stackViewAndBottomConstraint?.isActive = false
            buttonAndBottomConstraint?.isActive = true
        }
    }
    
    private func updateUIFromItemState() {
        switch item?.state {
        case .notStarted:
            iconImageView?.image = UIImage(named: "ic_gray_check.png")
            titleLabel?.textColor = .ucGrey450
            chevronImageView?.image = UIImage(named: "green_down_chevron.png")
            chevronImageView?.tintColor = .mainColor400
        case .started:
            iconImageView?.image = UIImage(named: "ic_gray_check.png")
            titleLabel?.textColor = .ucGrey450
            chevronImageView?.image = UIImage(named: "green_down_chevron.png")
            chevronImageView?.tintColor = .mainColor400
        case .finished:
            iconImageView?.image = UIImage(named: "ic_greencheck.png")
            titleLabel?.textColor = .ucBlackText100
            chevronImageView?.image = UIImage(named: "green_down_chevron.png")
            chevronImageView?.tintColor = .mainColor400
        case .cancelled:
            iconImageView?.image = UIImage(named: "ic_gray_cancel.png")
            titleLabel?.textColor = .ucGrey450
            chevronImageView?.image = UIImage(named: "green_down_chevron.png")
            chevronImageView?.tintColor = .mainColor400
        case .expired:
            iconImageView?.image = UIImage(named: "ic_red_cancel.png")
            titleLabel?.textColor = .ucRed100
            chevronImageView?.image = UIImage(named: "chrevron_down_red.png")
        default:
            print("nada")
        }
    }
    
    @IBAction private func buttonTapped() {
        handleButtonTap?()
    }
}
