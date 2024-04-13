//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {

    // MARK: - Components
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var subImageView: UIImageView!
    @IBOutlet var startBtn: UIButton!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycles Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureBind()
    }
    
    // MARK: - Functions
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
    
    func configureBind() {
        startBtn.rx.tap
            .bind(with: self) { owner, _ in
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: ProfileNameSettingViewController.identifier) as! ProfileNameSettingViewController
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
