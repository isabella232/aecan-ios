//
//  ViewOwnerOfXib.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 23/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

// The classes that inherit from ViewOwnerOfXib can be used directly in a Storyboard
// How to use it:
// - Create a swift class that inherits from ViewOwnerOfXib
// - Create a .xib and set the new class as the File's Owner
// - Put any IBOutlets, IBActions and IBInspectables in the swift class and link them in the .xib
// - The .swift and the .xib files MUST have the same name
// - In a storyboard, drag a UIView, and set it's class name with the name of the created class.
// - The view will be automatically loaded :)
//
// The commonInit can be overriden to add custom initialization logic, but don't forget to call super.commonInit()

class ViewOwnerOfXib: UIView {
    
    var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    private func loadViewFromNib() -> UIView? {
       let bundle = Bundle(for: type(of: self))
       let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
       return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
