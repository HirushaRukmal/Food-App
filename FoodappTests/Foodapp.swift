//
//  Foodapp.swift
//  FoodappTests
//
//  Created by Hirusha Rukmal on 2023-06-17.
//

import XCTest
import Firebase
import FirebaseFirestore
@testable import Foodapp

class Foodapp: XCTestCase {

    var homeViewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        homeViewModel = HomeViewModel()
    }

    override func tearDown() {
        homeViewModel = nil
        super.tearDown()
    }

    func testFetchData() {
        let expectation = XCTestExpectation(description: "Fetch data from Firestore")

        
        homeViewModel.fetchData()

        let db = Firestore.firestore()
        db.collection("Items").addSnapshotListener { snapshot, error in
            // Check if the snapshot is not nil
            XCTAssertNotNil(snapshot, "Snapshot should not be nil")

            // Check if there are documents in the snapshot
            if let documents = snapshot?.documents {
                // Ensure the fetched items count matches the snapshot's document count
                XCTAssertEqual(self.homeViewModel.items.count, documents.count, "Fetched items count should match snapshot's document count")
            }

            // Fulfill the expectation to indicate that the async operation is complete
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled with a timeout
        wait(for: [expectation], timeout: 5.0)
    }
}
