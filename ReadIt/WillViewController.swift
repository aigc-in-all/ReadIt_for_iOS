//
//  WillViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class WillViewController: UITableViewController {
    
    let cellIdForContent = "content"
    
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "想读"
        self.view.backgroundColor = UIColor.bgColor
        
        self.tableView.separatorColor = .clear
        self.tableView.register(NormalBookCell.self, forCellReuseIdentifier: cellIdForContent)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        books.removeAll()
        books.append(contentsOf: BookModel.instance.queryAllByWant())
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForContent, for: indexPath) as! NormalBookCell
        cell.book = books[indexPath.item]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.isbn = books[indexPath.item].isbn
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
