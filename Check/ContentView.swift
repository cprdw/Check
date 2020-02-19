//
//  ContentView.swift
//  Check
//
//  Created by Chester de Wolfe on 2/17/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var addSelected = false
    @State var showSettings = false
    @State var showMenu = false
    @ObservedObject var categories = Categories()
    @ObservedObject var tasks = Tasks()
    @State var showTask = false
    
    @State var currTask = GeneralTask(createdDate: Date(), level: 0, dueDate: Date(), name: "Homework 1", category: Category(createdDate: Date(), name: "Math", description: "", color: "newRed"), description: "des")

    

    
    var body: some View {
         //AddView(addSelected: self.$addSelected, categories: self.categories)
            NavigationView {
                       ZStack {
                        Color(.white)
                            .edgesIgnoringSafeArea(.all)

                        VStack(spacing: 0) {
                              
                                   

                                   
                                   ScrollView(.vertical, showsIndicators: false) {
                                       
                                       
                                       //HStack {
                                           VStack(spacing: 0) {
                                               
                                               
                                               ForEach(0 ..< self.categories.categories.count) { num in
                                                   cat(name: self.categories.categories[num].name, tasks: self.tasks.allTasks, showTask: self.$showTask, currTask: self.$currTask)
                                                       .padding(.bottom)
                                                       .padding(.top)
                                               }
                                               
                                              
                                           }
                                           //.offset(y: -100)

                                       //}
                                       
                                       
                                       
                                   }
                                   
                               
                            
                            HStack {
                                ZStack {
                                        Circle().fill(Color("newRed"))
                                        .frame(width: 35.0, height: 35.0)
                                        .shadow(color: Color("newRed"), radius: 2)
                                    
                                    Image(systemName: "line.horizontal.3.decrease")
                                    .resizable()
                                    .frame(width: 18, height: 14)
                                    .foregroundColor(.white)
                                }
                                .padding(.leading)
                                .contextMenu {
                                    
                                    Text("By Urgency")
                                        .onTapGesture {
                                            //urgency selected
                                    }
                                           
                                           
                                    NavigationLink(destination: GeneralTaskView(task: self.currTask, tasks: self.tasks, showTask: self.$showTask)) {
                                               Text("By Category")
                                               Image(systemName: "camera")
                                           }
                                           
                                }
                                
                                Spacer()
                                ZStack {
                                    NavigationLink(destination: AddView(tasks: self.tasks, categories: self.categories)) {                                        Circle().fill(Color("newRed"))
                                        .frame(width: 55.0, height: 55.0)
                                        .shadow(color: Color("newRed"), radius: 2)
                                    }
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    self.addSelected.toggle()
                                }
                                .contextMenu {
                                    
                                           NavigationLink(destination: ContentView()) {
                                               Text("Churches")
                                               Image(systemName: "c.circle")
                                           }
                                           
                                    NavigationLink(destination: GeneralTaskView(task: self.currTask, tasks: self.tasks, showTask: self.$showTask)) {
                                               Text("Marienplatz")
                                               Image(systemName: "camera")
                                           }
                                           
                                }
                                
                                Spacer()
                                ZStack {
                                    NavigationLink(destination: SettingsView()) {
                                        
                                        Circle().fill(Color("newRed"))
                                            .frame(width: 35.0, height: 35.0)
                                            .shadow(color: Color("newRed"), radius: 2)

                                    }
                                    
                                    Image(systemName: "gear")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing)
                            }
                            
                            }   // End of ContextMenu
                           .sheet(isPresented: self.$showTask) {
                            GeneralTaskView(task: self.currTask, tasks: self.tasks, showTask: self.$showTask)
                           }
                           
                           
                           
                       }
                        
                        .background(Color(.white))
                       .navigationBarItems(leading:
                        
                        
                            
                            
                            HStack {
                                
                                ZStack {
                                    Circle().fill(Color("newRed"))
                                        .frame(width: 40.0, height: 40.0)
                                        .fixedSize()
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.white)
                                }
                                .fixedSize()
                                
                                Text("Checklist")
                                    .foregroundColor(Color("newRed"))
                                    .font(.custom("Helvetica Neue", size: 45))
                                
                            }
                       
                        
                        //.frame(width: 500, height: 120)

                )
                
                
        }
            .onAppear(perform: {
                self.tasks.objectWillChange.send()

            })
            
            
            
            
            
        
            
        
        
        
        
    }

    
}
    
   


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct taskBar: View {
    let task: GeneralTask
    
    var body: some View {

           
           HStack {
            Color(task.category.color)
                   .frame(width: 15, height: 30)
                   .padding(.top)
                   .padding(.leading)
                .cornerRadius(20)
               VStack(alignment: .leading) {
                Text(task.name)
                       .padding(.top)
                    .foregroundColor(.black)
                Text(task.category.name)
                       .font(.caption)
                       .foregroundColor(.gray)
               }
               Spacer()
            if task.level == 3 {
                urgencyTag(color: "newRed", level: "Urgent")

            }
            if task.level == 2 {
                urgencyTag(color: "newOrange", level: "High")

            }
            if task.level == 1 {
                urgencyTag(color: "newTeal", level: "Medium")

            }
            if task.level == 0 {
                urgencyTag(color: "newGreen", level: "Low")

            }
            
               
           }
           
        }
           
    

       }
    
struct urgencyTag: View {
    let color: String
    let level: String
    var body: some View {
        
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .frame(width: 80, height: 28)
                .padding(.top)
                .foregroundColor(Color(color))
            Text(self.level)
                .foregroundColor(.white)
                .padding(.top)
        }
    }
}



struct cat: View {
    let name: String
    let tasks: [GeneralTask]
    @Binding var showTask: Bool
    @Binding var currTask: GeneralTask
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                /*Color("newRed")
                   .frame(width: 15, height: 30)*/
                Text(self.name)
                    .font(.title)
                    .foregroundColor(.black)
                    //.padding(.leading)
                Spacer()
               /* ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color("newRed"))
                        .frame(width: 45.0, height: 25.0)
                    Image(systemName: "ellipsis")
                    .resizable()
                        .frame(width: 25, height: 6)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    //self.addSelected.toggle()
                }*/
                
            }
            .padding(.leading)
            
            
            Divider()
                .accentColor(.black)
            
            ForEach(self.tasks, id: \.self.id) { task in
                    taskBar(task: task)
                    .onTapGesture {
                            self.showTask.toggle()
                            self.currTask = task
                    }

                
                
            }
            
        }
        
    }
}

class Tasks: ObservableObject {
    @Published var allTasks: [GeneralTask] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(allTasks) {
                UserDefaults.standard.set(encoded, forKey: "Tasks")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Tasks") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([GeneralTask].self, from: items) {
                self.allTasks = decoded
                return
            }
        }

        self.allTasks = [GeneralTask(createdDate: Date(), level: 0, dueDate: Date(), name: "Homework 1", category: Category(createdDate: Date(), name: "Math", description: "", color: "newRed"), description: "des")]
    }
    
}

class Categories: ObservableObject {
    @Published var categories: [Category] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(categories) {
                UserDefaults.standard.set(encoded, forKey: "Categories")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Categories") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Category].self, from: items) {
                self.categories = decoded
                return
            }
        }

        self.categories = [Category(createdDate: Date(), name: "General", description: "An example of a category you can use in the future", color: "newTeal"), Category(createdDate: Date(), name: "School", description: "Hold all of your school work and to do list items", color: "newRed"), Category(createdDate: Date(), name: "Family", description: "AAdd anything you need to get done with your family", color: "newBlue")]
    }
    
}
    
    

