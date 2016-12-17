



import Foundation

func pentagonFlower() -> [Pentagon] {
    let pentagon = Pentagon(radius: 100)
    let delta = Double.pi*2/5
    
    var flower: [Pentagon] = []
    
    for i in 0..<5 {
        let j1 = i
        let j2 = (i+1) < 5 ? i+1 : 0
        let plane = LineSegment(start: pentagon.points[j1], end: pentagon.points[j2])
        var p1 = pentagon
        p1.rotate(radians: delta*Double(i+1), aroundPoint: .origin)
        p1.mirror(plane: plane)
        flower.append(p1)
    }
    
    return flower
}

func dodecahedronFlatPack() -> [Shape] {
    var flower1 = pentagonFlower()
    var flower2 = flower1
    
    let petal = flower2[3]
    let p1 = petal.points[1]
    let p2 = petal.points[2]
    let distance = dist(startPoint: p1, endPoint: p2)/2.0
    let junctureCenter = interpolatedPoint(startPoint: p1, endPoint: p2, distance: distance)
    var junctureCircle: Shape = Circle(diameter: 10, center: junctureCenter)
    
    flower2.mutate { shape in
        shape.rotate(radians: Double.pi, aroundPoint: junctureCenter)
    }
    
    // Center on screen
    let originShift = p(800,300)
    
    flower1.mutate { shape in
        shape.translate(originShift)
    }
    flower2.mutate { shape in
        shape.translate(originShift)
    }
    
    junctureCircle.translate(originShift)
    
    
    return flower1+flower2
}



//var f = pentagonFlower()
//let originShift = p(800,300)
//
//f.mutate { shape in
//    shape.translate(originShift)
//}
