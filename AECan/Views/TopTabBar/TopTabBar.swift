//
//  TopTabBar.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol TopTabBarDelegate: class {
    func top(tabBar: TopTabBar, didSelectTabAt index: Int)
}

class TopTabBar: UIView {
    
    weak var delegate: TopTabBarDelegate?
    
    var tabsTitles: [String] = [] {
        didSet {
            setupTabs()
        }
    }
    
    @IBOutlet private var stackView: UIStackView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTabs()
    }
    
    func selectTab(at index: Int) {
        stackView?.arrangedSubviews.forEach({ (view) in
            (view as? TopTab)?.isSelected = false
        })
        (stackView?.arrangedSubviews[index] as? TopTab)?.isSelected = true
    }
    
    private func setupTabs() {
        tabsTitles.enumerated().forEach { (index, title) in
            let tab = TopTab.instantiateFromXib()
            tab.title = title
            tab.handleTap = { [weak self] in
                guard let self = self else { return }
                self.selectTab(at: index)
                self.delegate?.top(tabBar: self, didSelectTabAt: index)
            }
            stackView?.addArrangedSubview(tab)
        }
    }
}

