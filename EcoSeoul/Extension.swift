//
//  Extension.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

enum notoSansFont: String {
    case Bold = "NotoSansCJKkr-Bold"
    case Light = "NotoSansCJKkr-Light"
    case Medium = "NotoSansCJKkr-Medium"
    case Regular = "NotoSansCJKkr-Regular"
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension CGColor {
    
    static func color(hexString : String) -> CGColor{
        let r, g, b: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if let rgbValue = UInt(hexColor, radix: 16) {
                r =  CGFloat((rgbValue >> 16) & 0xff) / 255
                g =  CGFloat((rgbValue >>  8) & 0xff) / 255
                b =  CGFloat((rgbValue      ) & 0xff) / 255
                return UIColor(red: r, green: g, blue: b, alpha: 1.0).cgColor
            }
        }
        return UIColor.blue.cgColor
    }
    
}



