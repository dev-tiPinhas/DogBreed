//
//  ImageFetcherTests.swift
//  DogBreedTests
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

@testable import DogBreed
import UIKit
import XCTest

class ImageFetcherTests: XCTestCase {
    
    private var imageFetcher: ImageFetcher!
    
    override func setUp() {
        super.setUp()
        imageFetcher = ImageFetcher()
    }
    
    override func tearDown() {
        imageFetcher = nil
        super.tearDown()
    }
    
    func test_FetchImage_WithSuccess() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch image completion")
        let url = URL(string: "https://fjwp.s3.amazonaws.com/blog/wp-content/uploads/2022/10/19070942/TED-Talk-What-Is-YOUR-Definition-of-Success-1024x512.jpg")
        
        // given
        
        imageFetcher.fetchImage(with: url!, cacheKey: nil) { image in
            // then
            
            XCTAssertNotNil(try? image.get())
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchImage_Withfailure() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch image completion")
        let url = URL(string: "not_great_success")
        
        // given
        
        imageFetcher.fetchImage(with: url!, cacheKey: nil) { image in
            // then
            
            XCTAssertNil(try? image.get())
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
