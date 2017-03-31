//
//  AddViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    let editBox: UITextField = {
        let box = UITextField()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.borderStyle = .roundedRect
        box.clearButtonMode = .whileEditing
        box.keyboardType = .numberPad
        box.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        box.placeholder = "请输入ISBN"
        box.text = "9787201094014"
        return box
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.bgColor
        self.title = "添加书籍"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onSaveButtonClicked))
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.view.addSubview(editBox)
        
        editBox.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        editBox.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        editBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        editBox.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    // MARK: - Custom actions
    
    func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSaveButtonClicked() {
        let url = "https://api.douban.com/v2/book/isbn/:\(editBox.text!)"
        HttpManager.sharedInstance.getRequest(urlString: url, params: nil, success: { (response) in
            let book = Book(JSON: response)
            print("\(book?.image). \(book?.isbn). \(book?.title). \(book?.author)")
            if let mybook = book {
                DBManager.sharedInstance.insertBook(book: mybook)
            }
            
        }) { (error) in
            //
        }
    }
    
    func textFieldDidChanged() {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(editBox.text?.isEmpty)!
    }

}
