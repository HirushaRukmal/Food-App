//
//  Welcome.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI

struct Welcome: View {
    @State private var redirectToHome = false
    @State private var showLoading = true
    
    var body: some View {
        VStack(alignment: .center){
            Image("App")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            Text("FOOIDE")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.orange)
            
            
            if showLoading {
                ProgressView() // Display the loading bar
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                redirectToHome = true
            }
        }
        .background(
            NavigationLink(destination: Home(), isActive: $redirectToHome) {
                EmptyView()
            }
                .hidden()
        )
    }
}

