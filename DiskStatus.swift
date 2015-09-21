//
//  DiskUtility.swift
//  ShoppingCart
//
//  Created by Krishnan Sriram Rama on 9/21/15.
//  Copyright © 2015 Krishnan Sriram Rama. All rights reserved.
//

import UIKit

class DiskStatus {
    
    //MARK: Formatter MB only
    class func MBFormatter(bytes: Int64) -> String {
        let formatter = NSByteCountFormatter()
        formatter.allowedUnits = NSByteCountFormatterUnits.UseMB
        formatter.countStyle = NSByteCountFormatterCountStyle.Decimal
        formatter.includesUnit = false
        return formatter.stringFromByteCount(bytes) 
    }
    
    
    //MARK: Get String Value
    class var totalDiskSpace:String {
        get {
            return NSByteCountFormatter.stringFromByteCount(totalDiskSpaceInBytes, countStyle: NSByteCountFormatterCountStyle.Binary)
        }
    }
    
    class var freeDiskSpace:String {
        get {
            return NSByteCountFormatter.stringFromByteCount(freeDiskSpaceInBytes, countStyle: NSByteCountFormatterCountStyle.Binary)
        }
    }
    
    class var usedDiskSpace:String {
        get {
            return NSByteCountFormatter.stringFromByteCount(usedDiskSpaceInBytes, countStyle: NSByteCountFormatterCountStyle.Binary)
        }
    }
    
    
    //MARK: Get raw value
    class var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory() as String)
                let space = (systemAttributes[NSFileSystemSize] as? NSNumber)?.longLongValue
                return space!
            } catch let error as NSError {
                print("Error - \(error)")
                return 0
            }
        }
    }
    
    class var freeDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory() as String)
                let space = (systemAttributes[NSFileSystemFreeSize] as? NSNumber)?.longLongValue
                return space!
            } catch let error as NSError {
                print("Error - \(error)")
                return 0
            }
        }
    }
    
    class var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
    
}