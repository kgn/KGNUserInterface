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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.textColor = UIColor.black()
        textField.placeholderColor = UIColor.gray()
        textField.autoCompleteColor = UIColor.blue()
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
        textField.textColor = UIColor.black()
        textField.placeholderColor = UIColor.gray()
        textField.autoCompleteColor = UIColor.blue()
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

        self.view.backgroundColor = UIColor.white()

        self.view.addSubview(self.nameTextField)
        self.nameTextField.positionBelow(item: self.topLayoutGuide, offset: Style.Size.LargePadding)
        self.nameTextField.pinToSideEdgesOfSuperview(offset: Style.Size.Padding)

        self.view.addSubview(self.emailTextField)
        self.emailTextField.positionBelow(item: self.nameTextField, offset: Style.Size.LargePadding)
        self.emailTextField.pinToSideEdgesOfSuperview(offset: Style.Size.Padding)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.nameTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let autoCompleteValue = (textField as! TextField).autoCompleteValue {
            textField.text = autoCompleteValue
        }
        if textField == self.nameTextField {
            self.emailTextField.becomeFirstResponder()
        }
        return true
    }

}

