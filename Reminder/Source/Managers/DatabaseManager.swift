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
        CREATE TABLE IF NOT EXISTS prescriptions (
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
    
    func insertPrescription(_ prescription: Prescription) {
        let insertQuery = "INSERT INTO prescriptions (remedy, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if (sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, (prescription.remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (prescription.time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (prescription.recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (prescription.takeNow ? 1 : 0))
            
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
    
    func fetchPrescriptions() -> [Prescription] {
        let selectQuery = "SELECT id, remedy, time, recurrence, takeNow FROM prescriptions;"
        var statement: OpaquePointer?
        var prescriptions: [Prescription] = []
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy = String(cString: sqlite3_column_text(statement, 1))
                let time = String(cString: sqlite3_column_text(statement, 2))
                let recurrence = String(cString: sqlite3_column_text(statement, 3))
                let takeNow = sqlite3_column_int(statement, 4) == 1
                
                let prescription = Prescription(
                    id: id,
                    remedy: remedy,
                    time: time,
                    recurrence: recurrence,
                    takeNow: takeNow
                )
                
                prescriptions.append(prescription)
            }
            print("Buscou \(prescriptions.count) receitas com sucesso")
        } else {
            print("SELECT statement falhou")
        }
        
        sqlite3_finalize(statement)
        return prescriptions
    }
    
    func deleteReceipt(byId id: Int) {
        let deleteQuery = "DELETE FROM prescriptions WHERE id = ?;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Receita deletada")
            } else {
                print("Erro ao deletar a receita")
            }
        } else {
            print("Delete statement falhou")
        }
        sqlite3_finalize(statement)
    }
}
