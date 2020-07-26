//
//  UIViewController+Indicator.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 26/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import UIKit

fileprivate var backgroundView: UIView?
extension UIViewController {
    
    func startActivityIndicator() {
        backgroundView = UIView(frame: self.view.bounds)
        backgroundView?.backgroundColor = .white
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = backgroundView!.center
        activityIndicator.startAnimating()
        backgroundView?.addSubview(activityIndicator)
        self.view.addSubview(backgroundView!)
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            self.stopeActivityIndicator()
        }
    }
    
    func stopeActivityIndicator() {
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
}
