//
//  WillViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class WillViewController: UIViewController {
    
    var db: SQLiteConnect?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "想读"
        self.view.backgroundColor = Constants.bgColor
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let sqlitePath = urls[urls.count - 1].absoluteString + "sqlite3.db"
        
        // file:///Users/heqingbao/Library/Developer/CoreSimulator/Devices/8724985C-0295-4FE9-809D-E9797454E2DE/data/Containers/Data/Application/CA080F82-EAF5-4805-AC4E-CB78865CA479/Documents/sqlite3.db
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        
        if let mydb = db {
//            mydb.createTable(tableName: "students", columnsInfo: [
//                "id integer primary key autoincrement",
//                "name text",
//                "height double"])
            
            // insert
//            mydb.insert(tableName: "students", rowInfo: ["name": "'大强'", "height": "178"])

            // select
            let statement = mydb.fetch(tableName: "books", cond: "1 == 1", order: nil)
            while sqlite3_step(statement) == SQLITE_ROW {
                let isbn = sqlite3_column_text(statement, 1)
                let title = String(cString: sqlite3_column_text(statement, 2))
                let image = sqlite3_column_text(statement, 3)
                print("\(isbn). \(title) \(image)")
            }
            sqlite3_finalize(statement)
            
            // update
//            mydb.update(tableName: "students", cond: "id = 1", rowInfo: ["name": "'小强'", "height": "172"])
//            
//            // delete
//            mydb.delete(tableName: "students", cond: "id = 1")
        }
    }

}
