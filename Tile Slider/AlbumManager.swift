//
//  AlbumManager.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/5/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

class AlbumManager: ObservableObject {
    @Published var collection: Collection
    let cols: Int  = 3
    var rows: Int
    
    init (collection: Collection){
        self.collection = collection
        rows = (collection.items.count - 1)/3 + 1
    }
    
    func itemAt(row: Int, col: Int) -> String {
        return collection.items[row*3 + col]
    }
}
