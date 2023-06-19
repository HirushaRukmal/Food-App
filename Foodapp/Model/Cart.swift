//
//  Cart.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-15.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
