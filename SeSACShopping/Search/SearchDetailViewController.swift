//
//  SearchDetailViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import UIKit
import WebKit

class SearchDetailViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    var id: String!
    var navTitle: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
   
        let urlString = "https://msearch.shopping.naver.com/product/\(id ?? "")"
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
