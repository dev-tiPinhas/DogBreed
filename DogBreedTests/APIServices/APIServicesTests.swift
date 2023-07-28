//
//  APIServicesTests.swift
//  DogBreedTests
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

@testable import DogBreed
import UIKit
import XCTest

class APIServicesTests: XCTestCase {
    
    private var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        
        apiService = APIService(urlSession: urlSession)
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func test_FetchAllBreeds_WithSuccess() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch All breeds completion")
        let data = JSONMockResponse.data(using: .utf8)
        mockRequestHandler(with: data)
        
        let stub = Breed.Stub.makeStub()
        
        // given
        
        apiService.fetchAllBreeds { result in
            guard let breeds = try? result.get(),
                  let breed = breeds.first else {
                XCTFail("Results Expected")
                expectation.fulfill()
                return
            }
            
            // then
            XCTAssertEqual(breed.name, stub.name)
            XCTAssertEqual(breed.id, stub.id)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchAllBreeds_PassingBreedToStub_WithSuccess() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch breeds completion")
        let data = JSONMockResponse.data(using: .utf8)
        mockRequestHandler(with: data)
        
        // given
        
        apiService.fetchAllBreeds { result in
            guard let breeds = try? result.get(),
                  let breed = breeds.last else {
                XCTFail("Results Expected")
                expectation.fulfill()
                return
            }
            
            let stub = Breed.Stub.makeStub(
                id: breed.id,
                name: breed.name,
                origin: breed.origin,
                temperament: breed.temperament,
                breedGroup: breed.breedGroup,
                bredFor: breed.bredFor,
                image: breed.image
            )
            
            // then
            XCTAssertEqual(breed.name, stub.name)
            XCTAssertEqual(breed.id, stub.id)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchBreeds_WithSuccess_NumberOfElements() {
        // when
        
        let limit: Int = 10
        let page: Int = 0
        let expectation = XCTestExpectation(description: "Fetch breeds completion")
        let data = JSONMockResponse.data(using: .utf8)
        mockRequestHandler(with: data)
        
        // given
        
        apiService.fetchDogBreeds(with: page, limit: limit) { result in
            guard let breeds = try? result.get() else {
                XCTFail("Results Expected")
                expectation.fulfill()
                return
            }
            
            // then
            XCTAssertNotEqual(breeds.count, limit) // only beacuse the mock data we have only have 1 element
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchAllBreeds_WithFaillure() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch all breeds completion")
        mockRequestHandler(with: Data())
        
        apiService.fetchAllBreeds { result in
            // then
            
            XCTAssertNil(try? result.get())
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchBreeds_WithParameters_WithFaillure() {
        // when
        
        let expectation = XCTestExpectation(description: "Fetch all breeds completion")
        mockRequestHandler(with: Data())
        
        // given
        
        apiService.fetchDogBreeds(with: 0, limit: 10) { result in
            
            // then
            XCTAssertNil(try? result.get())
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

// MARK: Private Functions

extension APIServicesTests {
    private func mockRequestHandler(with data: Data?) {
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw NSError(domain: "", code: -1)
            }
            
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, data)
        }
    }
}
