//
//  SearchTableViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/6.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit
import ObjectMapper
import Toast_Swift

class SearchViewController: UITableViewController {

    var books = [Book]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.bgColor
        self.title = "添加"
        
        let cancelBarButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancelButtonClicked))
        self.navigationItem.leftBarButtonItem = cancelBarButton
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "请输入书名"
        searchController.searchBar.setValue("取消", forKey: "_cancelButtonText")
        
        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.register(NormalBookCell.self, forCellReuseIdentifier: "cell")
        
        self.definesPresentationContext = true
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NormalBookCell
        cell.book = books[indexPath.item]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedBook = books[indexPath.item]
        
        if BookModel.instance.bookExist(isbn: selectedBook.isbn!) {
            let alert = UIAlertController(title: nil, message: "这本书已经添加过了~", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        selectedBook.createdTime = "\(Int64(Date().timeIntervalSince1970 * 1000))"
        selectedBook.readPages = "0"
        
        guard BookDao.instance.insertBook(book: selectedBook) else {
            self.view.makeToast("添加失败，请重试")
            return
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - ViewController
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: - Custom Methods
    
    func onCancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        searchBooks(name: searchText)
    }
    
    func searchBooks(name: String) {
        if name == "" {
            books = []
            return
        }
        
        let url = "https://api.douban.com/v2/book/search"
        let params = ["q": name]
        HttpManager.sharedInstance.getRequest(urlString: url, params: params, success: { (data) in
            guard let bookJsonArray = data["books"] else {
                return
            }
            
            guard let searchedBooks = Mapper<Book>().mapArray(JSONArray: bookJsonArray as! [[String : Any]]) else {
                return
            }
            
            self.books = searchedBooks
        }) { (error) in
            print(error)
        }
    }
}
