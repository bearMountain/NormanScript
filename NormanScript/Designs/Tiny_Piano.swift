



import Foundation

let LongestReed = 6.0

func barHeights() -> [Double] {
    let NoteFraction = 1.0595
    var heights: [Double] = []
    
    for i in 0...12 {
        let height = LongestReed/pow(NoteFraction, Double(i))
        heights.append(height)
    }
    
    return heights
}

func makeComb() {
    let BarWidth = 0.5
    let BarSpacer = 0.125
    let BaseWidth = LongestReed / 3.0
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
    let holeY = baseY - BaseWidth.third
    let hole1 = Circle(diameter: HoleDiameter, center: p(x*0.8, holeY))
    let hole2 = Circle(diameter: HoleDiameter, center: p(x*0.2, holeY))
    
    
    var piece = [comb, hole1, hole2] as [Shape]
    
    piece.mutate { shape in
        shape.scale(60)
        shape.translate(p(30,30))
    }
    
    
    
//    polypath.translate(p(10,10))
//    polypath.scale(2)
    
    
    ship(piece)
}
