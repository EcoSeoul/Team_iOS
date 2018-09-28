//
//  DonationListTVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DonationListTVC: UITableViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userDefault = UserDefaults.standard
    var donationListDataArr : [DonationListData]?
    
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
        getDonationData(url: url("/mypage/mydonation/\(userIdx)"))
    }
    
    func getDonationData(url : String){
        
        DonationListService.shareInstance.getDonationData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.donationListDataArr = data
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

extension DonationListTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = donationListDataArr else{return 3}
        return arr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationListTVCell", for: indexPath) as! DonationListTVCell
        let row = indexPath.row
        
        if let donationArr = donationListDataArr {
            cell.orgNameLB.text = donationArr[row].orgName
            cell.mileageDateLB.text = donationArr[row].mileageDate
            cell.mileageWithDrawLB.text = String(-donationArr[row].mileageWithdraw)
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



extension DonationListTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "기부 내역")
    }
}
