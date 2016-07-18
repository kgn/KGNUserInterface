//
//  UIView+Snapshot.swift
//  KGNUserInterface
//
//  Created by David Keegan on 11/7/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit

extension UIView {

    /**
     Snapshot a view into an image object.
     
     - parameter opaque: A Boolean flag indicating whether the bitmap is opaque.
     If you know the bitmap is fully opaque, specify true to ignore the alpha 
     channel and optimize the bitmap’s storage. Specifying false means that the 
     bitmap must include an alpha channel to handle any partially transparent pixels.
     Defautls to `false`.
     - parameter scale: The scale factor to apply to the bitmap. If you specify a value
     of 0.0, the scale factor is set to the scale factor of the device’s main screen.
     Defaults to `0`.
     - parameter afterUpdates: A Boolean value that indicates whether the snapshot should 
     be rendered after recent changes have been incorporated. Specify the value false if 
     you want to render a snapshot in the view hierarchy’s current state, which might not 
     include recent changes. Defaults to `false`.

     - returns: The image object for the snapshot.
     */
    public func snapshot(opaque: Bool = false, scale: CGFloat = 0, afterScreenUpdates: Bool = false) -> UIImage? {
        if self.bounds == CGRect.zero {
            return nil
        }

        defer {
            UIGraphicsEndImageContext()
        }

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, scale)
        if !self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterScreenUpdates) {
            return nil
        }
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return image
    }

}
