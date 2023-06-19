//
//  Home.swift
//  Foodapp
//
//  Created by Hirusha Rukmal on 2023-05-07.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    @State var index = 0
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing: 10){
                
                HStack(spacing:15){
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color(.systemOrange))
                    })
                    Text("Welcome")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text("Foodie")
                        .fontWeight(.heavy)
                        .foregroundColor(Color(.systemOrange))
                    
                    Spacer(minLength: 0)
                    
                    Image("App")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                        .aspectRatio(contentMode: .fit)
    
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $HomeModel.search)
                    
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                //Carousel List
                TabView(selection: self.$index){
                    
                    ForEach(0...5,id: \.self){index in
                        
                        Image("p\(index)")
                            .resizable()
                            .frame(height: 230)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .tag(index)
                    }
                    
                }
                .frame(height: 230)
                .padding(.top)
                .tabViewStyle(PageTabViewStyle())
                
                Text("HOT DEALS")
                    .foregroundColor(.orange)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .fontWeight(.bold)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 25){
                        ForEach(HomeModel.filtered){item in
                            //item view
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ItemView(item: item)
                                
                                HStack{
                                    
                                    Text("FREE DELIVERY")
                                        .foregroundColor(.white)
                                        .padding(.vertical,10)
                                        .padding(.horizontal)
                                        .background(Color(.orange))
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {
                                        HomeModel.addToCart(item: item)
                                        HomeModel.calculateTotalPrice()
                                    }) {
                                        Image(systemName: item.isAdded ? "checkmark" : "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(item.isAdded ? Color(.green) : Color(.orange))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.trailing,10)
                                .padding(.top,10)
                            })
                                .frame(width: UIScreen.main.bounds.width - 30)
                        }
                    }
                    .padding(.top,10)
                })
                
                
            }
            
            //side menu
            HStack{
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0: -UIScreen.main.bounds.width / 1.6 )
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity( HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
            .onTapGesture(perform: {
                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            })
        }
        .onAppear {
            HomeModel.fetchData()
        }
        .onChange(of: HomeModel.search, perform: {value in
            
            //avoid continous search
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                
                if value == HomeModel.search && HomeModel.search != ""{
                    //search data
                    HomeModel.filterData()
                }
            }
            
            if HomeModel.search == ""{
                //reset all data
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
            }
        })
        .navigationBarBackButtonHidden(true)
    }
}
