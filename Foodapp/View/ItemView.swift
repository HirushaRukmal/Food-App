//
//  ItemView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-15.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        
        VStack{
            
            //Downloading images
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
            
            HStack(spacing: 8){
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
                //ratings
                ForEach(1...5, id: \.self){index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ?
                                         Color(.systemYellow): .gray)
                }
            }
            
            HStack{
                Text("$\(item.item_cost)")
                    .font(.caption)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

