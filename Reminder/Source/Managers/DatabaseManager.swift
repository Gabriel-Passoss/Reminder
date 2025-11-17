//
//  DatabaseManager.swift
//  Reminder
//
//  Created by Gabriel on 17/11/25.
//

import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Reminder.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Receipts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            remedy TEXT,
            time TEXT,
            recurrence TEXT,
            takeNow INTEGER
        );
        """
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabela criada com sucesso")
            } else {
                print("Erro ao criar tabela")
            }
        } else {
            print("CreateTable statement não conseguiu executar")
        }
        sqlite3_finalize(statement)
    }
    
    func insertReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        let insertQuery = "INSERT INTO Receipts (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita inserida com sucesso !")
            } else {
                print("Falha ao inserir receita na tabela")
            }
        } else {
            print("INSERT statement falhou")
        }
        sqlite3_finalize(statement)
    }
}
