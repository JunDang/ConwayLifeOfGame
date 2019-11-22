//
//  ConwayGameOfLifeTests.swift
//  ConwayGameOfLifeTests
//
//  Created by Jun Dang on 11/22/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

import XCTest
@testable import ConwayGameOfLife

class ConwayGameOfLifeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - test getLivingNeboursCounts function
    func test_alive_neighbours_counts_is_three() throws {
        let game = GameOfLife(probability: 0, size: 2)
        [(0, 0), (0, 1), (1, 0)].forEach{ game[$0.0, $0.1] = true }
        [(0, 0), (0, 1), (1, 0)]
            .map{ game[$0.0, $0.1]}
            .forEach {
                XCTAssertEqual($0, true)
        }
        
        let neiboursForCell = game.getLivingNeighboursCounts(x: 1, y: 1)
        
        XCTAssertEqual(neiboursForCell, 3)
    }
    
    // MARK: - a living cell keeps alive if it has two living neighbours
    func test_aliveCell_keeps_alive_if_has_two_aliveNeighbours() throws {
        var game = GameOfLife(probability: 0, size: 2)
        // testing if the subscript works
        [(0, 0), (0, 1), (1, 1)].forEach{ game[$0.0, $0.1] = true }
        [(0, 0), (0, 1), (1, 1)]
            .map{ game[$0.0, $0.1] }
            .forEach {
                XCTAssertEqual($0, true)
        }
        // testing the next() function
        game = game.next()
        for i in 0..<2 {
            for j in 0..<2 {
                XCTAssertEqual(game[i, j], true)
            }
        }
        
    }
    
    // MARK: - a living cell keeps alive if it has three living neighbours
    func test_aliveCell_keeps_alive_if_has_three_aliveNeighbours() throws {
        var game = GameOfLife(probability: 0, size: 2)
        [(0, 0), (0, 1), (1, 0), (1, 1)].forEach{ game[$0.0, $0.1] = true }
        [(0, 0), (0, 1), (1, 0), (1, 1)]
            .map{ game[$0.0, $0.1]}
            .forEach {
                XCTAssertEqual($0, true)
        }
        
        game = game.next()
        for i in 0..<2 {
            for j in 0..<2 {
                XCTAssertEqual(game[i, j], true)
            }
        }
    }
    
    // MARK: - a living cell dies if it has more than three neighbours
    func test_aliveCell_dies_if_has_more_than_three_neighbours() throws {
        var game: GameOfLife = GameOfLife(probability: 0, size: 3)
        [(2,1), (1,1), (1, 2), (0, 1), (0, 2)].forEach{ game[$0.0, $0.1] = true }
        [(2,1), (1,1), (1, 2), (0, 1), (0, 2)]
            .map{ game[$0.0, $0.1] }
            .forEach {
                XCTAssertEqual($0, true)
        }
        game = game.next()
        for i in 0..<3 {
            for j in 0..<3 {
                if (i == 0 && j == 0) || (i == 1 && j == 1) || (i == 1 && j == 2) || (i == 2 && j == 0){
                    XCTAssertEqual(game[i, j], false)
                } else {
                    XCTAssertEqual(game[i, j], true)
                }
                
            }
        }
        
    }
    
    // MARK: - a living cell dies if its living neighbours is less than two
    func test_aliveCell_dies_if_has_less_than_two_neighbours() throws {
        var game = GameOfLife(probability: 0, size: 2)
        [(0, 0), (1, 1)].forEach{ game[$0.0, $0.1] = true }
        [(0, 0), (1, 1)]
            .map{ game[$0.0, $0.1]}
            .forEach {
                XCTAssertEqual($0, true)
        }
        game = game.next()
        for i in 0..<2 {
            for j in 0..<2 {
                XCTAssertEqual(game[i, j], false)
            }
        }
    }
    
    //MARK: - A dead cell becomes alive if it has three neighbours
    func test_deadCell_becomes_alive_if_has_three_neighbours() throws {
        var game = GameOfLife(probability: 0, size: 2)
        [(0, 0), (0, 1), (1, 0)].forEach{ game[$0.0, $0.1] = true }
        [(0, 0), (0, 1), (1, 0)]
            .map{ game[$0.0, $0.1]}
            .forEach {
                XCTAssertEqual($0, true)
        }
        XCTAssertEqual(game[1, 1], false)
        game = game.next()
        for i in 0..<2 {
            for j in 0..<2 {
                XCTAssertEqual(game[i, j], true)
            }
        }
    }
    
    // MARK: -test a Blinker pattern
    func testSimpleBlinkerArray() throws {
        var game_of_life: GameOfLife = GameOfLife(probability: 0, size: 5)
        game_of_life[2, 1] = true
        game_of_life[2, 2] = true
        game_of_life[2, 3] = true
        XCTAssertEqual(game_of_life[2, 1], true)
        XCTAssertEqual(game_of_life[2, 2], true)
        XCTAssertEqual(game_of_life[2, 3], true)
        for i in 0..<5 {
            for j in 0..<5 {
                if (i != 2 && j != 1) || (i != 2 && j != 2) || (i != 2 && j != 3) {
                    XCTAssertEqual(game_of_life[i, j], false)
                }
            }
        }
        game_of_life = game_of_life.next()
        XCTAssertEqual(game_of_life[1, 2], true)
        XCTAssertEqual(game_of_life[2, 2], true)
        XCTAssertEqual(game_of_life[3, 2], true)
        for i in 0..<5 {
            for j in 0..<5 {
                if (i != 1 && j != 2) || (i != 2 && j != 2) || (i != 3 && j != 2) {
                    XCTAssertEqual(game_of_life[i, j], false)
                }
            }
        }
    }

}
