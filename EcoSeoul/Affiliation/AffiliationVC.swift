//
//  AffiliationVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
//제휴업체 표시
//서울시 전역 지도

class AffiliationVC: UIViewController {

    @IBOutlet weak var seoulMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

  
    @IBAction func pressed0(_ sender: Any) {
        seoulMap.image = #imageLiteral(resourceName: "a-gangseo")
    }
    

}
