//
//  TodoListApp.swift
//  TodoList
//
//  Created by Phan Thành Ngân on 2024/01/14.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    let persistentContainer = PersistentController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,
                                       persistentContainer.container.viewContext)
        }
    }
}
