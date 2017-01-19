



import Foundation

// Smallest Steel comb:
// LongestReed = 1.5
// 0...6 num reeds (i*2 for every other reed size)
// BarWidth = 0.2
// BarSpacer = 0.04
//
// Medium Steel comb:
// LongestReed = 3
// 0...6 num reeds (i*2 for every other reed size)
// BarWidth =~ 0.4
// BarSpacer =~ 0.08
//
// Large Steel comb:
// LongestReed = 6
// 0...12 num reeds
// BarWidth =~ 0.4
// BarSpacer =~ 0.08
//
// Small Saw comb:
// LongestReed = 2
// 0...6 num reeds (i*2 for every other reed size)
// BarWidth = 0.2
// BarSpacer = 0.04
//
// Long Saw comb:
// LongestReed = 4.8
// 0...6 num reeds (i*2 for every other reed size)
// BarWidth = 0.2
// BarSpacer = 0.08
//
// Fat Saw comb:
// LongestReed = 2.5
// 0...6 num reeds (i*2 for every other reed size)
// BarWidth = 0.3
// BarSpacer = 0.08


let LongestReed = 2.5

func barHeights() -> [Double] {
    let NoteFraction = 1.0595
    var heights: [Double] = []
    
    for i in 0...6 {
        let height = LongestReed/pow(NoteFraction, Double(i*2))
        heights.append(height)
    }
    
    return heights
}

func makeComb() {
    let BarWidth = 0.3
    let BarSpacer = 0.04
//    let BaseWidth = LongestReed / 2.0
    let BaseWidth = 0.75
    let TopRadius = BarWidth * 0.2
    let BottomRadius = BarSpacer.half
    
    let heights = barHeights()
    
    var corners: [Corner] = []
    
    corners.append(Corner(point: .origin, radius: TopRadius))
    
    // Start at Top
    var x = 0.0
    var y = 0.0
    
    for i in 0..<heights.count {
        // Move over at Top
        x += BarWidth
        corners.append(Corner(point: p(x,y), radius: TopRadius))
        
        // Move down height
        y += heights[i]
        corners.append(Corner(point: p(x,y), radius: BottomRadius))
        
        let lastBar = i == heights.count-1
        if (!lastBar) {
            // Move over at Bottom
            x += BarSpacer
            corners.append(Corner(point: p(x,y), radius: BottomRadius))
            
            // Jump back to Top
            y = 0.0
            corners.append(Corner(point: p(x,y), radius: TopRadius))
        }
    }
    
    // Add Base
    let baseY = heights[0]+BaseWidth
    let baseRadius = x * 0.1
    let bottomLeft = Corner(point: p(0, baseY), radius: baseRadius)
    let bottomRight = Corner(point: p(x, baseY), radius: baseRadius)
    
    corners.append(bottomRight)
    corners.append(bottomLeft)
    
    
    let comb = Polypath(corners: corners)
    
    let HoleDiameter = 0.25
    let SmallHoleSpacing = 0.984
    let holeInset = (x-SmallHoleSpacing).half
    let holeY = baseY - BaseWidth.third
    let hole1 = Circle(diameter: HoleDiameter, center: p(holeInset, holeY))
    let hole2 = Circle(diameter: HoleDiameter, center: p(x-holeInset, holeY))
    hole2.rotate(radians: -35.radians, aroundPoint: hole1.center)
    
    var piece = [comb, hole1, hole2] as [Shape]
    
    piece.mutate { shape in
        shape.scale(90)
//        shape.translate(p(200,200))
    }
    
    
    
//    polypath.translate(p(10,10))
//    polypath.scale(2)
    
    
    ship(piece)
}
