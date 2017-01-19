



import Foundation

func makeShelfBracket1() {
    let topWidth = 17.5
    let sideHeight = 1.5
    let centerHeight = 3.5
    let bottomRadius = topWidth
    let boltDiameter = 0.25
    let boltSlopRatio = 1.35
    let boltInset = centerHeight/6.0
    
    let path = RoundedPolygon(corners: [
        Corner(point: .origin),
        Corner(point: p(topWidth, 0)),
        Corner(point: p(topWidth, sideHeight)),
        Corner(point: p(topWidth.half, centerHeight), radius: bottomRadius),
        Corner(point: p(0, sideHeight))
        ])
    
    let holeDiameter = boltDiameter*boltSlopRatio
    let hole1 = Circle(diameter: holeDiameter, center: p(path.width.half, boltInset))
    let hole2 = Circle(diameter: holeDiameter, center: p(path.width.half, path.maxY*0.875-boltInset))
    
    var pieces = [path, hole1, hole2]
    
    pieces.mutate { piece in
        piece.scale(90)
    }
    
    ship(pieces)
}

func makeShelfBracket2() {
    let topWidth = 17.5
    let sideHeight = 1.0
    let centerHeight = 2.5
    let bottomRadius = topWidth
    let boltDiameter = 0.25
    let boltSlopRatio = 1.35
    let verticalBoltInset = 0.65
    let boltHorizontalDistance = 13.0
    
    let path = RoundedPolygon(corners: [
        Corner(point: .origin),
        Corner(point: p(topWidth, 0)),
        Corner(point: p(topWidth, sideHeight)),
        Corner(point: p(topWidth.half, centerHeight), radius: bottomRadius),
        Corner(point: p(0, sideHeight))
        ])
    
    let holeDiameter = boltDiameter*boltSlopRatio
    let horizontalBoltInset = (path.width-boltHorizontalDistance).half
    let hole1 = Circle(diameter: holeDiameter, center: p(horizontalBoltInset, verticalBoltInset))
    let hole2 = Circle(diameter: holeDiameter, center: p(path.maxX-horizontalBoltInset, verticalBoltInset))
    
    var pieces = [path, hole1, hole2]
    
    pieces.mutate { piece in
        piece.scale(90)
    }
    
    ship(pieces)
}
