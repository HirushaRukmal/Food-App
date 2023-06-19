//
//  SpecialView.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-06-16.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestore

struct SpecialView: View {
    @State private var rating: Int = 0
    @State private var comments: String = ""
    @Environment(\.presentationMode) var present
    // Add other state properties as needed
    
    var body: some View {
        VStack {
            
            VStack{
                
                Text("Rate Our Service")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                // Rating picker
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                
                // Comments text field
                TextField("Comments", text: $comments)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 330, height: 150)
                
                
                // Add other UI elements as needed
                
                // Submit button
                Button(action: {
                    submitRatings()
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    func submitRatings() {
        let ratingData = Rating(rating: rating, comments: comments)
        
        // Convert the ratingData to JSON
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(ratingData) {
            // Convert JSON data to a dictionary
            if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                // Store the ratings data in Firebase
                let db = Firestore.firestore()
                db.collection("ratings").addDocument(data: jsonDict) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Rating added successfully")
                        // Perform any additional actions after successfully submitting the ratings
                    }
                }
            }
        }
        reset()
    }
    private func reset() {
        rating = 0
        comments = ""
    }
}
