//
//  ProfileNameSettingViewControllerViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileNameSettingViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var dividerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        completeBtn.addTarget(self, action: #selector(tapCompleteBtn), for: .touchUpInside)
        
        configureView()
    }
    
    @objc func tapCompleteBtn(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabBarContoroller") as! UITabBarController
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: false)
    }
    
    func configureView() {
        self.view.backgroundColor = .black
        
        profileImageView.image = UIImage(resource: .profile1)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius
            = self.profileImageView.bounds.width/2
        }
        profileImageView.layer.borderColor = UIColor.accent.cgColor
        profileImageView.layer.borderWidth = 5
        
        nameTextField.placeholder = "닉네임을 입력해주세요"
        nameTextField.backgroundColor = .clear
        
        dividerView.backgroundColor = .accent
        
        noticeLabel.text = "닉네임에 @는 포함할 수 없어요"
        
        completeBtn.backgroundColor = .accent
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.layer.cornerRadius = 10
    }

}
