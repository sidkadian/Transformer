//
//  BattlefieldVMTests.swift
//  TransformerTests
//
//  Created by Siddharth kadian on 17/02/21.
//

import XCTest
@testable import Transformer

class BattlefieldVMTests: XCTestCase {

    var dataManager: BattlefieldVM!
    var expectation: XCTestExpectation!
    var results: Bool!

    override func setUpWithError() throws {
        dataManager = BattlefieldVM(delegate: self)
    }

    override func tearDownWithError() throws {
        dataManager = nil
        expectation = nil
        results = nil
    }

    func test_countSame_prepareBattleData() {
        // Arrange //Data
        dataManager.autobot = [Transformer(courage: 1, endurance: 1,
                                           firepower: 1, id: "1", intelligence: 1,
                                           name: "A", rank: 1, skill: 1,
                                           speed: 1, strength: 1,
                                           team: "A", teamIcon: "")]
        dataManager.decepticon = [Transformer(courage: 1, endurance: 1,
                                              firepower: 1, id: "11",
                                              intelligence: 1, name: "B",
                                              rank: 1, skill: 1,
                                              speed: 1, strength: 1,
                                              team: "D", teamIcon: "")]

        expectation = expectation(description: "expectation")
        dataManager.delegate = self

        // Act //Calls
        dataManager.prepareBattleData()
        waitForExpectations(timeout: 1.0)

        // Assert //Checks
        XCTAssertEqual(self.results, true)
    }

    func test_emptyAutobot_prepareBattleData() {
        // Arrange //Data
        dataManager.autobot = []
        dataManager.decepticon = [Transformer(courage: 1, endurance: 1,
                                              firepower: 1, id: "11",
                                              intelligence: 1, name: "B",
                                              rank: 1, skill: 1,
                                              speed: 1, strength: 1,
                                              team: "D", teamIcon: "")]

        expectation = expectation(description: "expectation")
        dataManager.delegate = self

        // Act //Calls
        dataManager.prepareBattleData()
        waitForExpectations(timeout: 1.0)

        // Assert //Checks
        XCTAssertEqual(self.results, true)
    }

    func test_emptyDecepticon_prepareBattleData() {
        // Arrange //Data
        dataManager.autobot = [Transformer(courage: 1, endurance: 1,
                                           firepower: 1, id: "1",
                                           intelligence: 1, name: "A",
                                           rank: 1, skill: 1,
                                           speed: 1, strength: 1,
                                           team: "A", teamIcon: "")]
        dataManager.decepticon = []

        expectation = expectation(description: "expectation")
        dataManager.delegate = self

        // Act //Calls
        dataManager.prepareBattleData()
        waitForExpectations(timeout: 1.0)

        // Assert //Checks
        XCTAssertEqual(self.results, true)
    }

    func test_extraCountAutobots_prepareBattleData() {
        // Arrange //Data
        dataManager.autobot = [Transformer(courage: 1, endurance: 1,
                                           firepower: 1, id: "1",
                                           intelligence: 1, name: "A",
                                           rank: 1, skill: 1, speed: 1,
                                           strength: 1, team: "A", teamIcon: ""),
                               Transformer(courage: 1, endurance: 1, firepower: 1,
                                           id: "11", intelligence: 1, name: "AA",
                                           rank: 1, skill: 1, speed: 1,
                                           strength: 1, team: "A", teamIcon: "")]
        dataManager.decepticon = [Transformer(courage: 1, endurance: 1, firepower: 1,
                                              id: "2", intelligence: 1, name: "B",
                                              rank: 1, skill: 1, speed: 1,
                                              strength: 1, team: "D", teamIcon: "")]

        expectation = expectation(description: "expectation")
        dataManager.delegate = self

        // Act //Calls
        dataManager.prepareBattleData()
        waitForExpectations(timeout: 1.0)

        // Assert //Checks
        XCTAssertEqual(self.results, true)
    }

    func test_extraCountDecepticon_prepareBattleData() {
        // Arrange //Data
        dataManager.autobot = [Transformer(courage: 1, endurance: 1, firepower: 1,
                                           id: "1", intelligence: 1, name: "A",
                                           rank: 1, skill: 1, speed: 1,
                                           strength: 1, team: "A", teamIcon: "")]
        dataManager.decepticon = [Transformer(courage: 1, endurance: 1, firepower: 1,
                                              id: "2", intelligence: 1, name: "B",
                                              rank: 1, skill: 1, speed: 1, strength: 1,
                                              team: "D", teamIcon: ""),
                                  Transformer(courage: 1, endurance: 1, firepower: 1,
                                              id: "22", intelligence: 1, name: "BB",
                                              rank: 1, skill: 1, speed: 1, strength: 1, team: "D", teamIcon: "")]

        expectation = expectation(description: "expectation")
        dataManager.delegate = self

        // Act //Calls
        dataManager.prepareBattleData()
        waitForExpectations(timeout: 1.0)

        // Assert //Checks
        XCTAssertEqual(self.results, true)
    }

    func test_predakingDecepticon_validateBattleRules() {
        // Arrange //Data
        let autobot = Transformer(courage: 1, endurance: 1, firepower: 1,
                                  id: "1", intelligence: 1, name: "A",
                                  rank: 1, skill: 1, speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1,
                                     id: "2", intelligence: 1, name: "Predaking", rank: 1,
                                     skill: 1, speed: 1, strength: 1, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateBattleRules(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.decepticon)
    }

    func test_predakingOptimus_validateBattleRules() {
        // Arrange //Data
        let autobot = Transformer(courage: 1, endurance: 1, firepower: 1,
                                  id: "1", intelligence: 1, name: "Optimus Prime", rank: 1,
                                  skill: 1, speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "Predaking", rank: 1, skill: 1,
                                     speed: 1, strength: 1, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateBattleRules(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.destroyed)
    }

    func test_optimusAutobots_validateBattleRules() {
        // Arrange //Data
        let autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "Optimus Prime", rank: 1,
                                  skill: 1, speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 1,
                                     speed: 1, strength: 1, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateBattleRules(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.autobot)
    }

    func test_decepticon_validateSecondRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 1,
                                  speed: 1, strength: 7, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 7, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 1,
                                     speed: 1, strength: 1, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateSecondRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.decepticon)
    }

    func test_autobot_validateSecondRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 7, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 1,
                                  speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 1,
                                     speed: 1, strength: 7, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateSecondRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.autobot)
    }

    func test_decepticon_validateThirdRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 7, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 1,
                                  speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 7,
                                     speed: 1, strength: 7, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateThirdRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.decepticon)
    }

    func test_autobot_validateThirdRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 7, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 7,
                                  speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 1,
                                     speed: 1, strength: 7, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateThirdRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.autobot)
    }

    func test_autobot_validateForthRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 7, endurance: 1, firepower: 4, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 7,
                                  speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 1, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 1,
                                     speed: 1, strength: 1, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateForthRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.autobot)
    }

    func test_decepticon_validateForthRule() {
        // Arrange //Data
        let autobot = Transformer(courage: 7, endurance: 1, firepower: 1, id: "1",
                                  intelligence: 1, name: "O", rank: 1, skill: 1,
                                  speed: 1, strength: 1, team: "A", teamIcon: "")
        let decepticon = Transformer(courage: 1, endurance: 1, firepower: 6, id: "2",
                                     intelligence: 1, name: "P", rank: 1, skill: 7,
                                     speed: 1, strength: 7, team: "D", teamIcon: "")

        // Act //Calls
        dataManager.validateForthRule(autobot: autobot, decepticon: decepticon)

        // Assert //Checks
        XCTAssertEqual(self.dataManager.battleModel[0].winner, BattlefielResultEnum.decepticon)
    }

}

extension BattlefieldVMTests: BattlefieldVMDelegate {
    func userListApiDidFinish(success: Bool, message: String?) {
        results = true
        expectation.fulfill()
    }

}
