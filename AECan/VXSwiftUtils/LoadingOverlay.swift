//
//  LoadingOverlay.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

public class LoadingOverlay {
    
    var overlayBackgroundColor: UIColor
    var activityIndicatorStyle: UIActivityIndicatorView.Style
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    init(overlayBackgroundColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8), activityIndicatorStyle: UIActivityIndicatorView.Style = .gray) {
        self.overlayBackgroundColor = overlayBackgroundColor
        self.activityIndicatorStyle = activityIndicatorStyle
    }
    
    public func show(over view: UIView!){
        hide()
        
        overlayView = UIView()
        overlayView.backgroundColor = overlayBackgroundColor
        
        activityIndicator = UIActivityIndicatorView(style: activityIndicatorStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(activityIndicator)
        overlayView.addConstraint(overlayView.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor))
        overlayView.addConstraint(overlayView.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor))
        activityIndicator.startAnimating()
        
        view.addEmbedded(view: overlayView)
    }
    
    public func hide(){
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
