//
//  WebVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {
        
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var address: String!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.request(url: address)

        }
        
        // 이전 페이지로 이동
        @IBAction func back() {
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        }
        @IBAction func dismiss(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    
        // 다음 페이지로 이동
        @IBAction func forward() {
            if self.webView.canGoForward {
                self.webView.goForward()
            }
        }
        
        // 현재 webView에서 받아온 URL 페이지를 로드한다.
        func request(url: String) {
            self.webView.load(URLRequest(url: URL(string: url)!))
            self.webView.navigationDelegate = self
        }
}


// searchBar에서 검색하면 searchBar에 입력된 주소를 요청한다.
extension WebVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.request(url: searchBar.text!)
        
        //다른곳을 터치하면 키보드가 내려갈 수 있도록 한다.
        self.view.endEditing(true)
    }
    
    
}

// 현재 웹페이지의 URL을 searchBar에 띄워준다.
extension WebVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.searchBar.text = webView.url?.absoluteString
    }
}
