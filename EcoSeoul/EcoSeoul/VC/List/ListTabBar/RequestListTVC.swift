//
//  RequestListTVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RequestListTVC: UITableViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userDefault = UserDefaults.standard
    var requestListDataArr : [RequestListData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        network()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network()
    }
    
    func network(){
         getRequestData(url: url("/mypage/mygoods/\(userIdx)"))
    }
    
    func getRequestData(url : String){
        
        RequestListService.shareInstance.getRequestData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.requestListDataArr = data
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
}



extension RequestListTVC{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = requestListDataArr else{return 3}
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestListTVCell", for: indexPath) as! RequestListTVCell
        let row = indexPath.row
        cell.selectionStyle = .none
        if let requestArr = requestListDataArr {
            //cell.requestImage.image =
            switch requestArr[row].goodsName {
            case "실내보온텐트(Sleep8 Single)":
                //cell.requestImage.image = = #imageLiteral(resourceName: "shop-tent")
                cell.requestImage.image = #imageLiteral(resourceName: "shop-tent")
            case "최고급 텀블러 (3개:3만마일리지)":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-tumbler")
            case "LED 스탠드(WJK-151)":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-stand")
            case "전통시장 온누리상품권":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-market-voucher")
            case "모바일문화상품권":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-culture-voucher")
            case "인공지능 자동절전 콘센트(SWE-203K)":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-socket")
            case "아파트관리비":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-apti")
            case "티머니(교통카드) 충전권":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-tmoney")
            case "현금전환":
                cell.requestImage.image = #imageLiteral(resourceName: "shop-cash")
            default:
                break
            }
            cell.requestTitle.text = requestArr[row].goodsName
            cell.requestDate.text = requestArr[row].mileageDate
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



extension RequestListTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "신청 내역")
    }
}
