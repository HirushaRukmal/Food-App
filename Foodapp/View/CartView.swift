//
//  CartView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-15.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.presentationMode) var present
    @State private var redirectToPayment = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(homeData.cartItems) { cart in
                        // View items in cart
                        HStack(spacing: 15) {
                            WebImage(url: URL(string: cart.item.item_image))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(cart.item.item_name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                
                                
                                HStack(spacing: 15) {
                                    // Minus icon
                                    Button(action: {
                                        homeData.decreaseQuantity(item: cart.item)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .font(.system(size: 20, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("\(cart.quantity)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .frame(width: 30)
                                        .multilineTextAlignment(.center)
                                        .padding(.vertical, 5)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    
                                    // Plus icon
                                    Button(action: {
                                        homeData.increaseQuantity(item: cart.item)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .font(.system(size: 20, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                    
                                    // Delete icon
                                    Button(action: {
                                        homeData.removeFromCart(item: cart.item)
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.system(size: 20, weight: .heavy))
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            
            // Bottom view
            VStack {
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
                    redirectToPayment = true
                }) {
                    Text("Checkout")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .onTapGesture {
                    redirectToPayment = true // Set the state variable to true to trigger the navigation
                }
                
                // Navigation link to the payment page
                NavigationLink(destination: PaymentView(homeData: homeData), isActive: $redirectToPayment) {
                    EmptyView()
                }
                .hidden()
                
            }
            .background(Color.white)
        }
    }
}
