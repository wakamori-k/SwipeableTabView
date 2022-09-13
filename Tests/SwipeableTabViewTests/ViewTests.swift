//
//  ViewTests.swift
//  
//
//  Created by Kazumasa Wakamori on 2022/09/13.
//

import XCTest
import SwiftUI
@testable import SwipeableTabView

final class ViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertTrue(EmptyView().isEmptyView)
        XCTAssertTrue(ForEach(0..<0, id: \.self) { _ in }.isEmptyView)
        XCTAssertTrue(ForEach([String](), id: \.self) { _ in }.isEmptyView)
    }

    func testExample_false() throws {
        XCTAssertFalse(Text("hoge").isEmptyView)
        XCTAssertFalse(ForEach(0..<1, id: \.self) { _ in }.isEmptyView)
        XCTAssertFalse(ForEach(["hoge"], id: \.self) { _ in }.isEmptyView)
    }
}
