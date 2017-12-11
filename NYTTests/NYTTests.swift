//
//  NYTTests.swift
//  NYTTests
//
//  Created by Madhur Mohta on 10/12/2017.
//

import XCTest
@testable import NYT

class NYTTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testFetchArticles() {
        
        let serviceExpectation: XCTestExpectation =
            XCTestExpectation.init(description: "serviceExpectation")
        
        ArticleDataProvider.fetchArticles { (base) in
            XCTAssertNotNil(base, "Empty Response")
            serviceExpectation.fulfill()
        }
        
        self.wait(for: [serviceExpectation], timeout: 3.0)
    }
    
    func testInvalidURLRequest() {
        let invalidString = ""
        let urlRequest = NYTServiceManager.getURLRequest(invalidString)
        XCTAssertNil(urlRequest, "URL Request not empty")
    }
    
    func testValidURLRequest() {
        let validString = "www.google.com"
        let urlRequest = NYTServiceManager.getURLRequest(validString)
        XCTAssertNotNil(urlRequest, "Empty URL Request")
    }

    func testInvalidFetchImage() {
        
        let fetchImageExpectation: XCTestExpectation =
            XCTestExpectation.init(description: "fetchImageExpectation")

        let invalidURL = ""
        NYTUtilities.fetchImage(url: invalidURL) { (image) in
            XCTAssertNil(image, "image not empty")
            fetchImageExpectation.fulfill()
        }
        self.wait(for: [fetchImageExpectation], timeout: 61.0)
    }
    
    func testFetchImage() {
        
        let fetchImageExpectation: XCTestExpectation =
            XCTestExpectation.init(description: "fetchImageExpectation")
        
        let validURL = "https://static01.nyt.com/images/2017/12/01/business/01DB-CVS2/merlin_130711665_8cd7d500-e092-4328-8bd8-58761fcfbdb5-thumbStandard.jpg"
        NYTUtilities.fetchImage(url: validURL) { (image) in
            XCTAssertNotNil(image, "image empty")
            fetchImageExpectation.fulfill()
        }
        self.wait(for: [fetchImageExpectation], timeout: 61.0)
    }
    
    func testInvalidModelParsing() {
        
        let string = ""
        
        let base = ArticleDataProvider.getParsedModel(responseData: Data(string.utf8))
        XCTAssertNil(base, "Base not empty")
    }
    
    func testValidModelParsing() {
        
        var base : Base?
        if let filepath = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                base = ArticleDataProvider.getParsedModel(responseData: Data(contents.utf8))
                XCTAssertNotNil(base, "Base empty")

            } catch {
                XCTAssertNotNil(base, "Fetching data error")
            }
        } else {
            XCTAssertNotNil(base, "File not found")
        }
        
    }

    func testParsingTime() {
        
        var base : Base?
        //expect
        let parseExpectation:XCTestExpectation =
            XCTestExpectation.init(description: "parseExpectation")
        
        self.measure {
            
            if let filepath = Bundle.main.path(forResource: "data", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    print(contents)
                    base = ArticleDataProvider.getParsedModel(responseData: Data(contents.utf8))
                    XCTAssertNotNil(base, "Base empty")
                    parseExpectation.fulfill()
                    
                } catch {
                    XCTAssertNotNil(base, "Fetching data error")
                }
            } else {
                XCTAssertNotNil(base, "File not found")
            }
        }
        //wait
        self.wait(for: [parseExpectation], timeout: 3.0)
    }
    
    
}
