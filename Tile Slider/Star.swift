//
//  Star.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/10/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        var p = Path()
        p.move(to: CGPoint(x: 0.5 * width, y: 0))
        p.addLine(to: CGPoint(x: (0.5 + 0.11803) * width, y: 0.36327 * width))
        p.addLine(to: CGPoint(x: width, y: 0.36327 * width))
        p.addLine(to: CGPoint(x: width * (1 - 0.30840), y: (0.36327 + 0.22451) * width))
        p.addLine(to: CGPoint(x: width * (0.5 + 0.30840), y: width))
        p.addLine(to: CGPoint(x: 0.5 * width, y: (1 - 0.22406) * width))
        p.addLine(to: CGPoint(x: width * (0.5 - 0.30840), y: width))
        p.addLine(to: CGPoint(x: width * 0.30840, y: (0.36327 + 0.22451) * width))
        p.addLine(to: CGPoint(x: 0, y: 0.36327 * width))
        p.addLine(to: CGPoint(x: (0.5 - 0.11803) * width, y: 0.36327 * width))
        p.addLine(to: CGPoint(x: 0.5 * width, y: 0))
        return p
    }
}
