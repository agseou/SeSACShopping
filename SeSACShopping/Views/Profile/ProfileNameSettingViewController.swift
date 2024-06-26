//
//  ProfileNameSettingViewControllerViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileNameSettingViewController: UIViewController {
    
    // MARK: - Components
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var dividerView: UIView!
    @IBOutlet var cameraIconView: UIImageView!
    @IBOutlet var ProfileImageBtn: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    // MARK: - Properties
    var isAccess: Bool = false
    let viewModel = ProfileNameViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycles Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture.cancelsTouchesInView = false
        tapGesture.addTarget(self, action: #selector(tapView))
        configureView()
        configureBind()
    }
    
    // MARK: - Functions
    @objc func tapView() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    
    func configureView() {
        self.view.backgroundColor = .black
        
        navigationItem.title = "프로필 설정"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
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
        if UserDefaultsManager.shared.nickname != "" {
            nameTextField.text = UserDefaultsManager.shared.nickname
        }
        
        dividerView.backgroundColor = .accent
        
        noticeLabel.textColor = .accent
        noticeLabel.font = .systemFont(ofSize: 13)
        
        completeBtn.backgroundColor =  .gray
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.layer.cornerRadius = 10
    }
    
    func configureBind() {
        
        ProfileImageBtn.rx.tap
            .bind(with: self) { owner, _ in
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: ProfileImageSettingViewController.identifier) as! ProfileImageSettingViewController
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        completeBtn.rx.tap
            .bind(with: self) { owner, _ in
                if owner.isAccess == true {
                    
                    UserDefaultsManager.shared.nickname = owner.nameTextField.text!
                    
                    if UserDefaults.standard.bool(forKey: "UserState") == false {
                        UserDefaults.standard.set(true, forKey: "UserState")
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "MainTabBarContoroller") as! UITabBarController
                        
                        vc.modalPresentationStyle = .fullScreen
                        
                        owner.present(vc, animated: false) {
                            self.navigationController?.popViewController(animated: false)
                        }
                    } else {
                        owner.navigationController?.popViewController(animated: false)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        let input = ProfileNameViewModel.Input(name: nameTextField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.nameVaildateState
            .drive(with: self) { owner, value in
                owner.noticeLabel.text = value.rawValue
            }
            .disposed(by: disposeBag)
        
        output.vaildateState
            .drive(with: self) { owner, isEnabled in
                owner.completeBtn.isEnabled = isEnabled
                owner.completeBtn.backgroundColor = isEnabled ? .accent : .gray
                owner.isAccess = isEnabled
            }
            .disposed(by: disposeBag)
        
    }
    
}
