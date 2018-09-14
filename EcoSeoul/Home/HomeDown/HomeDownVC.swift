//
//  HomeDownVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class HomeDownVC: UIViewController {

    @IBOutlet weak var barcodeView: UILabel!
    

    @IBOutlet weak var barcodeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = generateBarcodeFromString(string: "lcs921125")
        barcodeBtn.setBackgroundImage(image, for: .normal)

    }
    
    
    func generateBarcodeFromString(string: String)-> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform.init(scaleX: 10, y: 10)
        let output = filter?.outputImage?.transformed(by: transform)
        
        if(output != nil){
            return UIImage(ciImage: output!)
        }
        return nil
        
    }

    //바코드 버튼 클릭
    @IBAction func barcodePressed(_ sender: Any) {
        let homeSubStoryboard = UIStoryboard.init(name: "HomeSub", bundle: nil)
        let barcodeVC = homeSubStoryboard.instantiateViewController(withIdentifier: "BarcodeVC") as? BarcodeVC
        self.present(barcodeVC!, animated: true, completion: nil)
    }
    
    
}
