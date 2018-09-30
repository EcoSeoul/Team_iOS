//
//  registerShopVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 30..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class registerShopVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.removeAnimate()
        }
    }
    
}

extension registerShopVC {
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
