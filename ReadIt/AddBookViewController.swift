//
//  AddViewController.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.bgColor
        self.title = "添加书籍"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(onCancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(onSaveButtonClicked))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom actions
    
    func onCancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSaveButtonClicked() {
        //
    }

}
