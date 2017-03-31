//
//  DBManager.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/31.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import Foundation

class DBManager {
    
    var db: SQLiteConnect?
    
    static let sharedInstance: DBManager = {
        let manager = DBManager()
        return manager
    }()
    
    func open() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let sqlitePath = urls[urls.count - 1].absoluteString + "sqlite3.db"
        
        // file:///Users/heqingbao/Library/Developer/CoreSimulator/Devices/8724985C-0295-4FE9-809D-E9797454E2DE/data/Containers/Data/Application/CA080F82-EAF5-4805-AC4E-CB78865CA479/Documents/sqlite3.db
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        
        if let mydb = db {
            mydb.createTable(tableName: "books", columnsInfo: [
                "id integer primary key autoincrement",
                "isbn text",
                "title text",
                "pages integer",
                "author text",
                "pubdate text",
                "translator text",
                "image text",
                "publisher text",
                "authorIntro text",
                "summary text"])
        }
    }
    
    func insertBook(book: Book) -> Bool {
        if let mydb = db {
            return mydb.insert(tableName: "books",
                               rowInfo: [
                                "isbn": "'\(book.isbn!)'",
                                "title": "'\(book.title!)'",
                                "image": "'\(book.image!)'"])
        }
        return false
    }
}
