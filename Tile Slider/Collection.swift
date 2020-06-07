//
//  Collection.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/4/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import Foundation

struct Collection: Codable{
    var items: Array<String> = []
    //var items = ["Charmandar","Bulb","Squirtle","Bulb","Charmandar","Bulb","Squirtle","Bulb","Charmandar","Bulb","Charmandar","Bulb","Charmandar","Bulb","Squirtle","Bulb","Charmandar","Bulb","Squirtle","Bulb"]
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init? (json:Data?) {
        if json != nil, let newCollection = try? JSONDecoder().decode(Collection.self, from: json!) {
            self = newCollection
        } else {
            return nil
        }
    }
    
    init() {
        self.items = []
    }
    
    mutating func addItem(item: String) {
        if !items.contains(item){
            items.append(item)
            print("Adding " + item + " to collection.")
        }
    }
}
