//
//  LoginVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, APIService {
    
    let userDefault = UserDefaults.standard
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var logoGifView: UIImageView!
    
    var seconds = 5
    var timer = Timer()
    
    let userId : String = "user_id"
    let userPwd : String = "user_pw"

    override func viewDidLoad() {
        super.viewDidLoad()
        idTF.delegate = self;
        pwTF.delegate = self;
        
        self.runTime()
        self.loadImage()
    }
    
    
    func runTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    func loadImage(){
        
//        //    self.imageView.image = UIImage.gif(name: "logo")
//        let imageData = try! Data(contentsOf: Bundle.main.url(forResource: "logo", withExtension: "gif")!)
//
//        let image = UIImage.gif(data: imageData)
//        imageView.animationImages = image?.images
//        imageView.animationDuration = (image?.duration)! / 4
//        imageView.startAnimating()
//        self.imageView.image = image
        
        
    }
    
    @objc func updateTime(){
        
        seconds -= 1
        if seconds == 0 {
            timer.invalidate()
            logoGifView.isHidden = true
        }
    }

    @IBAction func loginBtn(_ sender: Any) {
        enterHome()
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        print("회원가입 뷰전환을 구현해주세요!")
    }

    func enterHome() {
        
        if (idTF.text?.isEmpty)! || (pwTF.text?.isEmpty)! {
            simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해 주세요")
            return
        }
        
        let params: [String:Any] = [
            userId : gsno(idTF.text),
            userPwd : gsno(pwTF.text)
        ]

        LoginService.shareInstance.login(url: url("/mypage/login"), params: params, completion: { [weak self] (result) in
            
            guard let `self` = self else { return }

            switch result {
                case .networkSuccess(let data):
                    
                    let datas = data as! Login
                    self.userDefault.set(datas.userIdx, forKey: "userIdx")
                    self.userDefault.set(datas.userId, forKey: "userId")
                    self.userDefault.set(datas.userName, forKey: "userName")
                    
                    if let barcodeNum = datas.userBarcodeNum {
                        self.userDefault.set(barcodeNum, forKey: "userBarcode")
                    }
                
                    let homeVC = UIStoryboard(name: "HomeUp", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    break
                case .wrongInput :
                    self.simpleAlert(title: "오류", message: "아이디와 비밀번호를 확인해주세요 :)")
                    break
                case .nullValue :
                    self.simpleAlert(title: "오류", message: "빈 값이 들어갑니다")
                    break
                case .serverErr :
                    self.simpleAlert(title: "오류", message: "서버 에러")
                    break
                case .networkFail :
                    self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
                    break
                default :
                    break
            }
        })
        
    }
}


extension LoginVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //Reset TextField.
        self.idTF.text = ""
        self.pwTF.text = ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    ///////////////////////////
    
}
