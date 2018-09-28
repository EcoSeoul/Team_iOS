//
//  Extension.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //Optional타입 변환
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    //Alert창 띄우기
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    //예아니오 Alert창
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    //바코드 생성
    func generateBarcodeFromString(string: String)-> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform.init(scaleX: 10, y: 10)
        let output = filter?.outputImage?.transformed(by: transform)
        
        if(output != nil){
            return UIImage(ciImage: output!)
        }
        return nil
        
    }
    
    //네비게이션바 숨기기
    func setNaviBar(_ navi: UIViewController){
        let bar: UINavigationBar! =  navi.navigationController?.navigationBar
        let item: UINavigationItem = navi.navigationItem
        let backBtn = UIBarButtonItem()
        backBtn.image = UIImage()
        backBtn.tintColor = UIColor.white
        backBtn.width = -40
        item.leftBarButtonItem = backBtn
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
    }
    
    

 
    
    
}

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



