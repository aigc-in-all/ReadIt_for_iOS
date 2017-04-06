//
//  AddViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

typealias SaveReturn = (Book) -> Void

class AddBookViewController: UIViewController {
    
    var newBook: Book?
    
    var callback: SaveReturn?
    
    let editBox: UITextField = {
        let box = UITextField()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.borderStyle = .roundedRect
        box.clearButtonMode = .whileEditing
        box.keyboardType = .numberPad
        box.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        box.placeholder = "请输入ISBN获取书籍信息"
        box.text = "9787539971810"
        return box
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.titleLabel?.text = "搜索"
        button.setTitle("搜索", for: .normal)
        button.addTarget(self, action: #selector(onSearchButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let detailLable: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.isEditable = false
        label.isScrollEnabled = true
        return label
    }()
    
    lazy var loadingDialog: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "正在添加...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(loadingIndicator)
        
        loadingIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor).isActive = true
        
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.bgColor
        self.title = "添加书籍"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onSaveButtonClicked))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.view.addSubview(searchButton)
        self.view.addSubview(editBox)
        self.view.addSubview(detailLable)
        
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        searchButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        
        editBox.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        editBox.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -12).isActive = true
        editBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        editBox.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        detailLable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        detailLable.topAnchor.constraint(equalTo: editBox.bottomAnchor, constant: 12).isActive = true
        detailLable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        detailLable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -12).isActive = true
    }
    
    // MARK: - Custom actions
    
    func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSaveButtonClicked() {
        // save newBook to db and back
        guard newBook != nil else {
            return
        }
        
        if BookModel.instance.bookExist(isbn: (newBook?.isbn!)!) {
            let alert = UIAlertController(title: nil, message: "这本书已经添加过了~", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        newBook?.createdTime = "\(Int64(Date().timeIntervalSince1970 * 1000))"
        newBook?.readPages = "0"
        
        if BookModel.instance.add(book: newBook!) {
            // success
            self.dismiss(animated: true, completion: nil)
            if callback != nil {
                callback!(newBook!)
            }
        } else {
            // failure
            print("save failure")
        }
    }
    
    func textFieldDidChanged() {
        searchButton.isEnabled = !(editBox.text?.isEmpty)!
    }
    
    func onSearchButtonClicked() {
        self.searchButton.isEnabled = false
        
        let url = "https://api.douban.com/v2/book/isbn/:\(editBox.text!)"
        HttpManager.sharedInstance.getRequest(urlString: url, params: nil, success: { (response) in
            self.searchButton.isEnabled = true
            guard let book = Book(JSON: response) else {
                self.detailLable.text = "什么都没找到~"
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                return
            }
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
            let isbn = book.isbn ?? ""
            let title = book.title ?? ""
            let pages = book.pages ?? "0"
            let author = book.author ?? [""]
            let pubdate = book.pubdate ?? ""
            let translator = book.translator ?? [""]
            let image = book.image ?? ""
            let publisher = book.publisher ?? ""
            let authorIntro = book.authorIntro ?? ""
            let summary = book.summary ?? ""
            self.detailLable.text = "isbn:\(isbn)\ntitle:\(title)\npages:\(pages)\nauthor:\(author)\npubdate:\(pubdate)\ntranslator:\(translator)\nimage:\(image)\npublisher:\(publisher)\nauthorIntro:\(authorIntro)\nsummary:\(summary)"
            
            self.newBook = book
        }) { (error) in
            self.searchButton.isEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.detailLable.text = "搜索失败~"
            
        }
    }
    
    func showLoadingDialog() {
        present(loadingDialog, animated: true, completion: nil)
    }
    
    func dismissLoadingDialog() {
        loadingDialog.dismiss(animated: true, completion: nil)
    }
}
