//
//  CommunityWriteVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityWriteVC: UIViewController, APIService {

    @IBOutlet weak var titleLB: UITextField!
    @IBOutlet weak var contentLB: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviBar()
    }

    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    var registerBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.tintColor = UIColor.init(hexString: "26D07C")
        btn.title = "등록"
        btn.action = #selector(registerVC)
        return btn
    }()
    
    @objc func registerVC(){
    
        if (titleLB.text?.isEmpty)!{
            simpleAlert(title: "오류", message: "제목을 입력하여 주십시오.")
        }else if (contentLB.text == "내용을 입력하세요(1000자 이내)"){
            simpleAlert(title: "오류", message: "내용을 입력하여 주십시오.")
        }else{
            
                let params : [String : Any] = [
                    "board_title" : self.titleLB.text as Any,
                    "user_idx" : UserDefaults.standard.string(forKey: "userIdx")!,
                    "board_content" : self.contentLB.text
                ]
                
                CommunityWrite.shareInstance.registerboard(url: self.url("/board"), params: params) { [weak self] (result) in
                    guard let `self` = self else { return }
                    switch result {
                    case .networkSuccess(_):
                        
                        self.simpleAlertwithHandler(title: "등록하기", message: "게시글을 등록하시겠습니까?", okHandler: { (_) in self.navigationController?.popViewController(animated: false)
                        })
                    case .nullValue :
                        self.simpleAlert(title: "오류", message: "텍스트 비어있음")
                    case .networkFail :
                        self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
                    default :
                        break
                    }
                    
                }
            
        }
    }
    
    
    @objc func popSelf() {
        if (titleLB.text?.isEmpty == false)||(contentLB.text.isEmpty == false){
            simpleAlertwithHandler(title: "작성 취소", message: "내용이 저장되지 않습니다. \n작성을 취소하시겠습니까?", okHandler: { (_) in
                
                self.navigationController?.popViewController(animated: true)
                
                })
        }
        
    }
    
    func setNaviBar(){
        backBtn.target = self
        registerBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        item.rightBarButtonItem = registerBtn
        item.rightBarButtonItem?.imageInsets.right = -15
        
        bar.backgroundColor = .white
        item.title = "글 작성하기"
        bar.shadowImage = UIImage()
        
    }
    
    //상태 표시줄 흰색 만들기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
