



import Foundation

struct Polygon {
    var points: [Point]
    
    init(points: [Point]) {
        self.points = points
    }
}

extension Polygon: Shape {
    //
    //   <polygon points="200,10 250,190 160,210" style="fill:lime;stroke:purple;stroke-width:1" />
    //
    func generateSVG() -> String {
        let beginning = "<polygon points=\""
        var pointsString = ""
        
        for point in points {
            pointsString += "\(point.x),\(point.y) "
        }
        
        let fullBeginning = beginning + pointsString + "\""
        
        let style = "style=\"fill:white;stroke:black;stroke-width:1\""
        
        let element = fullBeginning + " " + style + " />"
        
        return element
    }
}



extension Polygon {
    mutating func translate(_ point: Point) {
        for i in 0..<points.count {
            points[i].translate(point)
        }
    }
    
    mutating func rotate(radians: Double, aroundPoint point: Point) {
        for i in 0..<points.count {
            points[i].rotate(radians: radians, aroundPoint: point)
        }
    }
    
    mutating func mirror(plane: LineSegment) {
        points.mutate { point in
            point.mirror(plane: plane)
        }
    }
    
    mutating func scale(_ factor: Double) {
        points.mutate { point in
            point.scale(factor)
        }
    }
}
