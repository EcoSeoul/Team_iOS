//
//  CommunityVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableview: UITableView!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.tableFooterView = UIView(frame: .zero)
        
        
        setNaviBar()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CommunityTVCell") as!  CommunityTVCell
        if indexPath.row <= 2{
            cell.bestIMG.image = #imageLiteral(resourceName: "community-gold")
            cell.titleLB.text = "우아아앗"
            cell.contentLB.text = "저의 에코마일리지를 보십시오"
            cell.goodLB.text = "67"
        }else {
            cell.bestIMG.image = nil
            cell.titleLB.text = "우아아앗"
            cell.contentLB.text = "저의 에코마일리지를 보십시오"
            cell.goodLB.text = "1"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commnunityVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityViewVC")as! CommunityViewVC
        self.navigationController?.pushViewController(commnunityVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
