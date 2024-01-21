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
    @IBOutlet var cameraIconView: UIImageView!
    @IBOutlet var ProfileImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImageBtn.addTarget(self, action: #selector(tapProfileImageBtn), for: .touchUpInside)

        completeBtn.addTarget(self, action: #selector(tapCompleteBtn), for: .touchUpInside)
        
        
        configureView()
    }
    
    @objc func tapProfileImageBtn() {
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileImageSettingViewController.identifier) as! ProfileImageSettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapCompleteBtn() {
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
    
        cameraIconView.image = UIImage(resource: .camera)
        
        ProfileImageBtn.setTitle("", for: .normal)
        
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
