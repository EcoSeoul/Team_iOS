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
    
    //SPLAH SCREEN VARIABLE
    @IBOutlet weak var logoGifView: UIImageView!
    var seconds = 6
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTF.delegate = self;
        pwTF.delegate = self;
        
        loadGifImage()
    }
    

    @IBAction func loginBtn(_ sender: Any) {
        enterHome()
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        print("회원가입 뷰전환을 구현해주세요!")
    }
    
    //로그아웃을 하면 LoginVC로 돌아올 수 있도록 하기 위함
    @IBAction func unwind(_ sender: UIStoryboardSegue){
        
    }

    func enterHome() {
        
        if (idTF.text?.isEmpty)! || (pwTF.text?.isEmpty)! {
            simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해 주세요")
            return
        }
        
        network()
        
    }
    
    func network(){
        
        let params: [String:Any] = [
            "user_id" : gsno(idTF.text),
            "user_pw" : gsno(pwTF.text)
        ]
        
        LoginService.shareInstance.login(url: url("/mypage/login"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                case .networkSuccess(let data):
                    setDB(data)
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
        
        func setDB(_ data: LoginData){
            guard let barcodeNum = data.userBarcodeNum else{return}
            self.userDefault.set(barcodeNum, forKey: "userBarcode")
            self.userDefault.set(data.userIdx, forKey: "userIdx")
            self.userDefault.set(data.userId, forKey: "userId")
            self.userDefault.set(data.userName, forKey: "userName")
            self.userDefault.set(data.userMileage, forKey: "userMileage")
            
        }
        
    }
}


//GIF SPLASH SCREEN
extension LoginVC {

    func loadGifImage(){
        //set Timer to limit animation.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        //self.imageView.image = UIImage.gif(name: "logo")
        let imageData = try! Data(contentsOf: Bundle.main.url(forResource: "logo", withExtension: "gif")!)
        let image = UIImage.gif(data: imageData)
        
        logoGifView.animationImages = image?.images
        logoGifView.animationDuration = (image?.duration)! / 4
        logoGifView.startAnimating()
        
        self.logoGifView.image = image
    }
    
    @objc func updateTime(){
        
        seconds -= 1
        
        if seconds == 0 {
            timer.invalidate()
            logoGifView.isHidden = true
            logoGifView.stopAnimating()
        }
        
    }
    
    
}


extension LoginVC: UITextFieldDelegate {

    //화면 터치 또는 Return 클릭시 키보드가 내려감.
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
 
}
