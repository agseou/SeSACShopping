//
//  ProfileNameSettingViewControllerViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileNameSettingViewController: UIViewController {
    
    enum nickNameState: String {
        case none = "특수문자, 숫자 제외 2자이상 10자 미만으로 입력해주세요."
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
        if isAccess == true {
            
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    
    func configureView() {
        self.view.backgroundColor = .black
        
        navigationItem.title = "프로필 설정"
        
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
        
        noticeLabel.text = nickNameState.none.rawValue
        noticeLabel.textColor = .accent
        noticeLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.backgroundColor =  .gray
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.layer.cornerRadius = 10
    }
    
}

extension ProfileNameSettingViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 새로운 텍스트를 만들어봅니다.
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        // 길이, 특수 문자, 숫자 여부를 검사하여 noticeLabel 업데이트
        if newText.isEmpty {
            noticeLabel.text = nickNameState.none.rawValue
            isAccess = false
        }else if newText.count > 10 || newText.count < 2 {
            noticeLabel.text = nickNameState.isCount.rawValue
            isAccess = false
        } else if newText.containsSpecialCharacters() {
            noticeLabel.text = nickNameState.isSpecial.rawValue
            isAccess = false
        } else if newText.containsNumbers() {
            noticeLabel.text = nickNameState.isNumber.rawValue
            isAccess = false
        } else {
            noticeLabel.text = nickNameState.ok.rawValue
            isAccess = true
        }

        completeBtn.backgroundColor = isAccess ? .accent : .gray
        
        return true
    }
}

extension String {
    func containsSpecialCharacters() -> Bool {
        // 특수 문자가 포함되어 있는지 여부를 정규 표현식으로 검사
        let regex = ".*[^A-Za-z0-9].*"
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    func containsNumbers() -> Bool {
        // 숫자가 포함되어 있는지 여부를 정규 표현식으로 검사
        let regex = ".*[0-9].*"
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
