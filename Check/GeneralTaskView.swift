//
//  GeneralTaskView.swift
//  Check
//
//  Created by Chester de Wolfe on 2/18/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct GeneralTaskView: View {
    @State var task: GeneralTask
    @ObservedObject var tasks: Tasks
    @Binding var showTask: Bool
    var body: some View {
        Button (action: {
            var count = 0
            for task in self.tasks.allTasks {
                if task.id == self.task.id {
                    self.tasks.allTasks.remove(at: count)

                }
                count += 1
            }
            self.showTask.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200, height: 75)
                .foregroundColor(Color("newRed"))
                
                Text("Delete")
                    .foregroundColor(.white)
            }
        }
        
        
        
    }
}

/*struct GeneralTaskView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTaskView(task: GeneralTask(createdDate: Date(), level: 0, dueDate: Date(), name: "New Task", category: Category(createdDate: Date(), name: "New Category", description: "", color: "newRed"), description: ""), tasks: Tasks(), showTask: <#Bool#>)
    }
}*/
