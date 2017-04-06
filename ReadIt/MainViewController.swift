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
        
        object_setClass(self.tabBar, CustomBottomBar.self)
        
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
        
        // 更多
        let moreNavController = UINavigationController(rootViewController: MoreViewController(style: .grouped))
        moreNavController.title = "更多"
        moreNavController.tabBarItem.image = UIImage(named: "main_tab_icon_more")

//        let emptyController = UIViewController()
        
        viewControllers = [readingNavController, willNavController, readNavController, moreNavController]
//        viewControllers = [readingNavController, willNavController, emptyController, readNavController, moreNavController]
        
        addGlobalAddButton()
    }
    
    let addView: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "ic_add_circle"), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
        return button
    }()
    
    func addGlobalAddButton() {
        self.tabBar.addSubview(addView)
        
        addView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        addView.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
//        addView.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor).isActive = true
        addView.rightAnchor.constraint(equalTo: self.tabBar.rightAnchor, constant: -12).isActive = true
        addView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -12).isActive = true
    }
    
    func onAddButtonClicked() {
        let searchViewController = SearchViewController(style: .plain)
        let navController = UINavigationController(rootViewController: searchViewController)
        present(navController, animated: true, completion: nil)
    }
}

// FIXME: - 不推荐使用自定义 UITabBar class

class CustomBottomBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if view == nil {
            for v in self.subviews {
                let p = self.convert(point, to: v)
                if v.point(inside: p, with: event) {
                    return v
                }
            }
        }
        
        return view
    }
}
