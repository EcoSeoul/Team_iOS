//
//  CommunityViewVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate, APIService{
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var commentSendView: UIView!
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var boardTitleLB: UILabel!
    @IBOutlet weak var boardContentLB: UILabel!
    @IBOutlet weak var goodLB: UILabel!
    @IBOutlet weak var commentLB: UILabel!
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var userNameLB: UILabel!
    
    
    var communityView : CommunityView?
    var selectedBoardIdx : List?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.tableview.tableFooterView = UIView(frame: .zero)
        setNaviBar()
        commnentBarShadow()

        if let sboardIdx = selectedBoardIdx{
            print("selectedBoardIDX")
            print(sboardIdx.boardIdx)
            CommunityViewInit(url: url("/board/\(sboardIdx.boardIdx)/\(sboardIdx.userIdx)"))
        }
    }
    
    func CommunityViewInit(url : String){
        
        CommunityViewService.shareInstance.getCommunityDetailData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                
            case .networkSuccess(let detailView):
                self.communityView = detailView
                print("\n communityView에 잘 들어가는지 확인하기\n")
                print(self.communityView as Any)
                self.showBoardData()
                self.tableview.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }

    func showBoardData(){
        if let sboardIdx = self.selectedBoardIdx{
            self.userNameLB.text = sboardIdx.userName
        }
        if let boardresult = self.communityView?.boardResult {
            self.boardTitleLB.text = boardresult[0].boardTitle
            self.boardContentLB.text = boardresult[0].boardContent
            self.goodLB.text = (String)(boardresult[0].boardLike)
            self.commentLB.text = (String)(boardresult[0].boardCmtnum)
            self.dateLB.text = boardresult[0].boardDate
        }
    }
    
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var commentBar: UIView!

    func commnentBarShadow(){
        self.commentBar.layer.shadowColor = UIColor.black.cgColor
        commentBar.layer.shadowOpacity = 0.3
        commentBar.layer.shadowOffset = CGSize.zero
        commentBar.layer.shadowRadius = 5
        self.view.addSubview(commentBar)
    }

    
    func setNaviBar(){
        backBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        
        bar.backgroundColor = .white
        item.title = ""
        bar.shadowImage = UIImage()
        
        //print("네비바의 높이:" + bar.)
        
    }
    
    //상태 표시줄 흰색 만들기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        if let comDat = communityView {
            rowNumber = comDat.commentResult.count
        }
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CommunityViewTVCell") as! CommunityViewTVCell
        
        if let comment = communityView?.commentResult {
            cell.commentConfig(comment: comment[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


extension CommunityViewVC{
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 위로 이동시킴 ////////
            commentSendView.frame.origin.y -= keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 아래로 이동시킴 ////////
            commentSendView.frame.origin.y += keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}
