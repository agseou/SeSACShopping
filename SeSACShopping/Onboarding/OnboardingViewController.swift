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
        
    }
    
    func configureView(){
        self.view.backgroundColor = .black
        
        logoImageView.image = UIImage(resource: .sesacShopping)
        subImageView.image = UIImage(resource: .onboarding)
        
        startBtn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        startBtn.setTitle("시작하기", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.backgroundColor = .accent
        startBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func tapStartBtn(_ sender: UIButton) {
        
        
    }
    
}
