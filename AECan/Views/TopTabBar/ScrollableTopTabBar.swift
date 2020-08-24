//
//  TopTabBar.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol ScrollableTopTabBarDelegate: class {
    func top(tabBar: ScrollableTopTabBar, didSelectTabAt index: Int)
}

class ScrollableTopTabBar: UIView {
    
    struct ScrollableTopTab {
        let title: String?
        let badgeText: String?
        
        init(title: String?, badgeText: String?) {
            self.title = title
            self.badgeText = badgeText
        }
    }
    
    weak var delegate: ScrollableTopTabBarDelegate?
    
    var tabsTitles: [ScrollableTopTab] = [] {
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
        tabsTitles.enumerated().forEach { (index, obj) in
            let tab = TopTab.instantiateFromXib()
            tab.title = obj.title
            tab.badgeText = obj.badgeText
            tab.handleTap = { [weak self] in
                guard let self = self else { return }
                self.selectTab(at: index)
                self.delegate?.top(tabBar: self, didSelectTabAt: index)
            }
            tab.translatesAutoresizingMaskIntoConstraints = false
            stackView?.addArrangedSubview(tab)
        }
    }
}

