//
//  PayVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PayVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadViewDesign()
        configureButtonBar()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        let child1 = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "MileageTVC")
        let child2 = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "MoneyTVC")
        return [child1, child2]
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func loadViewDesign(){
//        self.settings.style.selectedBarHeight = 1
//        self.settings.style.buttonBarBackgroundColor = UIColor.white
//        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
//        self.settings.style.selectedBarBackgroundColor = .white
//        self.settings.style.selectedBarVerticalAlignment = .bottom
//        self.settings.style.buttonBarMinimumLineSpacing = 0
//        self.settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
//        self.settings.style.buttonBarItemFont = UIFont(name: notoSansFont.Medium.rawValue, size: 17)!
//        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
//        self.settings.style.buttonBarLeftContentInset = 10
//        self.settings.style.buttonBarRightContentInset = 10
//        self.settings.style.buttonBarHeight = 44
//        let buttonBar = ButtonBarView(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: self.settings.style.buttonBarHeight!), collectionViewLayout: UICollectionViewFlowLayout())
//        buttonBar.backgroundColor = .white
//        buttonBar.selectedBar.backgroundColor = .white
//        buttonBar.autoresizingMask = .flexibleWidth
//        var newContainerViewFrame = containerView.frame
//        newContainerViewFrame.origin.y = 104
//        newContainerViewFrame.size.height = containerView.frame.size.height - (self.settings.style.buttonBarHeight! - containerView.frame.origin.y)
//        containerView.frame = newContainerViewFrame
//
//        self.settings.style.selectedBarBackgroundColor = UIColor.white
////        let buttonBarViewAux = buttonBarView ?? {
////            let flowLayout = UICollectionViewFlowLayout()
////            flowLayout.scrollDirection = .horizontal
////            let buttonBarHeight = settings.style.buttonBarHeight ?? 44
////            let buttonBar = ButtonBarView(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: buttonBarHeight), collectionViewLayout: flowLayout)
////            buttonBar.backgroundColor = .white
////            buttonBar.selectedBar.backgroundColor = .white
////            buttonBar.autoresizingMask = .flexibleWidth
////            var newContainerViewFrame = containerView.frame
////            newContainerViewFrame.origin.y = 104
////            newContainerViewFrame.size.height = containerView.frame.size.height - (buttonBarHeight - containerView.frame.origin.y)
////            containerView.frame = newContainerViewFrame
////            return buttonBar
////            }()
////        buttonBarView = buttonBarViewAux
////
////        if buttonBarView.superview == nil {
////            view.addSubview(buttonBarView)
////        }
////        if buttonBarView.delegate == nil {
////            buttonBarView.delegate = self
////        }
////        if buttonBarView.dataSource == nil {
////            buttonBarView.dataSource = self
////        }
////        buttonBarView.scrollsToTop = false
//
//        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell, newCell: ButtonBarViewCell, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
//            guard changeCurrentIndex == true else { return }
//            oldCell.label.textColor = UIColor.white
//            newCell.label.textColor = UIColor.white
//
//            } as? ((ButtonBarViewCell?, ButtonBarViewCell?, CGFloat, Bool, Bool) -> Void)
//    }
    
    func configureButtonBar() {
        // Sets the background colour of the pager strip and the pager strip item
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        
        // Sets the pager strip item font and font color
        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 16.0)!
        settings.style.buttonBarItemTitleColor = .gray
        
        // Sets the pager strip item offsets
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        // Sets the height and colour of the slider bar of the selected pager tab
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .black
        
        settings.style.buttonBarBackgroundColor = .white
        
        containerView.frame.origin.y = 104
        buttonBarView.frame.contains(CGRect(x: 0, y: 60, width: 375, height: 667))
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
    }
}

