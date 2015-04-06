//
//  FontManager.swift
//  CrossChx
//
//  Created by Sriram Rama, Krishnan on 4/1/15.
//  Copyright (c) 2015 MyChx. All rights reserved.
//

import UIKit

class FontManager: NSObject {
    class var sharedInstance : FontManager {
        struct Singleton {
            static let instance = FontManager()
        }
        
        return Singleton.instance
    }
    
    private func fontsForView() -> NSDictionary? {
        
        var fontsDictionary : NSDictionary?
        
        if let pListPath = NSBundle.mainBundle().pathForResource("CCHViewFonts", ofType: "plist") {
            fontsDictionary = NSDictionary(contentsOfFile: pListPath)
        }
        
        return fontsDictionary
    }
    
    func fontForField(fieldType:String)-> UIFont? {
        var fieldFont : UIFont?
        
        if let fontsDictionary = self.fontsForView() {
            if let fontDictionaryForField: NSDictionary = fontsDictionary.objectForKey(fieldType) as? NSDictionary {
                fieldFont = self.fontFromFontDictionary(fontDictionaryForField)
            }
        }
        
        return fieldFont
    }
    
    private func fontFromFontDictionary(fontDictionary: NSDictionary!) -> UIFont! {
        let fontName = fontDictionary.objectForKey("fontName") as! String
        let fontSize = fontDictionary.objectForKey("fontSize") as! NSNumber

        return UIFont(name: fontName, size: CGFloat(fontSize.floatValue))
    }
}
