//
//  AffiliationDetailVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 19..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import GoogleMaps

class AffiliationDetailVC: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    var districtTag: Int?
    
    //MapView Elements
    @IBOutlet weak var mapView: GMSMapView!
    var cameraZoom: Float = 13.0
    
    //bottomView Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var salesPercent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        bottomViewConstraint.constant += 110
        initMap()
    
    }
    
    @IBAction func popBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    func initMap(){
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.553963 , longitude: 126.832032, zoom: Float(cameraZoom))
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView;
        
        self.mapView.camera = camera
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.553963, longitude: 126.832032)
        marker.title = "서울"
        marker.snippet = "대한민국"
        marker.map = mapView
        
    }

    
    //bottom View 등장 애니메이션 (마커선택시 올라오게)
    //        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
    //            self.bottomViewConstraint.constant -= 110
    //            self.view.layoutIfNeeded()
    //        }, completion:nil)
  
    


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
