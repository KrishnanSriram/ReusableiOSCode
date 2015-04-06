//
//  SessionManager.swift
//  CrossChx
//
//  Created by Krishnan Sriram Rama on 4/3/15.
//  Copyright (c) 2015 MyChx. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
    private var patientInfo: CCHPatientInfo?
    
    class var sharedInstance : SessionManager {
        struct Singleton {
            static let instance = SessionManager()
        }
        
        return Singleton.instance
    }
    
    func patientInformation() -> CCHPatientInfo! {
        
        if self.patientInfo == nil {
            self.patientInfo = CCHPatientInfo()
        }
        
        return self.patientInfo!
    }
}
