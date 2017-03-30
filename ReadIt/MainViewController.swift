//
//  MainViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 在读
        let readingNavController = UINavigationController(rootViewController: ReadingBookViewController())
        readingNavController.title = "在读"
        readingNavController.tabBarItem.image = UIImage(named: "main_tab_icon_reading")
        
        // 想读
        let willNavController = UINavigationController(rootViewController: WillViewController())
        willNavController.title = "想读"
        willNavController.tabBarItem.image = UIImage(named: "main_tab_icon_will")
        
        // 已读
        let readNavController = UINavigationController(rootViewController: ReadViewController())
        readNavController.title = "已读"
        readNavController.tabBarItem.image = UIImage(named: "main_tab_icon_read")
        
        viewControllers = [readingNavController, willNavController, readNavController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
