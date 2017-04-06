//
//  MoreViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/4/2.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    
    let backupCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "备份与恢复"
        return cell
    }()
    
    let settingCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "设置"
        return cell
    }()
    
    let aboutCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "关于"
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.bgColor
        self.title = "更多"
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            fatalError("Unknown number of sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.item {
            case 0:
                return backupCell
            case 1:
                return settingCell
            default:
                fatalError("Unknown row in section 0")
            }
        case 1:
            switch indexPath.item {
            case 0:
                return aboutCell
            default:
                fatalError("Unknown row in section 1")
            }
        default:
            fatalError("Unknown section")
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewController: UIViewController?
        switch indexPath.section {
        case 0:
            switch indexPath.item {
            case 0:
                viewController = BackupViewController()
            case 1:
                viewController = SettingsViewController(style: .grouped)
            default:
                fatalError("Unknown row in section 0")
            }
        case 1:
            viewController = AboutViewController()
        default:
            fatalError("Unknown number of sections")
        }
        
        guard (viewController != nil) else {
            return
        }
        
        viewController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

}
