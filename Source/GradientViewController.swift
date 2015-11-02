//
//  GradientViewController.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/29/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit

/// A subclass of `UIViewController` but with `self.view`
/// set ot a `VerticalGradientView` view object
public class GradientViewController: UIViewController {

    /// The gradient to display
    public var gradient: Gradient! {
        didSet {
            if self.gradient != nil {
                let view = self.view as! VerticalGradientView
                view.gradient = self.gradient
            }
        }
    }

    override public func loadView() {
        self.view = VerticalGradientView()
    }

}
