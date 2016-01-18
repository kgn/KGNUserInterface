//
//  ViewController.swift
//  KGNUserInterfaceExample
//
//  Created by David Keegan on 1/17/16.
//  Copyright © 2016 David Keegan. All rights reserved.
//

import UIKit
import KGNUserInterface

class TextFieldViewController: UIViewController, UITextFieldDelegate {

    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.delegate = self
        textField.placeholder = "Email"
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .None
        textField.keyboardType = .EmailAddress
        textField.textColor = UIColor.blackColor()
        textField.placeholderColor = UIColor.grayColor()
        textField.autoCompleteColor = UIColor.blueColor()
        textField.autoCompleteValues = [
            "@aol.com",
            "@me.com",
            "@mac.com",
            "@gmail.com",
            "@yahoo.com"
        ]
        return textField
    }()

    lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.delegate = self
        textField.placeholder = "Name"
        textField.textColor = UIColor.blackColor()
        textField.placeholderColor = UIColor.grayColor()
        textField.autoCompleteColor = UIColor.blueColor()
        textField.autoCompleteValues = [
            "Frank Sinatra",
            "Dean Martin",
            "Sammy Davis",
            "Peter Lawford",
            "Joey Bishop",

            "Franklyn Smith"
        ]
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        self.view.addSubview(self.nameTextField)
        self.nameTextField.positionBelowItem(self.topLayoutGuide, offset: Style.Size.LargePadding)
        self.nameTextField.pinToSideEdgesOfSuperview(offset: Style.Size.Padding)

        self.view.addSubview(self.emailTextField)
        self.emailTextField.positionBelowItem(self.nameTextField, offset: Style.Size.LargePadding)
        self.emailTextField.pinToSideEdgesOfSuperview(offset: Style.Size.Padding)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.nameTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let autoCompleteValue = (textField as! TextField).autoCompleteValue {
            textField.text = autoCompleteValue
        }
        if textField == self.nameTextField {
            self.emailTextField.becomeFirstResponder()
        }
        return true
    }

}

