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
    
    var searchHistoryList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController?.tabBarItem.title =  "검색"
        navigationItem.searchController?.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationItem.searchController?.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")

        registerCell()
        configureTableView()
        searchBar.searchBarStyle = .minimal
        
    }
    
    func configureTableView() {
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
        searchHistroyTableView.reloadData()
        searchBar.searchTextField.text = nil
        
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
            cell.cancelBtn.addTarget(self, action: #selector(tapCancelBtn), for: .touchUpInside)
            
            return cell
        }
        
        
    }
    
    @objc func tapCancelBtn(_ sender: UIButton) {
        print("tap")
        
        //searchHistoryList.remove(at: indexPath.row)
        //searchHistroyTableView.reloadData()
    }
    
}
