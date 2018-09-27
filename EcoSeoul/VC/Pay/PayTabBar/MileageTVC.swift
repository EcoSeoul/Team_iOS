//
//  MileageTVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MileageTVC: UITableViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userDefault = UserDefaults.standard
    var mileageListDataArr : [MileageListData]?
    
    //적립 마일리지, 사용 마일리지 레이블, 현재 마일리지 레이블
    @IBOutlet weak var depositMileage: UILabel!
    @IBOutlet weak var withdrawMileage: UILabel!
    @IBOutlet weak var currentMileage: UILabel!
    
    var deposit = 0
    var withdraw = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
        currentMileage.text = String(userDefault.integer(forKey: "userMileage"))
        getMileageData(url: url("/mypage/usage/\(userIdx)/0"))
    }
    
    func getMileageData(url : String){
        
        MileageListService.shareInstance.getMileageData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.mileageListDataArr = data.mileageTotalUsage
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = mileageListDataArr else{return 3}
    
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MileageTVCell", for: indexPath) as! MileageTVCell
        let row = indexPath.row
        
        if let mileageArr = mileageListDataArr {
            
            cell.usageTitleLB.text = mileageArr[row].mileageUsage
            cell.usageDateLB.text = mileageArr[row].mileageDate
            
            if mileageArr[row].mileageDeposit != nil {
                deposit += mileageArr[row].mileageDeposit!
                cell.plusminusLB.text = String("+\(mileageArr[row].mileageDeposit!)")
            }
            else {
                withdraw += mileageArr[row].mileageWithdraw!
                cell.plusminusLB.text = String("-\(mileageArr[row].mileageWithdraw!)")
                cell.plusminusLB.textColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
                cell.mileageIcon.image = #imageLiteral(resourceName: "my-mileage-use")
                
            }
            depositMileage.text = "\(deposit)"
            withdrawMileage.text = "\(withdraw)"
       
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

extension MileageTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "에코 마일리지")
    }
}
