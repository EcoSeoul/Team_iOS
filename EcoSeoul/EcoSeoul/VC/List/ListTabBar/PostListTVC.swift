//
//  PostListTVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//


import UIKit
import XLPagerTabStrip

class PostListTVC: UITableViewController, APIService {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userDefault = UserDefaults.standard
    var postListDataArr : [PostListData]?
    
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
        
        getPostData(url: url("/mypage/myboard/\(userIdx)"))
    }
    
    func getPostData(url : String){
        
        PostListService.shareInstance.getPostData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.postListDataArr = data
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


extension PostListTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arr = postListDataArr else{return 3}
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostListTVCell", for: indexPath) as! PostListTVCell
        let row = indexPath.row
        cell.selectionStyle = .none
        if let postArr = postListDataArr {
            
            cell.postTitleLB.text = postArr[row].boardTitle
            cell.postContentLB.text = postArr[row].boardContent
            cell.postDateLB.text = postArr[row].boardDate
            
            if postArr[row].boardLike == nil {
                cell.postLikeLB.text = "0"
            }else {
                cell.postLikeLB.text = String(postArr[row].boardLike!)
            }
            
            if postArr[row].boardCmtNum == nil {
                cell.postCmtNumLB.text = "0"
            }else {
                cell.postCmtNumLB.text = String(postArr[row].boardCmtNum!)
            }
            
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



extension PostListTVC: IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "내가 쓴 글")
    }
}
