//
//  GeneralTask.swift
//  Check
//
//  Created by Chester de Wolfe on 2/17/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import Foundation

struct GeneralTask: Codable, Identifiable {
    let id = UUID()
    let createdDate: Date
    let level: Int
    let dueDate: Date
    let name: String
    let category: Category 
    let description: String

}

