//
//  Array+identifiable.swift
//  Memorize
//
//  Created by Albert Zheng on 4/23/20.
//  Copyright © 2020 Albert Zheng. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
