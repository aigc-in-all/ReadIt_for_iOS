//
//  SQLiteConnect.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/31.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

class SQLiteConnect {
    
    var db: OpaquePointer?
    let sqlitePath: String
    
    init(path: String) {
        sqlitePath = path
        db = self.openDatabase(path: sqlitePath)
    }
    
    func openDatabase(path: String) -> OpaquePointer? {
        var connectdb: OpaquePointer?
        if sqlite3_open(path, &connectdb) == SQLITE_OK {
            print("Successfully opened database \(path)")
            return connectdb
        } else {
            print("Unable to open database.")
            return nil
        }
    }
    
    @discardableResult func createTable(tableName: String, columnsInfo: [String]) -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnsInfo.joined(separator: ",")))"
        if sqlite3_exec(self.db, sql.cString(using: .utf8), nil, nil, nil) == SQLITE_OK {
            return true
        }
        
        return false
    }
    
    @discardableResult func insert(tableName: String, rowInfo: [String: String]) -> Bool {
        var statement: OpaquePointer?
        let sql = "INSERT INTO \(tableName) "
            + "(\(rowInfo.keys.joined(separator: ","))) "
            + "VALUES"
            + "(\(rowInfo.values.joined(separator: ",")))"
        print("\(sql)")
        if sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("插入成功")
                return true
            }
            sqlite3_finalize(statement)
        } else {
            print("插入失败")
        }
        return false
    }
    
    func fetch(tableName: String, cond: String?, order: String?) -> OpaquePointer? {
        var statement: OpaquePointer?
        var sql = "SELECT * FROM \(tableName)"
        if let condition = cond {
            sql += " WHERE \(condition)"
        }
        
        if let orderBy = order {
            sql += " ORDER BY \(orderBy)"
        }
        
        sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil)
        
        return statement
    }
    
    @discardableResult func update(tableName: String, cond: String?, rowInfo: [String: String]) -> Bool {
        var statement: OpaquePointer?
        var sql = "UPDATE \(tableName) SET "
        
        // row info
        var info = [String]()
        for (k, v) in rowInfo {
            info.append("\(k) = \(v)")
        }
        sql += info.joined(separator: ",")
        
        // condition
        if let condition = cond {
            sql += " WHERE \(condition)"
        }
        
        if sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                return true
            }
            sqlite3_finalize(statement)
        }
        
        return false
    }
    
    @discardableResult func delete(tableName: String, cond: String?) -> Bool {
        var statement: OpaquePointer?
        var sql = "DELETE FROM \(tableName)"
        
        // condition
        if let condition = cond {
            sql += " WHERE \(condition)"
        }
        
        if sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                return true
            }
            sqlite3_finalize(statement)
        }
        
        return false
    }
}
