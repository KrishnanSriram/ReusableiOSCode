//
//  ApplicationConfiguration.swift
//  CrossChx
//
//  Created by Sriram Rama, Krishnan on 4/1/15.
//  Copyright (c) 2015 MyChx. All rights reserved.
//

import UIKit

class ApplicationConfiguration: NSObject {
    class var sharedInstance : ApplicationConfiguration {
        struct Singleton {
            static let instance = ApplicationConfiguration()
        }
        
        return Singleton.instance
    }
}
