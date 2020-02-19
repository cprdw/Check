//
//  AddView.swift
//  Check
//
//  Created by Chester de Wolfe on 2/17/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State var taskName = "New Task"
    @State var description = "New Task"

    @State var categorySelected = "General"
    @State var level = 0
    @ObservedObject var tasks: Tasks
    @ObservedObject var categories: Categories
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        bigTaskBar(task: GeneralTask(createdDate: Date(), level: self.level, dueDate: Date(), name: taskName, category: Category(createdDate: Date(), name: self.categorySelected, description: "", color: "newBlue"), description: ""), name: self.categorySelected)
                            .padding(.trailing)
                        HStack {
                            Text("Due Date: ")
                            Text("Mon, 17 ")
                        }
                        Spacer(minLength: 50)
                        //Spacer()
                                    TextField("New Task", text: $taskName)
                                    .padding(.leading)
                                    .foregroundColor(Color("newRed"))
                                    Divider()
                                        .background(Color("newRed"))
                                    Picker("Section: ", selection: $categorySelected) {
                                            ForEach(0 ..< self.categories.categories.count) {
                                                Text(self.categories.categories[$0].name)
                                            }
                                        }
                                    .pickerStyle(DefaultPickerStyle())
                                        .foregroundColor(Color("newRed"))
                                        .padding(.leading)
                                    
                                
                            
                        
                        

                        
                        HStack {
                                urgencyTag(color: "newRed", level: "Urgent")
                                    .onTapGesture {
                                        self.level = 3
                            }

                                urgencyTag(color: "newOrange", level: "High")
                            .onTapGesture {
                                        self.level = 2
                            }

                                urgencyTag(color: "newTeal", level: "Medium")
                            .onTapGesture {
                                        self.level = 1
                            }

                                urgencyTag(color: "newGreen", level: "Low")
                            .onTapGesture {
                                        self.level = 0
                            }
                            
                        }
                        Spacer()
                        ZStack {
                            
                        RoundedRectangle(cornerRadius: 20)
                        .frame(width: 120, height: 50)
                            .padding(.top)
                            .foregroundColor(Color("newRed"))
                        Text("Save")
                            .foregroundColor(.white)
                            .padding(.top)
                        }
                        .onTapGesture {
                            let finalCat = self.getCat(val: self.categorySelected, cats: self.categories.categories)
                            self.tasks.objectWillChange.send()

                            
                            
                            self.tasks.allTasks.append(GeneralTask(createdDate: Date(), level: self.level, dueDate: Date(), name: self.taskName, category: finalCat, description: self.description))
                            for task in self.tasks.allTasks {
                                print(task.name)
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    func getCat(val: String, cats: [Category]) -> Category {
        var cat = Category(createdDate: Date(), name: "New", description: "", color: "newBlue")
        for category in cats {
            if category.name == val {
                cat = category
            }
        }
        
        return cat
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(tasks: Tasks(), categories: Categories())
    }
}
struct bigTaskBar: View {
let task: GeneralTask
    let name: String
var body: some View {

       
       HStack {
        Color(task.category.color)
               .frame(width: 25, height: 50)
               .padding(.top)
               .padding(.leading)
            .cornerRadius(20)
           VStack(alignment: .leading) {
            Text(task.name)
                   .padding(.top)
                .foregroundColor(.black)
                .font(.largeTitle)
            Text(name)
                   .font(.title)
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
