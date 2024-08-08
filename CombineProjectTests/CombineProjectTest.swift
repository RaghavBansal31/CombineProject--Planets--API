//
//  CombineProjectTest.swift
//  CombineProjectTests
//
//  Created by Consultant on 8/1/23.
//

import XCTest
@testable import CombineProject
final class CombineProjectTest: XCTestCase {
    
    var userViewModel: UserViewModel!
    var planetView: PlanetView!

    
     override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userViewModel = UserViewModel(networkManager: FakeNetworkManager())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userViewModel = nil
    }

     func testfuncTestForAPI() throws {
        userViewModel.getProductsFromAPI(urlString: "planets")
        let expect = XCTestExpectation(description: "This is API fetching data")
         let waitDuration = 1.0
         DispatchQueue.main.async {
             XCTAssertNotNil(self.userViewModel)
             XCTAssertEqual(self.userViewModel.result.count, 10)
             XCTAssertNil(self.userViewModel.customError)
             expect.fulfill()
         }
         wait(for: [expect], timeout: waitDuration)
      
    }
    
    func testfuncTestForAPIError() throws {
       userViewModel.getProductsFromAPI(urlString: "API.UserAPI" )
       let expect = XCTestExpectation(description: "This is API fetching data")
        let waitDuration = 2.0
        DispatchQueue.main.async{
            XCTAssertNotNil(self.userViewModel)
            XCTAssertEqual(self.userViewModel.result.count, 0)
            XCTAssertNotNil(self.userViewModel.customError)
            expect.fulfill()
        }
        wait(for: [expect], timeout: waitDuration)
     
   }
    
   
    
   
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
