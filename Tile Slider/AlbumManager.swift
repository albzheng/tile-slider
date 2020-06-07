//
//  AlbumManager.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/5/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI
import Combine

class AlbumManager: ObservableObject {
    @Published var collection: Collection
    private var autosaveCancellable: AnyCancellable?
    
    let cols: Int  = 3
    var rows: Int
    
    init (){
        let defaultsKey = "collection"
        let collection = Collection(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? Collection()
        self.collection = collection
        rows = (collection.items.count - 1)/3 + 1
        
        autosaveCancellable = $collection.sink { collection in
            UserDefaults.standard.set(collection.json, forKey: defaultsKey)
        }
    }
    
    func itemAt(row: Int, col: Int) -> String {
        return collection.items[row*3 + col]
    }
    
    func addItem(item: String){
        collection.addItem(item: item)
    }
}
