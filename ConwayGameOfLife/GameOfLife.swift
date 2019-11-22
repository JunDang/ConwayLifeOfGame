//
//  GameOfLife.swift
//  ConwayGameOfLife
//
//  Created by Jun Dang on 11/22/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

import Foundation

//MARK: - store the x and y value for a cell in the Coordinate struct
struct Coordinate: Hashable {
    let x: Int, y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

class GameOfLife {
    // MARK: - a dictionary which key is the cells' Coordinate, and value is the cells' living state. The dictionary will only contain living cells.
    var dic: [Coordinate : Bool] = [:]
    var size: Int // the dimension of the matrix where cells live
    
    public init (probability: Float, size: Int) {
        self.size = size
        // MARK: - create the living cells with a probability
        let living_cells_count = Int(Float(size * size) * probability)
        var count = 0
        while count < living_cells_count {
            let x = Int.random(in: 0..<size)
            let y = Int.random(in: 0..<size)
            let coor = Coordinate(x: x, y: y)
            if !self.dic.keys.contains(coor) {
                dic[coor] = true
                count += 1
            }
        }
    }
    
    private init(dic: [Coordinate : Bool], size: Int) {
        self.dic = dic
        self.size = size
    }
    
    // MARK: - to count the number of living neighbours
    func getLivingNeighboursCounts(x: Int, y: Int) -> Int {
        return [(-1, -1), (-1, 1), (0, -1), (-1, 0), (0, 1), (1, -1), (1, 0),
                (1, 1)]
            .map{(x + $0.0, y + $0.1)}
            .filter{$0.0 >= 0 && $0.0 <= self.size - 1 && $0.1 >= 0 && $0.1 <= self.size - 1 }
            .filter{self[$0.0, $0.1]}
            .count
    }
    
    // MARK: - function to apply the Conway's rules of Game Of Life
    func next()  -> GameOfLife {
        var dic: [Coordinate: Bool] = [:]
        let size = self.size
        for i in 0..<size {
            for j in 0..<size {
                let livingNeighbours = getLivingNeighboursCounts(x: i, y: j)
                if self[i, j] {
                    if livingNeighbours == 2 || livingNeighbours == 3 {
                        dic[Coordinate(x: i, y: j)] = true
                    }
                } else {
                    if livingNeighbours == 3 {
                        dic[Coordinate(x: i, y: j)] = true
                    }
                }
            }
        }
        return GameOfLife(dic: dic, size: size)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return 0..<size ~= row && 0..<size ~= column
    }
    
    subscript(row: Int, column: Int) -> Bool {
        get {
            assert(indexIsValid(row: row, column: column), "Index within range")
            return dic[Coordinate(x: row, y: column)] != nil
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index within range")
            let key_exsits = dic[Coordinate(x: row, y: column)] != nil
            if newValue {
                if !key_exsits {
                    dic[Coordinate(x: row, y: column)] = true
                } else {
                    dic[Coordinate(x: row, y: column)] = nil
                }
            }
        }
    }
}

