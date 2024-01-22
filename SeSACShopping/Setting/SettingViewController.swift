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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.searchController?.tabBarItem.title =  "검색"
        navigationItem.searchController?.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationItem.searchController?.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        
        configureTableView()
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
            let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
            
            let OKBtn = UIAlertAction(title: "확인", style: .default) { Action in
                UserDefaults.standard.set(false, forKey: "UserState")
                self.dismiss(animated: false)
            }
            let CancelBtn = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(OKBtn)
            alert.addAction(CancelBtn)
            
            present(alert, animated: true)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingProfileCell", for: indexPath)
            
            cell.textLabel?.text = "떠나고 싶은 고래밥"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .boldSystemFont(ofSize: 17)
            
            cell.detailTextLabel?.text = "8개의 상품을 좋아하고 있어요"
            cell.detailTextLabel?.textColor = .white
            cell.detailTextLabel?.font = .boldSystemFont(ofSize: 15)
            
            cell.backgroundColor = .darkGray
            
            cell.imageView?.image = UIImage(resource: .profile1)
            DispatchQueue.main.async {
                cell.imageView?.layer.cornerRadius
                = cell.imageView!.bounds.width/2
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingDetailCell", for: indexPath)
            
            cell.backgroundColor = .darkGray
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textColor = .white
            
            return cell
        }
    }

    
    
}
