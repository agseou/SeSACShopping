//
//  SearchViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchHistroyTableView: UITableView!
    @IBOutlet var allDeleteBtn: UIButton!
    @IBOutlet var resentLabel: UILabel!
    
    var searchHistoryList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController?.tabBarItem.title =  "검색"
        navigationItem.searchController?.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationItem.searchController?.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")

        allDeleteBtn.addTarget(self, action: #selector(tapAllDeleteBtn), for: .touchUpInside)
        
        
        registerCell()
        configureView()
       
        
    }
    
    @objc func tapAllDeleteBtn(){
        searchHistoryList.removeAll()
        resentLabel.isHidden = true
        allDeleteBtn.isHidden = true
        searchHistroyTableView.reloadData()
    }
    
    func configureView() {
        navigationItem.title = "\(UserDefaultsManager.shared.nickname)님의 새싹쇼핑"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        searchBar.searchBarStyle = .minimal
        
        resentLabel.text = "최근 검색"
        resentLabel.textColor = .white
        resentLabel.isHidden = searchHistoryList.isEmpty ? true : false
        
        allDeleteBtn.setTitle("모두 지우기", for: .normal)
        allDeleteBtn.setTitleColor(.accent, for: .normal)
        allDeleteBtn.isHidden = searchHistoryList.isEmpty ? true : false
        
        searchHistroyTableView.delegate = self
        searchHistroyTableView.dataSource = self
        
        searchHistroyTableView.backgroundColor = .clear
        searchHistroyTableView.separatorStyle = .none
        searchHistroyTableView.rowHeight = UITableView.automaticDimension
        
        searchHistroyTableView.isScrollEnabled = searchHistoryList.isEmpty ? false : true
        
    }
    
    func registerCell(){
        let xib = UINib(nibName: SearchHistoryTableViewCell.identifier, bundle: nil)
        searchHistroyTableView.register(xib, forCellReuseIdentifier: SearchHistoryTableViewCell.identifier)
        
        let xib2 = UINib(nibName: EmptyHistoryTableViewCell.identifier, bundle: nil)
        searchHistroyTableView.register(xib2, forCellReuseIdentifier: EmptyHistoryTableViewCell.identifier)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        searchHistroyTableView.isScrollEnabled = true
        searchHistoryList.insert(text, at: 0)
        UserDefaultsManager.shared.searchList = searchHistoryList
        searchHistroyTableView.reloadData()
        searchBar.searchTextField.text = nil
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
        
        vc.text = text
        
        resentLabel.isHidden = false
        allDeleteBtn.isHidden = false
        
        print(UserDefaultsManager.shared.searchList!)
        navigationController?.pushViewController(vc, animated: true)
        view.endEditing(true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchHistoryList.isEmpty {
            return 1
        } else {
            return searchHistoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchHistoryList.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyHistoryTableViewCell.identifier) as! EmptyHistoryTableViewCell
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.identifier, for: indexPath) as! SearchHistoryTableViewCell
            
            cell.configure(data: searchHistoryList[indexPath.row])
            cell.cancelBtn.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(tapCancelBtn), for: .touchUpInside)
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchHistoryList.isEmpty { return }
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
        
        vc.text = searchHistoryList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapCancelBtn(_ sender: UIButton) {
        print("tap")
        searchHistoryList.remove(at: sender.tag)
        UserDefaultsManager.shared.searchList = searchHistoryList
        print(UserDefaultsManager.shared.searchList!)
        searchHistroyTableView.reloadData()
    }
    
}
