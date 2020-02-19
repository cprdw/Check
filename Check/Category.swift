//
//  Category.swift
//  Check
//
//  Created by Chester de Wolfe on 2/17/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import Foundation

struct Category: Codable, Identifiable {
    let id = UUID()
    let createdDate: Date
    let name: String
    let description: String
    let color: String

}
