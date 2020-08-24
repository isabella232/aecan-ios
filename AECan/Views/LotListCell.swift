//
//  LotListCell.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 03/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotListCell: UITableViewCell {
    
    enum ListMode {
        case inProgress
        case finished
    }
    
    // Outlets
    @IBOutlet private var lotIdentifier: UILabel?
    @IBOutlet private var varietyShortName: UILabel?
    @IBOutlet private var topDescLabel: UILabel?
    @IBOutlet private var bottomDescLabel: UILabel?
    @IBOutlet private var weightLabel: UILabel?
    @IBOutlet private var clipImage: UIImageView?
    @IBOutlet private var leftView: UIView?
    @IBOutlet private var varietyBackgroundView: UIView?
    @IBOutlet private var wrapperView: UIView?
    @IBOutlet var chevronTappableView: TappableUIView?
    
    // Properties
    var mode: ListMode? {
        didSet {
            if let mode = mode {
                switch mode {
                case .inProgress:
                    leftView?.backgroundColor = .mainColor150
                    weightLabel?.isHidden = true
                case .finished:
                    leftView?.backgroundColor = .ucGrey300
                    weightLabel?.isHidden = false
                }
            }
        }
    }
    
    var lotIdentifierText: String? {
        didSet {
            lotIdentifier?.text = "#\(lotIdentifierText ?? "")"
        }
    }
    
    var varietyShortNameText: String? {
        didSet {
            varietyShortName?.text = varietyShortNameText
        }
    }
    
    var weightText: String? {
        didSet {
            weightLabel?.text = weightText
        }
    }
    
    var topDescText: String? {
        didSet {
            if let topDescText = topDescText {
                topDescLabel?.attributedText = setupTopDescAttributedText(text: topDescText)
            }
        }
    }
    
    var bottomDescText: String? {
        didSet {
            if let bottomDescText = bottomDescText {
                bottomDescLabel?.attributedText = setupBottomDescAttributedText(text: bottomDescText)
            }
        }
    }
    
    var hasAttachement: Bool = false {
        didSet {
            clipImage?.isHidden = !hasAttachement
        }
    }
    
    // methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRoundedView()
        setupShadow()
    }
    
    private func setupShadow() {
        wrapperView?.layer.masksToBounds = false
        wrapperView?.layer.shadowColor = UIColor.black.cgColor
        wrapperView?.layer.shadowOpacity = 0.10
        wrapperView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        wrapperView?.layer.shadowRadius = 10
    }
    
    private func setupRoundedView() {
        varietyBackgroundView?.layer.cornerRadius = 10
    }
    
    private func setupTopDescAttributedText(text: String) -> NSMutableAttributedString {
        let baseAttributes = setBaseAttributes()
        
        let inProgressAttributes = [
            NSAttributedString.Key.font: UIFont.montserratFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.mainColor150
        ]
        
        if let mode = mode {
            switch mode {
            case .inProgress:
                let baseText = NSMutableAttributedString(string: "Etapa: ", attributes: baseAttributes)
                let stageText = NSAttributedString(string: text, attributes: inProgressAttributes)
                baseText.append(stageText)
                
                return baseText
            case .finished:
                return NSMutableAttributedString(string: "Inicio: \(text)", attributes: baseAttributes)
            }
        }
        
        return NSMutableAttributedString()
    }
    
    private func setupBottomDescAttributedText(text: String) -> NSMutableAttributedString {
        let baseAttributes = setBaseAttributes()
        
        let inProgressAttributes = [
            NSAttributedString.Key.font: UIFont.montserratFont(ofSize: 14, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.ucGrey500
        ]
        
        if let mode = mode {
            switch mode {
            case .inProgress:
                let baseText = NSMutableAttributedString(string: "Inicio: ", attributes: baseAttributes)
                let startDate = NSAttributedString(string: text, attributes: inProgressAttributes)
                baseText.append(startDate)
                return baseText
            case .finished:
                return NSMutableAttributedString(string: "Fin: \(text)", attributes: baseAttributes)
            }
        }
        
        return NSMutableAttributedString()
    }
    
    private func setBaseAttributes() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont.montserratFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.ucGrey500
        ]
    }
}
