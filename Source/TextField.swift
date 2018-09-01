//
//  TextField.swift
//  KGNUserInterface
//
//  Created by David Keegan on 10/29/15.
//  Copyright © 2015 David Keegan. All rights reserved.
//

import UIKit
import KGNPreferredFontManager

private extension Selector {
    static let textDidChange = #selector(TextField.textDidChange)
}

/// Subclass of `PreferredFontTextField`. This implementation also allows
/// the text color to be set by `Label.appearance().textColor` and adds
/// a property for setting the color of the placeholder text.
open class TextField: PreferredFontTextField {
    
    /// The intrinsic content width, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentWidth: CGFloat?
    
    /// The intrinsic content height, if `nil` the super value is used,
    /// `UIViewNoIntrinsicMetric` can also be used used.
    open var intrinsicContentHeight: CGFloat?
    
    open override var intrinsicContentSize: CGSize {
        // HACK: the wh > 0 check shouldn't be necessary,
        // but the values are not nil for some reason...
        var intrinsicContentSize = super.intrinsicContentSize
        if let width = self.intrinsicContentWidth, width > 0 {
            intrinsicContentSize.width = width
        }
        if let height = self.intrinsicContentHeight, height > 0{
            intrinsicContentSize.height = height
        }
        return intrinsicContentSize
    }

    /// Suffix values to use for auto complete
    /// Useful for auto completing email addresses and other common text inputs
    open var autoCompleteValues: [String]?

    /// Determins if the auto complete match should ignore case
    /// Defaults to `true`
    open var autoCompleteIgnoreCase = true

    /// The current auto complete value
    open var autoCompleteValue: String? {
        get {
            return self.autoCompleteMatch
        }
    }

    open override var text: String? {
        get {
            return super.text
        }

        set {
            super.text = newValue
            self.updatePlaceholderAndAutoComplete()
        }
    }

    open override var font: UIFont? {
        get {
            return super.font
        }

        set {
            super.font = newValue
            self.updatePlaceholderAndAutoComplete()
        }
    }

    open override var textStyle: UIFontTextStyle {
        didSet {
            self.placeholderLabel.textStyle = self.textStyle
            self.autoCompleteLabel.textStyle = self.textStyle
        }
    }

    open override var preferredFontManager: PreferredFontManager? {
        didSet {
            self.placeholderLabel.preferredFontManager = self.preferredFontManager
            self.autoCompleteLabel.preferredFontManager = self.preferredFontManager
        }
    }

    private var privatePlaceholder: String? {
        didSet {
            self.placeholderLabel.text = self.privatePlaceholder
        }
    }

    open override var placeholder: String? {
        get {
            return self.privatePlaceholder
        }

        set(newValue) {
            self.privatePlaceholder = newValue
        }
    }

    /// The color of the placeholder text.
    public var placeholderColor: UIColor? {
        didSet {
            self.placeholderLabel.textColor = self.placeholderColor
        }
    }

    /// The color of the auto complete text.
    public var autoCompleteColor: UIColor? {
        didSet {
            self.autoCompleteLabel.textColor = self.autoCompleteColor
        }
    }

    private lazy var placeholderLabel: Label = {
        let label = Label(textStyle: self.textStyle)
        label.textColor = self.placeholderColor
        label.text = self.placeholder
        return label
    }()

    private var autoCompleteLabelConstraint: NSLayoutConstraint!
    private lazy var autoCompleteLabel: Label = {
        let label = Label(textStyle: self.textStyle)
        label.textColor = self.placeholderColor
        label.text = self.placeholder
        return label
    }()

    open override func setup() {
        super.setup()

        self.textColor = TextField.appearance().textColor

        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.centerVerticallyInSuperview()
        self.placeholderLabel.pinToLeftEdgeOfSuperview()

        self.addSubview(self.autoCompleteLabel)
        self.autoCompleteLabel.centerVerticallyInSuperview()
        self.autoCompleteLabelConstraint = self.autoCompleteLabel.pinToLeftEdgeOfSuperview()

        NotificationCenter.default.addObserver(
            self, selector: .textDidChange,
            name: .UITextFieldTextDidChange,
            object: self
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc fileprivate func textDidChange() {
        self.updatePlaceholderAndAutoComplete()
    }

    private func updatePlaceholderAndAutoComplete() {
        self.placeholderLabel.isHidden = self.text?.isEmpty == false

        if let autoCompleteValue = self.autoCompleteValue {
            if let text = self.text, let font = self.font {
                let textLength = (text as NSString).boundingRect(
                    with: self.bounds.size, options: [],
                    attributes: [.font: font], context: nil
                )
                self.autoCompleteLabelConstraint.constant = textLength.width
                self.autoCompleteLabel.text = String(autoCompleteValue.suffix(autoCompleteValue.count-text.count))
            } else {
                self.autoCompleteLabelConstraint.constant = 0
                self.autoCompleteLabel.text = autoCompleteValue
            }
            self.autoCompleteLabel.isHidden = false
        } else {
            self.autoCompleteLabel.isHidden = true
        }
    }

    internal var autoCompleteMatch: String? {
        guard let autoCompleteValues = self.autoCompleteValues, autoCompleteValues.count > 0 else {
            return nil
        }
        guard let text = self.text, !text.isEmpty else {
            return nil
        }

        var compareText = text
        if self.autoCompleteIgnoreCase {
            compareText = compareText.lowercased()
        }

        // Loop through all the auto complete values to find a match
        for suffix in autoCompleteValues {
            var compareSuffix = suffix
            if self.autoCompleteIgnoreCase {
                compareSuffix = suffix.lowercased()
            }

            guard let firstSuffixCharacter = compareSuffix.first else {
                continue
            }

            // Find the location of the first character from the suffix in the text,
            // if it exists...
            var textLocation: Int?
            for (t, textCharacter) in compareText.enumerated() {
                if firstSuffixCharacter == textCharacter {
                    textLocation = t
                    break
                }
            }

            guard let location = textLocation else {
                continue
            }

            // Find all the following matching characters
            var length = 1
            if length+location < compareText.count {
                while self.character(in: compareSuffix, at: length) == self.character(in: compareText, at: length+location) {
                    length += 1

                    if length >= compareSuffix.count {
                        break
                    }

                    if length+location >= compareText.count {
                        break
                    }
                }
            }
            
            if compareText.count > location+length {
                continue
            }
            
            // Return the full text with the complete suffix,
            // this cuases the function to early exit when the
            // first match is found
            return text+String(suffix.suffix(suffix.count-length))
            
        }

        return nil
    }
    
    private func character(in string: String, at index: Int) -> Character {
        return string[string.index(string.startIndex, offsetBy: index)]
    }

}
