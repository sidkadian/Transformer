//
//  CreateViewTableDataManagerTests.swift
//  TransformerTests
//
//  Created by Siddharth kadian on 17/02/21.
//

import XCTest
@testable import Transformer

class CreateViewTableDataManagerTests: XCTestCase {

    var dataManager: CreateViewTableDataManager!

    override func setUpWithError() throws {
        dataManager = CreateViewTableDataManager()
    }

    override func tearDownWithError() throws {
        dataManager = nil
    }

    func test_invalidCount_itemsCount() throws {
        guard let itemscount = dataManager?.itemsCount,
              itemscount > 0,
              let item = dataManager?.item(at: 0) else { return }

        XCTAssertNotNil(item)
    }

    func test_validName_updateWithDataType() throws {
        let newItem = "String"

        dataManager?.update(dataType: .name, value: newItem)

        XCTAssertEqual(newItem, dataManager?.getValueForItem(with: .name) as? String)
    }

    func test_validName_updateWithIndex() throws {
        let newItem = "String"

        dataManager?.update(selectedIndex: 0, value: newItem)

        XCTAssertEqual(newItem, dataManager?.getValueForItem(with: .name) as? String)
    }

    func test_invalidValues_validateSkillsContainsDefaultValue() throws {
        let newItem = "String"

        dataManager?.update(selectedIndex: 2, value: newItem)

        XCTAssertEqual(false, dataManager?.validateSkillsContainsDefaultValue())
    }

    func test_validValues_validateSkillsContainsDefaultValue() throws {
        let newItem = 5
        dataManager?.update(selectedIndex: 2, value: newItem)

        XCTAssertEqual(true, dataManager?.validateSkillsContainsDefaultValue())
    }

}
