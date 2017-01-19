



import Foundation

class Polygon: Polyline {
    override func svgBeginningString() -> String {
        return "<polygon points=\""
    }
    
    // Copy
    override func copy() -> Polygon {
        return Polygon(points: points.map{$0.copy()})
    }
}

class Polyline: Shape {
    var points: [Point]
    
    init(points: [Point]) {
        self.points = points
    }

    //
    //   <polygon points="200,10 250,190 160,210" style="fill:lime;stroke:purple;stroke-width:1" />
    //
    override func generateSVG() -> String {
        var pointsString = ""
        
        for point in points {
            pointsString += "\(point.x),\(point.y) "
        }
        
        let fullBeginning = svgBeginningString() + pointsString + "\""
        
        let style = "style=\"fill:none;stroke:black;stroke-width:1\""
        
        let element = fullBeginning + " " + style + " />"
        
        return element
    }
    
    func svgBeginningString() -> String {
        return "<polyline points=\""
    }

    override func translate(_ point: Point) {
        for i in 0..<points.count {
            points[i].translate(point)
        }
    }
    
    override func rotate(radians: Double, aroundPoint point: Point) {
        for i in 0..<points.count {
            points[i].rotate(radians: radians, aroundPoint: point)
        }
    }
    
    override func mirror(plane: Line) {
        points.mutate { point in
            point.mirror(plane: plane)
        }
    }
    
    override func scale(_ factor: Double) {
        points.mutate { point in
            point.scale(factor)
        }
    }

    override var maxY: Double {
        return points.find(max) { $0.y }
    }
    
    override var minY: Double {
        return points.find(min) { $0.y }
    }
    
    override var maxX: Double {
        return points.find(max) { $0.x }
    }
    
    override var minX: Double {
        return points.find(min) { $0.x }
    }
    
    var width: Double {
        return maxX-minX
    }
    
    var height: Double {
        return maxY-minY
    }
    
    var center: Point {
        return p(maxX-width.half, maxY-height.half)
    }
    
    // Copy
    func copy() -> Polyline {
        return Polyline(points: points.map{$0.copy()})
    }
}
