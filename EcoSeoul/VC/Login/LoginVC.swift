//
//  LoginVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, APIService {

    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let userId : String = "user_id"
    let userPwd : String = "user_pw"
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginBtn(_ sender: Any) {
        enterHome()
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        
    }

    func enterHome() {
        
     
        if (idTF.text?.isEmpty)! || (passwordTF.text?.isEmpty)! {
            simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해 주세요")
            return
        }
        
        let params: [String:Any] = [
            userId : gsno(idTF.text),
            userPwd : gsno(passwordTF.text)
        ]
        
        
        
        guard let homeVC = UIStoryboard(name: "HomeUp", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
        
        
        LoginService.shareInstance.login(url: url("/mypage/login"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }

            switch result {
                case .networkSuccess(let userIdx):
                    self.userDefault.set((userIdx as? Int), forKey: "userIdx")
                    self.userDefault.set(self.idTF.text, forKey: "userId")
                    guard let homeVC = UIStoryboard(name: "HomeUp", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    else { return }
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    break
                case .wrongInput :
                    self.simpleAlert(title: "오류", message: "아이디와 비밀번호를 확인해주세요 :)")
                    break
                case .nullValue :
                    self.simpleAlert(title: "오류", message: "빈 값이 들어갑니다")
                case .serverErr :
                    self.simpleAlert(title: "오류", message: "서버 에러")
                case .networkFail :
                    self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
                default :
                    break
            }
        })
        
    }
}



extension LoginVC {
    
    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    ///////////////////////////
    
}
