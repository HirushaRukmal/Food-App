//
//  ContentView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-05-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Welcome()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
