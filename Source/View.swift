//
//  View.swift
//  KGNUserInterface
//
//  Created by David Keegan on 11/19/16.
//  Copyright © 2016 David Keegan. All rights reserved.
//

import UIKit

open class View: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // Override to customize view setup
    open func setup() {
        
    }

}
