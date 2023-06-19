//
//  RatingsScrollView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI

struct RatingsScrollView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.ratings) { rating in
                    VStack(alignment: .leading) {
                        Text("Rating: \(rating.rating)")
                            .font(.headline)
                        Text("Comment: \(rating.comment)")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
