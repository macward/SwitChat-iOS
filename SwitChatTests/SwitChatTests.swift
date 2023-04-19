//
//  SwitChatTests.swift
//  SwitChatTests
//
//  Created by Max Ward on 03/04/2023.
//

import XCTest
@testable import SwitChat

final class SwitChatTests: XCTestCase {
    
    private var repository: AuthenticateRepository!
    private var viewModel: SignInSignUpViewModel!
    
    override func setUpWithError() throws {
        repository = AuthRepositoryDefault(service: AuthenticateDataServiceDefault(dispatcher: RequestDispatcher(networkSession: NetworkSession())))
        viewModel = SignInSignUpViewModel(repository: repository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsCreated() {
        XCTAssertNotNil(viewModel)
    }
    
    func testCheckCredentials() {
        XCTAssertEqual(viewModel.email, "sample3@appchat.com")
        XCTAssertEqual(viewModel.password, "1234")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
