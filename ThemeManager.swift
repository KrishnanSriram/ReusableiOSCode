//
//  ThemeManager.swift
//  CrossChx
//
//  Created by Sriram Rama, Krishnan on 4/1/15.
//  Copyright (c) 2015 MyChx. All rights reserved.
//

import UIKit

class ThemeManager: NSObject {
    class var sharedInstance : ThemeManager {
        struct Singleton {
            static let instance = ThemeManager()
        }
        
        return Singleton.instance
    }
    
    private func colorsFromPLIST() -> NSDictionary? {
        
        var colorsDictionary : NSDictionary?
        
        if let pListPath = NSBundle.mainBundle().pathForResource("CCHViewTheme", ofType: "plist") {
            colorsDictionary = NSDictionary(contentsOfFile: pListPath)
        }
        
        return colorsDictionary
    }
    
    func colorForField(fieldType: String) -> UIColor? {
        var fieldColor : UIColor?
        
        if let colorsDictionary = self.colorsFromPLIST() {
            if let colorDictionaryForField: NSDictionary = colorsDictionary.objectForKey(fieldType) as? NSDictionary {
                fieldColor = self.colorFromDictionary(colorDictionaryForField)
            }
        }
        
        return fieldColor
    }
    
    private func colorFromDictionary(colorsDictionary:NSDictionary!) -> UIColor! {
        let redColor = colorsDictionary.objectForKey("Red") as! NSNumber
        let greenColor = colorsDictionary.objectForKey("Green") as! NSNumber
        let blueColor = colorsDictionary.objectForKey("Blue") as! NSNumber
        
        NSLog("RGB: %f, %f, %f", CGFloat(redColor.floatValue), CGFloat(greenColor.floatValue), CGFloat(blueColor.floatValue))
        
        return UIColor(red: CGFloat(redColor.floatValue)/255, green: CGFloat(greenColor.floatValue)/255, blue: CGFloat(blueColor.floatValue)/255, alpha: 1)
    }
    
    /*
     * Helps converting Color to image
    */
    func imageFromColor(color:UIColor) -> UIImage! {
        var rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
