//
//  PaymentView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI

struct PaymentView: View {
    @State private var paymentOption: PaymentOption = .card
    @State private var cardNumber = ""
    @State private var cardExpiration = ""
    @State private var cardCVV = ""
    @State private var redirectToHome = false
    @ObservedObject var homeData: HomeViewModel
    
    enum PaymentOption {
        case card
        case cashOnDelivery
    }
    
    var body: some View {
        Text("Payment Details")
            .fontWeight(.bold)
            .font(.title)
        
        VStack {
            RadioButton(
                id: .card,
                label: "Pay by Card",
                isSelected: paymentOption == .card,
                action: { paymentOption = .card }
            )
            
            if paymentOption == .card {
                VStack(spacing: 20) {
                    TextField("Card Number", text: $cardNumber)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    HStack {
                        TextField("Expiration Date", text: $cardExpiration)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        TextField("CVV", text: $cardCVV)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            
            RadioButton(
                id: .cashOnDelivery,
                label: "Cash on Delivery",
                isSelected: paymentOption == .cashOnDelivery,
                action: { paymentOption = .cashOnDelivery }
            )
            
            Spacer()
            
            HStack {
                Text("Total")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Calculating Total Price
                Text(homeData.calculateTotalPrice())
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding([.top, .horizontal])
            
            Button(action: {
                redirectToHome = true
            }) {
                Text("Place Order")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .onTapGesture {
                redirectToHome = true // Set the state variable to true to trigger the navigation
            }
            
            // Navigation link to the Home page
            NavigationLink(destination: Home(), isActive: $redirectToHome) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
    }
}

struct RadioButton: View {
    let id: PaymentView.PaymentOption
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                    .font(.title2)
                
                Text(label)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

