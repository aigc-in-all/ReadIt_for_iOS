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
    }

}
