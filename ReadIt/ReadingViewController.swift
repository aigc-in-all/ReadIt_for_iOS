//
//  ViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

let cellId = "cellId"

class ReadingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "在读"
        self.view.backgroundColor = UIColor.white
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(BookCell.self, forCellReuseIdentifier: cellId)
        
        self.view.addSubview(tableView)
        
        self.view.addConstraint(withVisualFormat: "H:|[v0]|", views: tableView)
        self.view.addConstraint(withVisualFormat: "V:|[v0]|", views: tableView)
        
        // test data
        let book1 = Book(name: "百年孤独", isbn: "xxx", pageCount: 400)
        book1.readPage = 200
        
        let book2 = Book(name: "追风筝的人", isbn: "xxx", pageCount: 400)
        book2.readPage = 70
        
        let book3 = Book(name: "未来简史", isbn: "xxx", pageCount: 400)
        book3.readPage = 40
        
        let book4 = Book(name: "解忧杂货店", isbn: "xxx", pageCount: 400)
        book4.readPage = 100
        
        let book5 = Book(name: "红岩", isbn: "xxx", pageCount: 400)
        book5.readPage = 110
        
        let book6 = Book(name: "白夜行", isbn: "xxx", pageCount: 400)
        book6.readPage = 90
        
        let book7 = Book(name: "摆渡人", isbn: "xxx", pageCount: 400)
        book7.readPage = 354
        
        books.append(book1)
        books.append(book2)
        books.append(book3)
        books.append(book4)
        books.append(book5)
        books.append(book6)
        books.append(book7)
        
        books.append(book1)
        books.append(book2)
        books.append(book3)
        books.append(book4)
        books.append(book5)
        books.append(book6)
        books.append(book7)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookCell
        cell.book = books[indexPath.item]
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
}

class BookCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            if let name = book?.name {
                bookNameLabel.text = name
            }
            
            if let pageCount = book?.pageCount, let readPage = book?.readPage {
                let progress: Float = Float(readPage) / Float(pageCount)
                progressBar.progress = progress
                // 0.3 30%
                // 0.02 2%
                // 0.345 34.5%
                progressLabel.text = "\(progress * 100)%"
            }
        }
    }
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "百年孤独"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.progress = 0.7
        bar.trackTintColor = .gray
        bar.progressTintColor = .green
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "70%"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(bookNameLabel)
        addSubview(progressBar)
        addSubview(progressLabel)
        
        addConstraint(withVisualFormat: "H:|-12-[v0]", views: bookNameLabel)
        addConstraint(withVisualFormat: "H:|-12-[v0]-4-[v1]-12-|", views: progressBar, progressLabel)
        
        addConstraint(withVisualFormat: "V:|-8-[v0(20)]-8-[v1]", views: bookNameLabel, progressBar)
        addConstraint(withVisualFormat: "V:|-30-[v0]", views: progressLabel)
    }
}

extension UIView {
    
    func addConstraint(withVisualFormat format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDict))
    }
}
