//
//  BarcodeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class BarcodeVC: UIViewController {
    
    //최상위 부모뷰
    @IBOutlet var superView: UIControl!
    
    @IBOutlet weak var barcodeView: UIControl!
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var barcodeNumber: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBarcodeView()
        //make background blurred.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    func makeBarcodeView(){
        //make corner rounded.
        self.barcodeView.layer.cornerRadius = 20;
        self.barcodeView.layer.masksToBounds = true;
        
        //********이 부분을 수정예상********
        self.superView.addTarget(self, action: #selector(subViewTapped), for: .allTouchEvents)
        
        if let image = generateBarcodeFromString(string: "8 0101254 257810") {
            barcodeImage.image = image
            barcodeNumber.text = "8 0101254 257810"
            titleLabel.text = "최윤정님 에코머니"
            moneyLabel.text = "56000"
        }
    }
    
    @objc func subViewTapped(){
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    
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
    
    
    
    
}
extension BarcodeVC {
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
}
