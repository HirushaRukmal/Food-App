//
//  FoodappTests.swift
//  FoodappTests
//
//  Created by Hirusha Rukmal on 2023-05-07.
//

import XCTest
@testable import Foodapp

final class FoodappTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHomeViewModelFilterData() {
        let viewModel = HomeViewModel()
        
        let item1 = Item(id: "1", item_name: "Pizza", item_cost: 10, item_details: "Delicious pizza", item_image: "pizza", item_ratings: "4.5")
        let item2 = Item(id: "2", item_name: "Burger", item_cost: 8, item_details: "Tasty burger", item_image: "burger", item_ratings: "4.0")
        let item3 = Item(id: "3", item_name: "Pasta", item_cost: 12, item_details: "Yummy pasta", item_image: "pasta", item_ratings: "4.2")
        
        viewModel.items = [item1, item2, item3]
        
        // Set the search keyword
        viewModel.search = "Pizza"
        
        // Call the filterData method
        viewModel.filterData()
        
        // Verify that the filtered array contains only the item matching the search keyword
        XCTAssertEqual(viewModel.filtered.count, 1)
        XCTAssertEqual(viewModel.filtered[0].item_name, "Pizza")
    }
}
