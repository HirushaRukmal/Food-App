//
//  Menu.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-15.
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        
        VStack(spacing: 20){
            HStack(spacing: 10){
                Text("FOODIE")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            
            NavigationLink(destination: CartView(homeData: homeData)){
                HStack(spacing: 10){
                    Image(systemName: "cart")
                        .padding(10)
                        .font(.title)
                        .foregroundColor(Color(.systemOrange))
                    
                    Text("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
            }
            NavigationLink(destination: SpecialView()){
                HStack(spacing: 10){
                    Image(systemName: "star.fill")
                        .padding(10)
                        .font(.title)
                        .foregroundColor(Color(.systemOrange))
                    
                    Text("Ratings")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
            }
            NavigationLink(destination: OurServicesView()){
                HStack(spacing: 10){
                    Image(systemName: "server.rack")
                        .padding(10)
                        .font(.title)
                        .foregroundColor(Color(.systemOrange))
                    
                    Text("Our Service")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
            }
            
            Spacer()
            
            HStack{
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color(.systemOrange))
            }
            .padding(10)
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea() )
    }
}
