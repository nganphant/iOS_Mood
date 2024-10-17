//
//  Persistence.swift
//  TodoList
//
//  Created by Phan Thành Ngân on 2024/02/08.
//

import Foundation
import CoreData

struct PersistentController {
    static let shared = PersistentController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Todo")//database name
        container.loadPersistentStores { storeDesc, error in
            if let error = error as NSError? {
                fatalError("unresolved error:\(error)")
            }
            
            
        }
    }
}
