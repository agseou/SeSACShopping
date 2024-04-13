//
//  SettingViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!
    
    let list: [String] = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 다시 시작하기"]
    //var count: Int = UserDefaultsManager.shared.likes!.count
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UITabBarItem(title: "설정",
                                image: UIImage(systemName: "person"),
                                selectedImage: UIImage(systemName: "person.fill"))
        
        navigationController?.tabBarItem = item
        
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // count = UserDefaultsManager.shared.likes!.count
        settingTableView.reloadData()
    }
    
    func configureView() {
        navigationItem.title = "설정"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        settingTableView.backgroundColor = .clear
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ProfileNameSettingViewController.identifier) as! ProfileNameSettingViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 4 {
            showAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", buttonTitle: "확인") {
                UserDefaults.standard.set(false, forKey: "UserState")
                UserDefaultsManager.shared.nickname = ""
                UserDefaultsManager.shared.likes = []
                UserDefaultsManager.shared.searchList = []
                self.dismiss(animated: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) {
            return 80
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingProfileCell", for: indexPath)
            
            cell.textLabel?.text = "떠나고 싶은 \(UserDefaultsManager.shared.nickname)"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .boldSystemFont(ofSize: 17)
            
         //   cell.detailTextLabel?.text = "\(count)개의 상품을 좋아하고 있어요"
            cell.detailTextLabel?.textColor = .white
            cell.detailTextLabel?.font = .boldSystemFont(ofSize: 13)
            

            
            cell.imageView?.image = UIImage(named: UserDefaultsManager.shared.image)
            DispatchQueue.main.async {
                cell.imageView?.layer.cornerRadius
                = cell.imageView!.bounds.width/2
            }
            cell.imageView?.layer.borderColor = UIColor.accent.cgColor
            cell.imageView?.layer.borderWidth = 3
            
            tableView.reloadRows(at: [indexPath], with: .fade)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingDetailCell", for: indexPath)
            
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textColor = .white
            tableView.reloadRows(at: [indexPath], with: .fade)
            
            return cell
        }
    }

    
    
}
