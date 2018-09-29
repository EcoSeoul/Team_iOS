//
//  Content3VC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 30..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class Content3VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goReport1(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://topshop.bccard.com/app/topmall/m/main/main"
        self.present(webVC, animated: true, completion: nil)
    }
    @IBAction func goReport2(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://topshop.bccard.com/app/topmall/m/main/main"
        self.present(webVC, animated: true, completion: nil)
    }
    @IBAction func goReport3(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://topshop.bccard.com/app/topmall/m/main/main"
        self.present(webVC, animated: true, completion: nil)
    }
    
}
