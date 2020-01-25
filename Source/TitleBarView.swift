//
//  TitleBarView.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/30/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit

private class ContentView: UIView {
    override var intrinsicContentSize: CGSize {
        let minWidth = Style.Size.Control
        var intrinsicContentSize = super.intrinsicContentSize

        if let subview = self.subviews.first {
            let subviewIntrinsicContentSize = subview.intrinsicContentSize
            intrinsicContentSize.width = subviewIntrinsicContentSize.width
            if intrinsicContentSize.width < minWidth {
                intrinsicContentSize.width = minWidth
            }
        } else {
            intrinsicContentSize.width = 0
        }

        return intrinsicContentSize
    }
}

/// Custom title bar view, similar to UINavigationBar
/// but intended for custom interfaces.
open class TitleBarView: UIView {

    /// The title to display in the center of the bar
    open var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }

    /// The left view item
    open var leftView: UIView? {
        didSet {
            for subview in self.leftContainerView.subviews {
                subview.removeFromSuperview()
            }
            if let leftView = self.leftView {
                self.leftContainerView.addSubview(leftView)
                leftView.pinToEdgesOfSuperview()
            }
            self.leftContainerView.invalidateIntrinsicContentSize()
        }
    }

    /// The right view item
    open var rightView: UIView? {
        didSet {
            for subview in self.rightContainerView.subviews {
                subview.removeFromSuperview()
            }
            if let rightView = self.rightView {
                self.rightContainerView.addSubview(rightView)
                rightView.pinToEdgesOfSuperview()
            }
            self.rightContainerView.invalidateIntrinsicContentSize()
        }
    }

    private lazy var titleLabel: Label = {
        let label = Label(textStyle: .subheadline)
        label.accessibilityTraits = UIAccessibilityTraits.header
        return label
    }()

    private lazy var leftContainerView: ContentView = ContentView()
    private lazy var rightContainerView: ContentView = ContentView()

    /// Set the title, if `animated` is `true` then a cross dissolve animation is used.
    open func set(title: String?, animated: Bool) {
        defer {
            self.title = title
        }

        if !animated{
            return
        }

        guard let snapshot = self.titleLabel.snapshot() else {
            return
        }

        let titleLabelImageView = UIImageView(image: snapshot)
        self.addSubview(titleLabelImageView)
        titleLabelImageView.centerInSuperview()

        self.titleLabel.alpha = 0
        UIView.animate(withDuration: Style.Animation.Duration, animations: {
            self.titleLabel.alpha = 1
            titleLabelImageView.alpha = 0
        }) { _ in
            titleLabelImageView.removeFromSuperview()
        }
    }

    open override var intrinsicContentSize: CGSize {
        if self.traitCollection.userInterfaceIdiom == .phone {
            if self.traitCollection.verticalSizeClass == .compact {
                return CGSize(width: UIView.noIntrinsicMetric, height: Style.Size.NavigationBarHeightCompact)
            }
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: Style.Size.NavigationBarHeight)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.invalidateIntrinsicContentSize()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.addSubview(self.leftContainerView)
        self.leftContainerView.size(toMaxWidth: Style.Size.TitleBarItemMaxWidth)
        self.leftContainerView.pinToTopAndBottomEdgesOfSuperview()
        self.leftContainerView.pinToLeftEdgeOfSuperview(withOffset: Style.Size.SmallPadding)

        self.addSubview(self.rightContainerView)
        self.rightContainerView.size(toMaxWidth: Style.Size.TitleBarItemMaxWidth)
        self.rightContainerView.pinToTopAndBottomEdgesOfSuperview()
        self.rightContainerView.pinToRightEdgeOfSuperview(withOffset: Style.Size.SmallPadding)

        self.addSubview(self.titleLabel)
        self.titleLabel.centerInSuperview()
        self.constrain(
            item: self.titleLabel, attribute: .left,
            toItem: self.leftContainerView,
            attribute: .right, relatedBy: .greaterThanOrEqual,
            offset: Style.Size.Padding
        )
        self.constrain(
            item: self.titleLabel, attribute: .right,
            toItem: self.rightContainerView,
            attribute: .left, relatedBy: .lessThanOrEqual,
            offset: -Style.Size.Padding
        )
    }

}
