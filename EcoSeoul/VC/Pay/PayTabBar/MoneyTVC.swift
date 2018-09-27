//
//  MoneyTVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MoneyTVC: UITableViewController {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    var moneyListDataArr: [MoneyListData]?
    
    //적립 머니, 사용 머니 레이블
    @IBOutlet weak var depositMoney: UILabel!
    @IBOutlet weak var withdrawMoney: UILabel!
    var deposit = 0
    var withdraw = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰에 내용이 나오지 않는 하단 부분의 선을 없애줍니다.
        tableView.tableFooterView = UIView(frame: .zero)
        
//        //통신
//        self.getPayList(url: url("/mypage/usage/\(userIdx)/0"))
    }
    
    
//    func getPayList(url : String){
//
//        PayListService.shareInstance.getPayData(url: url, completion: { [weak self] (result) in
//            guard let `self` = self else { return }
//            switch result {
//            case .networkSuccess(let data):
//                self.moneyListDataArr = data.
//                self.tableView.reloadData()
//                break
//
//            case .networkFail :
//                self.simpleAlert(title: "network", message: "check")
//            default :
//                break
//            }
//
//        })
//
//    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = moneyListDataArr else {return 3}
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyTVCell", for: indexPath) as! MoneyTVCell
        
//        if let moneyArr = moneyListDataArr {
//            
//            cell.usageTitleLB.text = moneyArr[row]
//            
//            
//            
//            
//        }
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
}
extension MoneyTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "에코 머니")
    }
}

