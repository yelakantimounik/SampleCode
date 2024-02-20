//
//  SampleCodeTests.swift
//  SampleCodeTests
//
//  Created by Mounik Yelakanti on 2/19/24.
//

import XCTest
import Combine
@testable import SampleCode // Import your module where FlickrViewModel resides

class FlickrViewModelTests: XCTestCase {
    
    var viewModel: FlickrViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = FlickrViewModel()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testSearchImagesWithValidTag() {
        // Given
        let expectation = XCTestExpectation(description: "Images should be fetched")
        let tag = "nature" // or any other valid tag
        
        // When
        viewModel.searchImages(with: tag)
        
        // Then
        viewModel.$isLoading
            .dropFirst() // We may need to drop initial state, depends on your implementation
            .sink { isLoading in
                if !isLoading {
                    XCTAssertTrue(self.viewModel.images.count > 0)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5) // Adjust timeout as needed
    }
    
    func testSearchImagesWithInvalidTag() {
        // Given
        let expectation = XCTestExpectation(description: "Invalid tag, images should not be fetched")
        let tag = "invalidTag123"
        
        // When
        viewModel.searchImages(with: tag)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.images.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5) // Adjust timeout as needed
    }
}
