//
//  SettingsViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/4/3.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    static let KEY_SHOW_PROGRESS_BY_PERCENTAGE = "show_progress_by_percentage"
    static let KEY_SHOW_BOOK_NUM_IN_APP_ICON = "show_book_num_in_app_icon"
    static let KEY_UPDATE_TO_LAST_PAGE_WHEN_COMPLETE = "upate_to_last_page_when_complete"

    let backupCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = "以百分比显示进度"
        
        let switcher = UISwitch()
        switcher.tag = 1
        switcher.isOn = UserDefaults.standard.bool(forKey: KEY_SHOW_PROGRESS_BY_PERCENTAGE)
        switcher.addTarget(self, action: #selector(onSwitcherValueChanged(_:)), for: UIControlEvents.valueChanged)
        cell.accessoryView = switcher
        return cell
    }()
    let iconCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = "应用图标中显示在读书籍数量"
        
        let switcher = UISwitch()
        switcher.tag = 2
        switcher.isOn = UserDefaults.standard.bool(forKey: KEY_SHOW_BOOK_NUM_IN_APP_ICON)
        switcher.addTarget(self, action: #selector(onSwitcherValueChanged(_:)), for: UIControlEvents.valueChanged)
        cell.accessoryView = switcher
        return cell
    }()
    let completeCell: UITableViewCell = {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = "完成阅读时进度更新到最后一页"
        
        let switcher = UISwitch()
        switcher.tag = 3
        switcher.isOn = UserDefaults.standard.bool(forKey: KEY_UPDATE_TO_LAST_PAGE_WHEN_COMPLETE)
        switcher.addTarget(self, action: #selector(onSwitcherValueChanged(_:)), for: UIControlEvents.valueChanged)
        cell.accessoryView = switcher
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = Constants.bgColor
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            return backupCell
        case 1:
            return iconCell
        case 2:
            return completeCell
        default:
            fatalError("Unknown row in section 0")
        }
    }
    
    // MARK: Custom method
    
    func onSwitcherValueChanged(_ switcher: UISwitch) {
        
        var key: String
        
        switch switcher.tag {
        case 1:
            key = SettingsViewController.KEY_SHOW_PROGRESS_BY_PERCENTAGE
        case 2:
            key = SettingsViewController.KEY_SHOW_BOOK_NUM_IN_APP_ICON
        case 3:
            key = SettingsViewController.KEY_UPDATE_TO_LAST_PAGE_WHEN_COMPLETE
        default:
            fatalError("Unknown tag in switcher")
        }
        
        UserDefaults.standard.set(switcher.isOn, forKey: key)
    }

}
