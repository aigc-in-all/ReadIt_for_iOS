//
//  DetailViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var isbn: String?
    
    var book: Book?
    
    let btn1: UIButton = {
        let btn = UIButton(type: UIButtonType.roundedRect)
        btn.setTitle("开始阅读", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(onBtn1Clicked), for: .touchUpInside)
        return btn
    }()
    
    let btn2: UIButton = {
        let btn = UIButton(type: UIButtonType.roundedRect)
        btn.setTitle("读完了", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(onBtn2Clicked), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.bgColor
        
        book = BookModel.instance.query(isbn: isbn!)
        self.title = book?.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(onMoreButtonClicked))
        
        // add test buttons
        
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(v1)]-12-[v1]-12-|", options: NSLayoutFormatOptions.alignAllBottom, metrics: nil, views: ["v0": btn1, "v1": btn2]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0]", options: NSLayoutFormatOptions.alignAllBottom, metrics: nil, views: ["v0": btn1]))
    }

    func onMoreButtonClicked() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "编辑", style: .default, handler: { (action) in
            self.onEditButtonClicked()
        }))
        sheet.addAction(UIAlertAction(title: "删除", style: .destructive, handler: { (action) in
            
            // 删除确认对话框
            let alert = UIAlertController(title: nil, message: "确定要删除这本书吗？", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                self.onDeleteButtonClicked()
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        sheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(sheet, animated: true, completion: nil)
    }
    
    func onEditButtonClicked() {
        //
    }
    
    func onDeleteButtonClicked() {
        guard BookModel.instance.delete(isbn: isbn!) else {
            // delete fail
            return
        }
        
        // delete success
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - test 
    func onBtn1Clicked() {
        book?.readPages = String(Int((book?.pages!)!)! / 2)
        BookModel.instance.update(book: book!)
        self.navigationController?.popViewController(animated: true)
    }
    
    // 读完了
    func onBtn2Clicked() {
        book?.readPages = book?.pages
        BookModel.instance.update(book: book!)
        self.navigationController?.popViewController(animated: true)
    }
}
