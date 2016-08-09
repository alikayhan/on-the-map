//
//  UIColorExtension.swift
//  On The Map
//
//  Created by Ali Kayhan on 01/08/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColorExtension
// This extension allows to have UIColor objects by providing hex color codes as strings.

extension UIColor {
    convenience init(hexString: String, alpha: Double = 1.0) {
        
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        
        NSScanner(string: hex).scanHexInt(&int)
        
        let r, g, b: UInt32
        
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
    }
    
}
