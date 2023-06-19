//
//  Item.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-15.
//

import SwiftUI
import FirebaseFirestore

struct Item: Identifiable {
    
    var id: String
    var item_name: String
    var item_cost: NSNumber
    var item_details: String
    var item_image: String
    var item_ratings: String
    
    var isAdded: Bool = false
}

