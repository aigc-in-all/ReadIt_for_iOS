//
//  BaseDao.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/4.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

class BaseDao {
    
    var db: OpaquePointer?
    
    init() {
        db = SQLiteManager.instance.db
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
        
        print("\(sql)")
        
        sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil)
        
        return statement
    }
    
    func insert(tableName: String, rowInfo: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let sql = "INSERT INTO \(tableName) "
                    + "(\(rowInfo.keys.joined(separator: ", ")))"
                    + " VALUES "
                    + "(\"\(rowInfo.values.joined(separator: "\", \""))\")"
        let resultCode = sqlite3_prepare_v2(self.db, sql, -1, &stmt, nil)
        if resultCode == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("执行 [插入] 成功")
                return true
            }
            sqlite3_finalize(stmt)
        }
        
        print("执行 [插入] 失败, sql=\(sql), resultCode=\(resultCode), errmsg=\(String(cString: sqlite3_errmsg(self.db)))")
        return false
    }
    
    func delete(tableName: String, cond: String?) -> Bool {
        var stmt: OpaquePointer?
        var sql = "DELETE FROM \(tableName)"
        
        // condition
        if let condition = cond {
            sql += " WHERE \(condition)"
        }
        
        if sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                return true
            }
            sqlite3_finalize(stmt)
        }
        
        return false
    }
    
    func update(tableName: String, cond: String?, rowInfo: [String: String]) -> Bool {
        var statement: OpaquePointer?
        var sql = "UPDATE \(tableName) SET "
        
        // row info
        var info = [String]()
        for (k, v) in rowInfo {
            info.append("\(k) = \"\(v)\"")
        }
        sql += info.joined(separator: ", ")
        
        // condition
        if let condition = cond {
            sql += " WHERE \(condition)"
        }
        
        print("\(sql)")
        
        if sqlite3_prepare_v2(self.db, sql.cString(using: .utf8), -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("更新成功")
                return true
            }
            sqlite3_finalize(statement)
        }
        
        print("更新失败 errmsg=\(String(cString: sqlite3_errmsg(self.db)))")
        return false
    }
}
