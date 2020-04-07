//
//  UIColor.swift
//  WoCoDemo
//
//  Created by Mujahid on 27/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    convenience init(hexString: String, alpha: Double = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    
    
    static let accentColor = UIColor(hexString: "#17C2D9")
    static let gray = UIColor(hexString: "#57000000")
    static let balckTransparent = UIColor(hexString: "#B8000000")
    static let lightGray = UIColor(hexString: "#1e000000")
    static let  silver = UIColor(hexString:  "#C0C0C0")
    static let  divider_color = UIColor(hexString: "#e0e0e0")
    static let  themeColor = UIColor(hexString: "#FFD800")
    static let  orangeColor = UIColor(hexString: "#ff9100")
    static let  whiteColor = UIColor(hexString: "#ffffff")
    static let  brown = UIColor(hexString: "#cb703d")
    static let skyColor = UIColor(hexString: "#1086c1")
    
    static let lightBlack = UIColor(hexString: "#bd000000")
    static let  backgroundColor = UIColor.white
    static let  textColor = UIColor.lightBlack
    static let  textSubColor = UIColor.darkGray

    static let  textSecondColoe = UIColor.gray
    static let  buttonColor = UIColor.black
    static let  errorColor = UIColor.red
    static let  borderColor = UIColor.divider_color
    
    static let radish = UIColor(hexString: "#DF3967")
    static let maroon = UIColor(hexString: "#df3967")
    static let red = UIColor(hexString: "#ff0000")
    static let green = UIColor(hexString: "#00ff00")
    static let darkGreen = UIColor(hexString: "#2f9106")
    static let black = UIColor(hexString: "#000000")
    static let primaryColor = UIColor(hexString: "#f9c747")
   
   
    static let  oragneBtn = UIColor.orange
    static let  transparentPartial = UIColor(hexString: "#050000")
    static let  transparent = UIColor(hexString: "#000000")
    

    
    
    
}

