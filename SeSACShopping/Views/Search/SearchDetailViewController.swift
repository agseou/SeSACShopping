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
        
        let newTitle = navTitle.replacingOccurrences(of: "<b>", with: " ")
            .replacingOccurrences(of: "</b>", with: " ")
        navigationItem.title = newTitle
        
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        heartButton.tintColor = .white
           navigationItem.rightBarButtonItem = heartButton
   
        let urlString = "https://msearch.shopping.naver.com/product/\(id ?? "")"
        
        
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc func heartButtonTapped() {
        // 하트 버튼을 눌렀을 때 
    }
}
