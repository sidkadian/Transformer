//
//  ResultVMTests.swift
//  TransformerTests
//
//  Created by Siddharth kadian on 17/02/21.
//

import XCTest
@testable import Transformer

class ResultVMTests: XCTestCase {

    var dataManager: ResultVM!
    var deception: Transformer!
    var autobot: Transformer!
    var model: BattlefieldModel!

    override func setUpWithError() throws {
        dataManager = ResultVM(battleModel: [])
    }

    override func tearDownWithError() throws {
        dataManager = nil
        model = nil
        autobot = nil
        deception = nil
    }

    func test_noResult_calculateFinalResults() throws {
        dataManager = ResultVM(battleModel: [])
        var finalMessage = ""
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (message: String, _: TransformerResultEnum) in
            finalMessage = message
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalMessage, AppStrings.Result.noResult)
    }

    func test_noneWinner_calculateFinalResults() throws {
        dataManager = ResultVM(battleModel: [])
        var finalWinner: TransformerResultEnum?
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (_: String, winner: TransformerResultEnum) in
            finalWinner = winner
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalWinner, TransformerResultEnum.none)
    }

    func test_matchTie_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 1, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .none,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalMessage = ""
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (message: String, _: TransformerResultEnum) in
            finalMessage = message
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalMessage, AppStrings.Result.matchTie)
    }

    func test_noWinner_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 1, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .none,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalWinner: TransformerResultEnum?
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (_: String, winner: TransformerResultEnum) in
            finalWinner = winner
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalWinner, TransformerResultEnum.none)
    }

    func test_autobotsWins_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 1, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 2, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .autobot,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalMessage = ""
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (message: String, _: TransformerResultEnum) in
            finalMessage = message
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalMessage, AppStrings.Result.autobotsWins)
    }

    func test_autobotsWinner_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 1, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 2, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .autobot,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalWinner: TransformerResultEnum?
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (_: String, winner: TransformerResultEnum) in
            finalWinner = winner
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalWinner, TransformerResultEnum.autobot)
    }

    func test_decepticonWins_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 2, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .decepticon,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalMessage = ""
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (message: String, _: TransformerResultEnum) in
            finalMessage = message
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalMessage, AppStrings.Result.decepticonsWin)
    }

    func test_decepticonWinner_calculateFinalResults() throws {
        deception = Transformer(courage: 1, endurance: 1, firepower: 2, id: "11",
                                intelligence: 1, name: "", rank: 1, skill: 1,
                                speed: 1, strength: 1, team: "", teamIcon: "")
        autobot = Transformer(courage: 1, endurance: 1, firepower: 1, id: "1",
                              intelligence: 1, name: "", rank: 1, skill: 1,
                              speed: 1, strength: 1, team: "", teamIcon: "")
        model = BattlefieldModel(winner: .decepticon,
                                     winnerDetail: .none,
                                     autobot: autobot,
                                     deception: deception)
        dataManager = ResultVM(battleModel: [model])
        var finalWinner: TransformerResultEnum?
        let expect = XCTestExpectation(description: "Expectation")
        dataManager.userResultListClosure = { (_: String, winner: TransformerResultEnum) in
            finalWinner = winner
            expect.fulfill()
        }

        dataManager.calculateFinalResults()
        wait(for: [expect], timeout: 1.0)

        XCTAssertEqual(finalWinner, TransformerResultEnum.decepticon)
    }

}
