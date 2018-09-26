//
//  AffiliationDetailVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import GoogleMaps

class AffiliationDetailVC: UIViewController{
    
    var guIdx: Int?
    var markerSelected = false
    var storeData = [String: Any]()
    
    //구 별 카메라 포지션(20개정도 필요)
    let cameraLat: [CLLocationDegrees] = [37.553981, 0]
    let cameraLong: [CLLocationDegrees] = [126.831838, 0]
    
    //MapView Elements
    
    @IBOutlet weak var topVIew: UIView!
    @IBOutlet weak var displayView: GMSMapView!
    @IBOutlet weak var bottomVIew: UIView!
    
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayView.delegate = self;
        bottomViewConstraint.constant += 110
        initMap()

    }
    
    func initMap(){
        
        //zoom up when value is increasing
        let cameraZoom: Float = 15.0
        
        if let idx = guIdx {
            let camera = GMSCameraPosition.camera(withLatitude: cameraLat[0], longitude: cameraLong[0], zoom: Float(cameraZoom))
            displayView.camera = camera
        }
        
        //서버에서 받은 DataArray의 예시
        let marker: [GMSMarker] = [GMSMarker(), GMSMarker(), GMSMarker()]
        let markerLat: [CLLocationDegrees] = [37.553981, 37.553015, 37.553280]
        let markerLong: [CLLocationDegrees] = [126.831838, 126.834128, 126.829830]
        let markerName = ["충신이네 집","GS25 명덕점","고수통닭"]
        let markerAddress = ["강서구 공항대로 36가길 66","나도 몰라", "나도 몰라2"]
        let markerPhone = ["010-5703-5763","02-2663-9999","02-2665-9292"]
        
        let markerType = [0,1,0]
        
        for i in 0..<marker.count{
            marker[i].position = CLLocationCoordinate2D(latitude: markerLat[i], longitude: markerLong[i])
            
            if markerType[i] == 0 {
                marker[i].icon = #imageLiteral(resourceName: "affiliate-marker")
            }
            marker[i].map = displayView
            
            
            storeData["name"] = markerName[i]
            storeData["address"] = markerAddress[i]
            storeData["phone"] = markerPhone[i]
            
            marker[i].userData = storeData
        }
        
        //displayView.isMyLocationEnabled = true
        //displayView.settings.myLocationButton = true
        //displayView.selectedMarker = marker
        
    }
}

extension AffiliationDetailVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        
        if let data = marker.userData as? [String: Any] {
            nameLabel.text = data["name"] as? String
            addressLabel.text = data["address"] as? String
            phoneLabel.text = data["phone"] as? String
        }
        
        
        //bottom View 등장 애니메이션 (마커선택시 올라오게)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction], animations:
            {
                if self.markerSelected == false {self.bottomViewConstraint.constant -= 110
                    self.markerSelected = !self.markerSelected
                }
                else{ self.bottomViewConstraint.constant += 110
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

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    ///////////////////////////
    
    
}
