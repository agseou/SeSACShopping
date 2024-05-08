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
    let searchManager = SearchAPIManager()
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    let HistoryList = UserDefaultsManager.shared.searchList
    var searchHistoryList: [String] = [] {
        didSet { //변경된 직후 -> 프로퍼티 옵저버.
            searchHistroyTableView.reloadData()
            UserDefaultsManager.shared.searchList = searchHistoryList
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture.cancelsTouchesInView = false
        let item = UITabBarItem(title: "검색",
                                image: UIImage(systemName: "magnifyingglass"),
                                selectedImage: UIImage(systemName: "magnifyingglass"))
        
        navigationController?.tabBarItem = item
        
        allDeleteBtn.addTarget(self, action: #selector(tapAllDeleteBtn), for: .touchUpInside)
        tapGesture.addTarget(self, action: #selector(tapView))
        guard let list = HistoryList else {
            return
        }
        searchHistoryList = list
        
        registerCell()
        configureView()
        
    }
    
    @objc func tapView() {
        view.endEditing(true)
    }
    
    @objc func tapAllDeleteBtn(){
        searchHistoryList.removeAll()
        resentLabel.isHidden = true
        allDeleteBtn.isHidden = true
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
        
        if let index = searchHistoryList.firstIndex(of: text) {
            searchHistoryList.remove(at: index)
            searchHistoryList.insert(text, at: 0)
        } else {
            searchHistoryList.insert(text, at: 0)
        }
        searchBar.searchTextField.text = nil
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
        
        vc.text = text
        Task {
            do {
                let shopping = try await searchManager.callRequest(text: text, sort: "sim")
                DispatchQueue.main.async {
                    vc.totalSearchNumLabel.text =  "\(String(shopping.total).formattedNumber()!) 개의 검색결과"
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
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
        Task {
            do {
                let shopping = try await  searchManager.callRequest(text: searchHistoryList[indexPath.row], sort: "sim")
                DispatchQueue.main.async {
                    vc.totalSearchNumLabel.text =  "\(String(shopping.total).formattedNumber()!) 개의 검색결과"
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapCancelBtn(_ sender: UIButton) {
        searchHistoryList.remove(at: sender.tag)
        print(UserDefaultsManager.shared.searchList!)
    }
    
}
