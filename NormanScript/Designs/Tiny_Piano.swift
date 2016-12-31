//
//  Tiny_Piano.swift
//  NormanScript
//
//  Created by Jeffrey Camealy on 12/29/16.
//  Copyright © 2016 BranchComputing. All rights reserved.
//

import Foundation

let BarWidth = 10.0
let BarSpacer = 5.0
let BaseWidth = 30.0

let barHeights = [100.0, 90.0, 80.0]

var points: [Point] = []
var currentX = 0.0
var firstBar = true
for barHeight in barHeights {
    if (firstBar) {
        firstBar = false
    } else {
        currentX += BarSpacer
    }
    
    points.append(p(currentX, barHeight))
    points.append(p(currentX, 0))
    
    currentX += BarWidth
    
    points.append(p(currentX, 0))
    points.append(p(currentX, barHeight))
}

let offsetBase = p(points[0].x, points[0].y+BaseWidth)
let offsetEnd = p(points.last!.x, points.last!.y+BaseWidth)

points.insert(offsetBase, at: 0)
points.append(offsetEnd)

let comb = Polygon(points: points)

comb.scale(3)
comb.translate(p(200, 100))

ship(comb)
