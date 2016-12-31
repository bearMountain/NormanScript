



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"

class Corner: Shape {
    var point: Point
    var radius: Double
    
    init(point: Point, radius: Double) {
        self.point = point
        self.radius = radius
    }
}

class Polypath: Shape {
    var corners: [Corner] = []
    
    init(corners: [Corner]) {
        self.corners = corners
    }
    
    // SVG
    override func generateSVG() -> String {
        var path = SVGPath()

        path.move(toPoint: corners.first!.point)
        
        for i in 1..<corners.count {
            let currentCorner = corners[i]
            if (currentCorner.radius == 0) {
                path.addLine(toPoint: currentCorner.point)
            } else {
                let previousPoint = corners[i-1].point
                let nextPoint = (i == corners.count-1) ? corners.first!.point : corners[i+1].point
                
                let (cStart, cEnd) = controlPoints(forStartPoint:previousPoint,
                                                   vertex:currentCorner.point,
                                                   endPoint:nextPoint,
                                                   radius:currentCorner.radius)
                
                path.addLine(toPoint: cStart)
                path.addCurve(controlPoint: currentCorner.point, endPoint: cEnd)
                path.addLine(toPoint: nextPoint)
            }
        }
        
        path.close()

        
    }
}

extension Polypath {
    func controlPoints(forStartPoint startPoint:Point, vertex:Point, endPoint:Point, radius:Double) -> (Point, Point) {
        let v1 = p(startPoint.x-vertex.x, startPoint.y-vertex.y)
        let v2 = p(endPoint.x-vertex.x, endPoint.y-vertex.y)
        
        let top = v1.x*v2.x + v1.y*v2.y
        let bottom = dist(startPoint: startPoint, endPoint: vertex) * dist(startPoint: endPoint, endPoint: vertex)
        
        let angle = acos(top/bottom)
        let h = abs( radius / tan(angle.half) )
        
        let p1 = interpolatedPoint(startPoint: vertex, endPoint: startPoint, distance: h)
        let p2 = interpolatedPoint(startPoint: vertex, endPoint: endPoint, distance: h)
        
        return (p1, p2)
    }
}

func buildingPolyTest() {
    let corners = [
        Corner(point: .origin, radius: 0),
        Corner(point: p(0,2), radius: 0),
        Corner(point: p(1,2), radius: 0),
        Corner(point: p(1,1), radius: 0.5),
        Corner(point: p(2,1), radius: 0.5),
        Corner(point: p(2,2), radius: 0),
        Corner(point: p(3,2), radius: 0),
        Corner(point: p(3,0), radius: 0)
        ]
    
    var polypath = Polypath(corners: corners)
    
    ship(polypath)
}

func angleTest() {
    let radius = 1.0
    let line = Polyline(points: [p(0,2), .origin, p(2,0)])
    
    let v1 = p(line.points[0].x-line.points[1].x, line.points[0].y-line.points[1].y)
    let v2 = p(line.points[2].x-line.points[1].x, line.points[2].y-line.points[1].y)
    
    let top = v1.x*v2.x + v1.y*v2.y
    let bottom = dist(startPoint: line.points[0], endPoint: line.points[1]) *
                 dist(startPoint: line.points[2], endPoint: line.points[1])
    
    let angle = acos(top/bottom)
    let h = abs( radius / tan(angle.half) )
    
    let p1 = interpolatedPoint(startPoint: line.points[1], endPoint: line.points[0], distance: h)
    let p2 = interpolatedPoint(startPoint: line.points[1], endPoint: line.points[2], distance: h)
    
    var lines = [line, p1, p2]
    lines.mutate { line in
        line.scale(100)
        line.translate(p(300,300))
    }
    
    ship(lines)
}

angleTest()




