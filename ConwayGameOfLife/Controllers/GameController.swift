//
//  GameController.swift
//  ConwayGameOfLife
//
//  Created by Jun Dang on 11/22/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

import UIKit

class GameController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let reuseIdentifier = "Cell"
    var game = GameOfLife(probability: 0.4, size: 25)
    var gameTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        // MARK: - a timer used to update the state
        gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(inspectLife), userInfo: nil, repeats: true)
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    @objc func inspectLife() {
        game = game.next()
        collectionView.reloadData()
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return game.size * game.size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.configureCell(game, indexPath: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 15, height: 15)
    }
}

// MARK: - configure the cell with GameOfLife object
extension UICollectionViewCell {
    func configureCell(_ game: GameOfLife, indexPath: IndexPath) {
        backgroundColor = .gray
        let x = indexPath.row / game.size
        let y =  indexPath.row % game.size
        if game[x, y] == true {
            backgroundColor = .green
        }
    }
}
