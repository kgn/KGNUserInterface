//
//  UIColor+Hex.swift
//  UIColor+Hex
//
//  Created by David Keegan on 9/24/14.
//  Copyright (c) 2014 David Keegan. All rights reserved.
//

import UIKit
import KGNAutoLayout

extension UIViewController {

    public func addSubViewController(viewController: UIViewController, toView: UIView? = nil, belowSubview: UIView? = nil) {
        self.addChildViewController(viewController)
        var parentView = self.view
        if let view = toView {
            parentView = view
        }
        if let subview = belowSubview {
            parentView.insertSubview(viewController.view, belowSubview: subview)
        } else {
            parentView.addSubview(viewController.view)
        }
        viewController.didMoveToParentViewController(self)
        viewController.view.pinToEdgesOfSuperview()
    }

}

