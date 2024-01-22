//
//  ProfileNameSettingViewControllerViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileNameSettingViewController: UIViewController {
    
    enum nickNameState: String {
        case ok = "사용할 수 있는 닉네임이에요"
        case isCount = "2글자 이상 10글자 미만으로 설정해주세요"
        case isNumber = "닉네임에 숫자는 포함할 수 없어요"
        case isSpecial = "닉네임에 @,#,$,%는 포함할 수 없어요"
    }
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var dividerView: UIView!
    @IBOutlet var cameraIconView: UIImageView!
    @IBOutlet var ProfileImageBtn: UIButton!
    var isAccess: Bool = false
    
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
        
        UserDefaultsManager.shared.nickname = nameTextField.text!
        
        if UserDefaults.standard.bool(forKey: "UserState") == false {
            UserDefaults.standard.set(true, forKey: "UserState")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainTabBarContoroller") as! UITabBarController
            
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: false) {
                self.navigationController?.popViewController(animated: false)
            }
        } else {
            navigationController?.popViewController(animated: false)
        }
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
        
        nameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nameTextField.backgroundColor = .clear
        nameTextField.borderStyle = .none
        nameTextField.delegate = self
        
        dividerView.backgroundColor = .accent
        
        noticeLabel.text = "닉네임에 @는 포함할 수 없어요"
        noticeLabel.textColor = .accent
        noticeLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.backgroundColor = .accent
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.layer.cornerRadius = 10
    }
    
}

extension ProfileNameSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count > 10 || textField.text!.count < 2 {
            noticeLabel.text = nickNameState.isCount.rawValue
        }
    }
    
   
}
