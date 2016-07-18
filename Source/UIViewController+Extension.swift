//
//  UIViewController+Extension.swift
//  KGNUserInterface
//
//  Created by David Keegan on 9/24/14.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNAutoLayout

extension UIViewController {

    /**
     Add a view controller as a child view controller.
     This helper method encapsulates all of the logic to
     properly add a view controller as a child view controller.

     - parameter viewController: The view controller to add as a child view controller.
     - parameter toView: Optional view to add the given view controller's view to as a subview.
     - parameter belowSubview: Optional view to insert the given view controller's view below.
     */
    public func addSubViewController(_ viewController: UIViewController, toView: UIView? = nil, belowSubview: UIView? = nil) {
        self.addChildViewController(viewController)
        var parentView = self.view
        if let view = toView {
            parentView = view
        }
        if let subview = belowSubview {
            parentView?.insertSubview(viewController.view, belowSubview: subview)
        } else {
            parentView?.addSubview(viewController.view)
        }
        viewController.didMove(toParentViewController: self)
        viewController.view.pinToEdgesOfSuperview()
    }

}

