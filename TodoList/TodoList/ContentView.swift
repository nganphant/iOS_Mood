//
//  ContentView.swift
//  TodoList
//
//  Created by Phan Thành Ngân on 2024/01/14.
//

import SwiftUI

//struct Todo : Identifiable {
//    let id = UUID()
//    let name: String
//    let category: String
//}

struct ContentView: View {
//    @State var isShowingMenu : Bool = false
    
    var body: some View {
        MainView()
//        AddTodoView(showAddTodoView: $isShowingMenu)
    }//end of body
    
    func onAdd_Clicked()  {
//        todos.append(Todo(name: "working", category: "network"))
    }
}

#Preview {
    ContentView()
}

struct AddTodoView : View {
    
    @Binding var showAddTodoView : Bool
    @Environment(\.managedObjectContext) private var viewContext

    @State var todoText : String = ""
    @State var selectedCategory = 0
    
    let pickerValues = ["network", "person", "wifi" ]
    
    var body: some View {
        VStack(){
            Text("Add Todo")
            TextField("Enter content", text: $todoText)
                .textFieldStyle(.roundedBorder)
                .border(Color.black)
            
            Text("Select Category")
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
            Picker("", selection: $selectedCategory) {
                
                //dynamic range
                ForEach(0 ..< pickerValues.count, id: \.self) {
                    Text(pickerValues[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
            Button("Done") {
                
                print("INPUT \($todoText)")
                
                showAddTodoView = false //view will be close due to binding
                
                let newTodoCD = TodoCD(context: viewContext)
                newTodoCD.name = todoText
                newTodoCD.category = pickerValues[selectedCategory]
                do{
                    try viewContext.save()
                }
                catch{
                    let error = error as NSError
                    fatalError("unresolved error:\(error)")
                }
//                todos.append(Todo(name: todoText, category: pickerValues[selectedCategory]))
            }
        }
        .padding()
    }
}

struct MainView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:[]) private var todosCD: FetchedResults<TodoCD>

    @State private var isShowingMenu = false
    
    var body: some View {
        NavigationView(){
            List(){
                
                ForEach(todosCD, id: \.self) { todo in
                    NavigationLink(
                        destination: {
                            VStack(){
                                Text("\(todo.name ?? "untitled")")
                                Image(systemName: todo.category ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                            }
                        },
                        label: {
                            HStack(){
                                Image(systemName: todo.category ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text("\(todo.name ?? "untitled")")
                            }
                        })
                    .onLongPressGesture {
                        updateTodo(todo: todo)
                    }
                    
                }
                
                .onDelete(perform: { indexSet in
                    deleteTodo(offsets: indexSet)
                })
//                .onMove(perform: { indices, newOffset in
//                    todosCD.move(fromOffsets: indices, toOffset: newOffset)
//                })
            }
            .navigationTitle("Todo Tasks")
            .navigationBarItems(leading: Button(action: {
                    isShowingMenu.toggle()
                }, label: {
                    Text("Add")
                }).sheet(isPresented: $isShowingMenu, content: {
                    AddTodoView(showAddTodoView: $isShowingMenu)
                }),
                trailing: EditButton())
            
        }
    }
    
    private func updateTodo(todo: TodoCD){
        todo.name = "💀"
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("unresolved error:\(error)")
        }
    }
    
    private func deleteTodo(offsets: IndexSet){
        for index in offsets{
            let todo = todosCD[index]
            viewContext.delete(todo)
        }
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("unresolved error:\(error)")
        }
    }
}
