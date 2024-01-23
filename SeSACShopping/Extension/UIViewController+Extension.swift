//
//  UIViewController+Extension.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   buttonTitle: String,
                   completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
