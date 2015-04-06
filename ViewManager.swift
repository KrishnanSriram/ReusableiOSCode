//
//  ViewManager.swift
//  CrossChx
//
//  Created by Sriram Rama, Krishnan on 4/1/15.
//  Copyright (c) 2015 MyChx. All rights reserved.
//

import UIKit

enum ViewType
{
    case ViewTypeFormWelcome
    case ViewTypeFormReason
    case ViewTypeFormFirstName
    case ViewTypeFormLastName
    case ViewTypeFormPhoneNumber
    case ViewTypeFormEmailAddress
    case ViewTypeFormDOB
    case ViewTypeFormSSN
    case ViewTypeFormVerifyInformation
    case ViewTypeFormConfirmation
    
    init() {
        self = .ViewTypeFormWelcome
    }
}

class ViewManager: NSObject {
    
    class var sharedInstance : ViewManager {
        struct Singleton {
            static let instance = ViewManager()
        }
        
        return Singleton.instance
    }
    
    private func formNameForView(view: ViewType) -> String? {
        var formName : String?
        
        switch view {
        case .ViewTypeFormWelcome:
            formName = "welcomeScreenFormFields"
        case .ViewTypeFormReason:
            formName = "reasonsScreenFormFields"
        case .ViewTypeFormFirstName:
            formName = "firstNameScreenFormFields"
        case .ViewTypeFormLastName:
            formName = "lastNameScreenFormFields"
        case .ViewTypeFormPhoneNumber:
            formName = "phoneNumberScreenFormFields"
        case .ViewTypeFormEmailAddress:
            formName = "emailAddressScreenFormFields"
        case .ViewTypeFormDOB:
            formName = "dobScreenFormFields"
        case .ViewTypeFormSSN:
            formName = "ssnScreenFormFields"
        case .ViewTypeFormVerifyInformation:
            formName = "verificationScreenFormFields"
        case .ViewTypeFormConfirmation:
            formName = "confirmationScreenFormFields"
        default:
            formName = nil
        }

        return formName
            
    }
    
    private func formFieldsTextFor(view: ViewType) -> NSDictionary? {
        
        var formsDictionary : NSDictionary?
        var formFieldsDictionary : NSDictionary?
        
        if let pListPath = NSBundle.mainBundle().pathForResource("CCHViewData", ofType: "plist") {
            formsDictionary = NSDictionary(contentsOfFile: pListPath)
        }
        
        if let formsDictionary = formsDictionary {
            // read the contents here for given form, if the name of the form is a valid form
            if let formName = self.formNameForView(view) {
                formFieldsDictionary = formsDictionary.objectForKey(formName) as? NSDictionary
            }
            
        }
        
        return formFieldsDictionary
    }
    
    func textForFieldInForm(view: ViewType, field: String) -> String? {
        var textLabel : String?
        if let formFieldsDictionary: NSDictionary = self.formFieldsTextFor(view) {
            textLabel = formFieldsDictionary.objectForKey(field) as? String
        }

        return textLabel
    }
    
    func arrayValuesForFieldInForm(view: ViewType, field: String) -> [String]? {
        var arrayValues : [String]?
        if let formFieldsDictionary: NSDictionary = self.formFieldsTextFor(view) {
            arrayValues = formFieldsDictionary.objectForKey(field) as? [String]
        }
        
        return arrayValues
    }
    
    func displayFieldsForScreen(view:ViewType) -> NSDictionary? {
        var formFields : NSDictionary?
        
        switch(view) {
        case ViewType.ViewTypeFormVerifyInformation:
            formFields = self.displayFieldsForVerificationScreen()
        default:
            break
        }
        
        return formFields
    }
    
    private func displayFieldsForVerificationScreen() -> NSDictionary? {
        var formsDictionary : NSDictionary!
        var formsDisplayFields : NSDictionary?
        if let pListPath = NSBundle.mainBundle().pathForResource("CCHViewData", ofType: "plist") {
            formsDictionary = NSDictionary(contentsOfFile: pListPath)
        }
        var formInformation = formsDictionary.objectForKey("verificationScreenFormFields") as? NSDictionary
        if let allFormInformation = formInformation {
            formsDisplayFields = allFormInformation.objectForKey("verificationScreenFields") as? NSDictionary
        }
        return formsDisplayFields
    }
}
