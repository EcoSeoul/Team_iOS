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
        webVC.address = "https://m.news.naver.com/read.nhn?mode=LSD&mid=sec&sid1=102&oid=016&aid=0001445906"
        self.present(webVC, animated: true, completion: nil)
    }
    @IBAction func goReport2(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://m.tbs.seoul.kr/news/newsView.do?channelCode=CH_N&seq_800=10286332&idx_800=2306506&typ_800=R&grd_800=null"
        self.present(webVC, animated: true, completion: nil)
    }
    @IBAction func goReport3(_ sender: Any) {
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://www.shinailbo.co.kr/news/articleView.html?idxno=1097422"
        self.present(webVC, animated: true, completion: nil)
    }
    
}
