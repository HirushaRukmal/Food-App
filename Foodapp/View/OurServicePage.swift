//
//  OurServicePage.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI

struct OurServicesView: View {
    let imageNames = ["S0", "S1", "S2", "S3", "S4", "S5"]
    let titles = [
        "Restaurant Discovery",
        "Menu Browsing",
        "Ordering and Customization",
        "Online Payment",
        "Order Tracking",
        "Delivery or Pickup Options"
    ]
    let descriptions = [
        "The app allows users to discover various restaurants in their area. It provides information about the restaurant's cuisine type, menu, location, opening hours, and customer reviews.",
        "Users can browse the menus of different restaurants within the app. They can view the list of dishes offered, along with their descriptions, prices, and sometimes even nutritional information.",
        "Users can place their food orders directly through the app. They can select the desired dishes from the menu, customize their orders (e.g., specifying ingredients, toppings, or preparation preferences), and add items to their cart.",
        "The app facilitates online payment, allowing users to securely pay for their orders within the app. It supports various payment methods, such as credit/debit cards, digital wallets, or payment gateways like PayPal.",
        "After placing an order, users can track its status in real-time. They receive updates on the progress of their order, such as when it's confirmed, being prepared, or out for delivery. Some apps even provide estimated delivery times.",
        "Food ordering apps often offer multiple delivery options. Users can choose to have their food delivered to their doorstep or opt for self-pickup from the restaurant. Delivery options may include standard delivery, express delivery, or even third-party delivery services."
    ]
    
    var body: some View {
        VStack {
            Text("Our Services")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.orange)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<imageNames.count, id: \.self) { index in
                        VStack {
                            Image(imageNames[index])
                                .resizable()
                                .frame(height: 230)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            
                            Text(titles[index])
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Text(descriptions[index])
                                .font(.caption)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40)
                    }
                }
                .padding(.vertical)
            }
            
            Spacer()
        }
    }
}
