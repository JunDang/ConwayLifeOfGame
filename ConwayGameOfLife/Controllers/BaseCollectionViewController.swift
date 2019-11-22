//
//  BaseCollectionViewController.swift
//  ConwayGameOfLife
//
//  Created by Jun Dang on 11/22/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
