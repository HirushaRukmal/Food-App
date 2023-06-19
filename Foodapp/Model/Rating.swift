//
//  Rating.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI

struct Rating: Identifiable, Codable {
    let id = UUID()
    let rating: Int
    let comments: String
}
