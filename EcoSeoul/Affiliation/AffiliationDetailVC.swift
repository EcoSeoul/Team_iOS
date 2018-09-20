//
//  AffiliationDetailVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import GoogleMaps

class AffiliationDetailVC: UIViewController {
    
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    var districtTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("지역 태그 = \(districtTag!)")
        bottomViewConstraint.constant += 110
    
    }
    
    @IBAction func popBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func test(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.bottomViewConstraint.constant -= 110
            self.view.layoutIfNeeded()
        }, completion:nil)
    }
    


}

extension AffiliationDetailVC {
    
    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    ///////////////////////////
    
    
}
