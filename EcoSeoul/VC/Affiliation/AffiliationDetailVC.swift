//
//  AffiliationDetailVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import GoogleMaps

class AffiliationDetailVC: UIViewController, APIService{
    
    //MapView Elements
    @IBOutlet weak var topVIew: UIView!
    @IBOutlet weak var displayView: GMSMapView!
    @IBOutlet weak var bottomVIew: UIView!
    

    var markerSelected = false
    var storeData = [String: Any]()
    
    //Franchise Information
    var frcIdxArr: [Int] = []

    //BottomView Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var salesPercent: UIImageView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint! //bottomView의 움직임을 제어하기 위한 Constraint
    
    //Pop Action(TopView에 있는 Back Button)
    @IBAction func popBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        displayView.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayView.delegate = self;
        bottomViewConstraint.constant += 110

        for frcIdx in 0..<frcIdxArr.count {
            franDetailDataInit(url : url("/franchise/detail/\(frcIdxArr[frcIdx])"))
        }

    }
    
    func franDetailDataInit(url : String){
        
        FranchiseDetailService.shareInstance.getFranchiseDetailData(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
                case .networkSuccess(let data):
                    self.initMap(data)
                    break
                case .networkFail :
                    self.simpleAlert(title: "network", message: "check")
                    break
                default :
                    break
            }
        })
        
    }
    
    
    func initMap(_ data: FranchiseDetailData){
        
        storeData["name"] = data.frcName
        storeData["address"] = data.frcAdd
        storeData["phone"] = data.frcPhone
        storeData["frc_sale"] = String(data.frcSale)
        
        //zoom up when value is increasing
        let cameraZoom: Float = 12.5
        let camera = GMSCameraPosition.camera(withLatitude: data.frcLat, longitude: data.frcLong, zoom: Float(cameraZoom))
        displayView.camera = camera
      
        let marker = GMSMarker()
       
        marker.position = CLLocationCoordinate2D(latitude: data.frcLat, longitude: data.frcLong)
            
        if data.frcType == 0 {
            marker.icon = #imageLiteral(resourceName: "map-marker-green")
            categoryLabel.text = "가맹점"
        }
        if data.frcType == 1{
            marker.icon = #imageLiteral(resourceName: "map-marker-darkgreen")
             categoryLabel.text = "공공시설"
        }
      
        marker.map = displayView
        marker.userData = storeData
        
    }
    
        //displayView.isMyLocationEnabled = true
        //displayView.settings.myLocationButton = true
        //displayView.selectedMarker = marker
        
    
}

extension AffiliationDetailVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    
        var saleInfo = ""
        
        if let data = marker.userData as? [String: Any] {
            nameLabel.text = data["name"] as? String
            addressLabel.text = data["address"] as? String
            phoneLabel.text = data["phone"] as? String
            saleInfo = data["frc_sale"] as! String
        }
        
        switch saleInfo {
            case "5" :
                print("5프로할인!")
            case "10" :
                print("10프로 할인!!")
            case "20" :
                print("20프로 할인!!")
            case "30" :
                print("30프로 할인!!")
            case "100":
                print("무료!!!!")
            break
        default: break
            
        }
        
        
        //bottom View 등장 애니메이션 (마커선택시 올라오게)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction], animations:
            {
                if self.markerSelected == false {
                    self.bottomViewConstraint.constant -= 110
                    marker.icon = #imageLiteral(resourceName: "map-marker-darkgreen-big")
                    self.markerSelected = !self.markerSelected
                }
                else{
                    self.bottomViewConstraint.constant += 110
                    marker.icon = #imageLiteral(resourceName: "map-marker-darkgreen")
                    self.markerSelected = !self.markerSelected
                }
                self.view.layoutIfNeeded() }, completion:nil)
        
        return true
    }
    
    
}

extension AffiliationDetailVC {
    
    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
       
//        for frcIdx in 0..<frcIdxArr.count {
//            franDetailDataInit(url : url("/franchise/detail/\(frcIdxArr[frcIdx])"))
//        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
      
    }
    ///////////////////////////
    
    
}
