
//
//  BarcodeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class BarcodeVC: UIViewController {
    
    let userName = UserDefaults.standard.string(forKey: "userName")
    let userMileage = UserDefaults.standard.integer(forKey: "userMileage")
    
    //최상위 부모뷰
    @IBOutlet var superView: UIControl!
    
    @IBOutlet weak var barcodeView: UIControl!
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var barcodeNumber: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var barcodeSerial: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        moneyLabel.sizeToFit()
        barcodeNumber.sizeToFit()
        self.showAnimate()
        makeBarcodeView()
        
    }
    
    func makeBarcodeView(){
        
        //make corner rounded.
        self.barcodeView.layer.cornerRadius = 20;
        self.barcodeView.layer.masksToBounds = true;
        
        //********이 부분을 수정예상********(모든곳이 터치가 안되는 근원)
        self.superView.addTarget(self, action: #selector(subViewTapped), for: .allTouchEvents)
        self.saveBarcodeData()
        
    }
    

    func saveBarcodeData(){
        
        guard let serial = barcodeSerial else {return}
        
        if let image = generateBarcodeFromString(string: serial) {
            barcodeImage.image = image
            barcodeNumber.text = serial
            titleLabel.text = gsno(userName) + "님 에코머니"
            let intMileage = gino(userMileage)
            moneyLabel.text = "\(intMileage)"
        }
        
    }
    
}

extension BarcodeVC {
    
    @objc func subViewTapped(){
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    
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
