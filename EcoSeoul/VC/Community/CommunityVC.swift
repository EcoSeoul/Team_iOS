//
//  CommunityVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController, UITableViewDelegate, UITableViewDataSource, APIService {
    

    @IBOutlet weak var tableview: UITableView!
    
    var communityData : [CommunityData]?
    var lists : [List]?
    
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    var writeBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "ic-write")
        btn.tintColor = .black
        btn.action = #selector(WriteVC)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.tableFooterView = UIView(frame: .zero)
        
        setNaviBar()
        self.CommunityInit(url: url("/board/list"))
    }
    
    func CommunityInit(url : String){
        
        CommunityService.shareInstance.getCommunityData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                
            case .networkSuccess(let community):
                self.communityData = community
                print("\n applys에 잘 들어가는지 확인하기\n")
                print(self.communityData as Any)
                self.tableview.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        if let comDat = communityData {
            if let best = comDat[0].bestList, let all = comDat[1].allList{
                rowNumber = best.count + all.count
            }
        }
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "CommunityTVCell") as!  CommunityTVCell
        
        switch indexPath.row {
        case 0:
            cell.bestIMG.image = #imageLiteral(resourceName: "community-gold")
        case 1:
            cell.bestIMG.image = #imageLiteral(resourceName: "community-silver")
        case 2:
            cell.bestIMG.image = #imageLiteral(resourceName: "community-bronze")
        default:
            cell.bestIMG.image = nil
        }
        
        if let communityData_ = communityData {
            //0번째 인덱스에 bestList들만 들어 있음, allList: nil
            if let bestlist = communityData_[0].bestList{
                if indexPath.row < 3{
                    cell.configure(list: bestlist[indexPath.row])
                }
            }
            
            //반대로 1번째 인덱스엔 allList들만 들어있음, bestList: nil
            if let alllist = communityData_[1].allList{
                if indexPath.row > 2{
                    cell.configure(list: alllist[indexPath.row-3])
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let communityVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityViewVC")as! CommunityViewVC
        //이 경우도 bestList(0~2), allList(3~) 중 어떤걸 누르는지 파악.
        if let data = communityData {
            if let list = data[0].bestList{
                if indexPath.row < 3 {
                        let board: List = list[indexPath.row]
                        communityVC.selectedBoardIdx = board
                    
                }
            }
            if let list = data[1].allList{
                if indexPath.row >= 3{
                        let board: List  = list[indexPath.row-3]
                        communityVC.selectedBoardIdx = board
                }
            }
        }
        self.navigationController?.pushViewController(communityVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

//////////Navi
extension CommunityVC{
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func WriteVC(){
        let writeVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityWriteVC") as! CommunityWriteVC
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
    
    
    func setNaviBar(){
        backBtn.target = self
        writeBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        item.rightBarButtonItem = writeBtn
        item.rightBarButtonItem?.imageInsets.right = -15
        item.title = "커뮤니티"
        
        bar.backgroundColor = .white
        bar.shadowImage = UIImage()
    }
    
    //상태 표시줄 흰색 만들기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
