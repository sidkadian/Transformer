//
//  CreateVMTests.swift
//  TransformerTests
//
//  Created by Siddharth kadian on 17/02/21.
//

import XCTest
@testable import Transformer

class CreateVMTests: XCTestCase {

    var viewModel: CreateVM!
    var listItem: TransformerListItems!

    override func setUpWithError() throws {
        listItem = TransformerListItems(transformer: Transformer(courage: 1,
                                                                 endurance: 1, firepower: 1,
                                                                 id: "1", intelligence: 1,
                                                                 name: "A", rank: 1,
                                                                 skill: 1, speed: 1,
                                                                 strength: 1, team: "A",
                                                                 teamIcon: ""))
        viewModel = CreateVM(operation: .add, transformerData: listItem)

    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_team_changePickerData() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)

        viewModel.changePickerData(with: .team)

        XCTAssertEqual(viewModel.pickerArray.count, AppConstants.transformersValueArray.count)
    }

    func test_skill_changePickerData() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)

        viewModel.changePickerData(with: .skill)

        XCTAssertEqual(viewModel.pickerArray.count, AppConstants.skillsValueArray.count)
    }

    func test_edit_checkOperation() {
        viewModel = CreateVM(operation: .edit, transformerData: listItem)
        var result = false
        let expect = XCTestExpectation(description: "Expectation")
        viewModel.reloadDataClosure = { () in
            result = true
            expect.fulfill()
        }

        viewModel.checkOperation()
        wait(for: [expect], timeout: 1.0)

        XCTAssertTrue(result)
    }

    func test_editDecepticon_checkOperation() {
        listItem = TransformerListItems(transformer: Transformer(courage: 1, endurance: 1,
                                                                 firepower: 1, id: "1", intelligence: 1,
                                                                 name: "A", rank: 1,
                                                                 skill: 1, speed: 1,
                                                                 strength: 1, team: "D",
                                                                 teamIcon: ""))

        viewModel = CreateVM(operation: .edit, transformerData: listItem)
        var result = false
        let expect = XCTestExpectation(description: "Expectation")
        viewModel.reloadDataClosure = { () in
            result = true
            expect.fulfill()
        }

        viewModel.checkOperation()
        wait(for: [expect], timeout: 1.0)

        XCTAssertTrue(result)
    }

    func test_team_saveSkillsValue() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)
        viewModel.dataManager?.update(selectedIndex: 1, value: "q")
        viewModel.selectedRow = 1
        var finalIndex = 0
        let expect = XCTestExpectation(description: "Expectation")
        viewModel.reloadRowClosure = { (indexRow: Int) in
            finalIndex = indexRow
            expect.fulfill()
        }

        viewModel.saveSkillsValue()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalIndex, viewModel.selectedRow)
    }

    func test_otherSkill_saveSkillsValue() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)
        viewModel.dataManager?.update(selectedIndex: 4, value: 4)
        viewModel.selectedRow = 5
        var finalIndex = 0
        let expect = XCTestExpectation(description: "Expectation")
        viewModel.reloadRowClosure = { (indexRow: Int) in
            finalIndex = indexRow
            expect.fulfill()
        }

        viewModel.saveSkillsValue()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalIndex, viewModel.selectedRow)
    }

    func test_emptyName_validateTransformer() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)

        let result = viewModel.validateTransformer()

        XCTAssertFalse(result)
    }

    func test_emptyTeamType_validateTransformer() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)
        viewModel.dataManager?.update(dataType: .name, value: "A")
        let result = viewModel.validateTransformer()

        XCTAssertFalse(result)
    }

    func test_invalidSkillValue_validateTransformer() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)
        viewModel.dataManager?.update(dataType: .name, value: "A")
        viewModel.dataManager?.update(dataType: .team, value: "A")
        let result = viewModel.validateTransformer()

        XCTAssertFalse(result)
    }

    func test_validData_validateTransformer() {
        viewModel = CreateVM(operation: .add, transformerData: listItem)
        viewModel.dataManager?.update(dataType: .name, value: "A")
        viewModel.dataManager?.update(dataType: .team, value: "A")
        viewModel.dataManager?.update(selectedIndex: 9, value: 1)
        viewModel.dataManager?.update(selectedIndex: 8, value: 1)
        viewModel.dataManager?.update(selectedIndex: 7, value: 1)
        viewModel.dataManager?.update(selectedIndex: 6, value: 1)
        viewModel.dataManager?.update(selectedIndex: 5, value: 1)
        viewModel.dataManager?.update(selectedIndex: 4, value: 1)
        viewModel.dataManager?.update(selectedIndex: 3, value: 1)
        viewModel.dataManager?.update(selectedIndex: 2, value: 1)

        let result = viewModel.validateTransformer()

        XCTAssertTrue(result)
    }

}
