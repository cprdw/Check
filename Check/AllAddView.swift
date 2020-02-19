//
//  AllAddView.swift
//  Check
//
//  Created by Chester de Wolfe on 2/18/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct AllAddView: View {
    @ObservedObject var categories: Categories

    var body: some View {
        TabView {
            //AddView(tasks: , categories: self.categories)
             //   .tabItem {
                    Text("Task")
            //}
        }
    }
}

struct AllAddView_Previews: PreviewProvider {
    static var previews: some View {
        AllAddView(categories: Categories())
    }
}
