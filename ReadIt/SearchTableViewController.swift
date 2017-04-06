//
//  SearchTableViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/6.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var books = [Book]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.bgColor
        self.title = "添加"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "请输入书名"
        searchController.searchBar.setValue("取消", forKey: "_cancelButtonText")
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.register(BookCell.self, forCellReuseIdentifier: "cell")
        
        self.definesPresentationContext = true
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let book = books[indexPath.item]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author?.joined(separator: ",")
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}

class BookCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
