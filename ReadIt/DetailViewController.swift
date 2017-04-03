//
//  DetailViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.bgColor
        
        self.title = book?.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(onMoreButtonClicked))
    }

    func onMoreButtonClicked() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "编辑", style: .default, handler: { (action) in
            self.onEditButtonClicked()
        }))
        sheet.addAction(UIAlertAction(title: "删除", style: .destructive, handler: { (action) in
            
            // 删除确认对话框
            let alert = UIAlertController(title: nil, message: "确定要删除吗？", preferredStyle: .alert)
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
        //
    }
}
