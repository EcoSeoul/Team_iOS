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
        
        if let requestArr = requestListDataArr {
            //cell.requestImage.image =
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
