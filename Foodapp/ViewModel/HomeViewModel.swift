//
//  HomeViewModel.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-05-07.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore

class HomeViewModel: NSObject,ObservableObject, CLLocationManagerDelegate{
    
    
    @Published var search = ""
    
    //Side menu
    @Published var showMenu = false
    
    //items
    @Published var items = [Item]()
    @Published var filtered = [Item]()
    
    //cart
    @Published var cartItems = [Cart]()
    
    //rating
    @Published var ratings = [Rating]()
    
    // Rating properties
    @Published var rating = 0
    @Published var comments = ""
    
    //Login anonymous
    func login(){
        Auth.auth().signInAnonymously{(res, err)in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res! .user.uid)")
            
            //fetch data
            self.login()
            self.fetchData()
        }
    }
    
    //Fetch Items
    func fetchData() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments{(snap,err)in
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({(doc) -> Item? in
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let details = doc.get("item_details") as! String
                let image = doc.get("item_image") as! String
                let ratings = doc.get("item_ratings") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
            
            self.filtered = self.items
        }
    }
    
    //Filter data
    func filterData(){
        
        withAnimation(.linear){
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    // Add to cart
    func addToCart(item: Item) {
        // Checking if it is added
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        // Updating filtered array
        self.filtered[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        if item.isAdded {
            // Removing from the cart
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
        } else {
            // Adding to the cart
            let cartItem = Cart(item: item, quantity: 1)
            self.cartItems.append(cartItem)
        }
    }
    
    // Remove from cart
    func removeFromCart(item: Item) {
        // Reset the isAdded property of the item
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = false
        
        // Update the filtered array
        self.filtered[getIndex(item: item, isCartIndex: false)].isAdded = false
        
        // Remove the item from the cart
        if let index = cartItems.firstIndex(where: { $0.item.id == item.id }) {
            cartItems.remove(at: index)
        }
    }
    
    // Decrease quantity of an item in the cart
    func decreaseQuantity(item: Item) {
        guard let index = cartItems.firstIndex(where: { $0.item.id == item.id }) else {
            return
        }
        
        if cartItems[index].quantity > 1 {
            cartItems[index].quantity -= 1
        } else {
            cartItems.remove(at: index)
        }
    }
    
    // Increase quantity of an item in the cart
    func increaseQuantity(item: Item) {
        guard let index = cartItems.firstIndex(where: { $0.item.id == item.id }) else {
            return
        }
        
        cartItems[index].quantity += 1
    }
    
    func getIndex(item: Item,isCartIndex: Bool)->Int{
        let index = self.items.firstIndex{(item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex{(item1) -> Bool in
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    // Calculate total price of the cart
    func calculateTotalPrice() -> String {
        var totalPrice: Float = 0
        
        cartItems.forEach { cartItem in
            let price = Float(truncating: cartItem.item.item_cost)
            totalPrice += price * Float(cartItem.quantity)
        }
        
        return getPrice(value: totalPrice)
    }
    
    func getPrice(value: Float)->String{
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
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
        reset ()
    }
    private func reset() {
        rating = 0
        comments = ""
    }
    

}
