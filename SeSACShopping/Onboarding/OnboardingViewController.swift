//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var subImageView: UIImageView!
    @IBOutlet var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        startBtn.addTarget(self, action: #selector(tapStartBtn), for: .touchUpInside)
        
    }
    
    func configureView(){
        self.view.backgroundColor = .black
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        logoImageView.image = UIImage(resource: .sesacShopping)
        subImageView.image = UIImage(resource: .onboarding)
        
        startBtn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        startBtn.setTitle("시작하기", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.backgroundColor = .accent
        startBtn.layer.cornerRadius = 10
        
    }
    
    @objc func tapStartBtn(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileNameSettingViewController.identifier) as! ProfileNameSettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
