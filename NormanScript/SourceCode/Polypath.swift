



import Foundation


class Polypath: Shape {
    var corners: [Corner] = []
    
    init(corners: [Corner] = []) {
        self.corners = corners
    }
    
    // SVG
    override func generateSVG() -> String {
        let path = SVGPath()
        
        let (_, lastCurvePoint) = curvePoints(forStartPoint:corners[corners.count-2].point,
                                              vertex:corners.last!.point,
                                              endPoint:corners.first!.point,
                                              radius:corners.last!.radius)
        path.move(toPoint: lastCurvePoint)
        
        for i in 0..<corners.count {
            let currentCorner = corners[i]
            if (currentCorner.radius == 0) {
                path.addLine(toPoint: currentCorner.point)
            } else {
                let previousPoint = (i == 0) ? corners.last!.point : corners[i-1].point
                let nextPoint = (i == corners.count-1) ? corners.first!.point : corners[i+1].point
                
                let (cStart, cEnd) = curvePoints(forStartPoint:previousPoint,
                                                 vertex:currentCorner.point,
                                                 endPoint:nextPoint,
                                                 radius:currentCorner.radius)
                
                path.addLine(toPoint: cStart)
                path.addCurve(controlPoint: currentCorner.point, endPoint: cEnd)
            }
        }
        
        path.close()
        
        return path.string
    }
    
    // Translation
    override func translate(_ point: Point) {
        corners.mutate { $0.translate(point) }
    }
    
    override func scale(_ factor: Double) {
        corners.mutate { $0.scale(factor) }
    }
}

extension Polypath {
    func curvePoints(forStartPoint startPoint:Point, vertex:Point, endPoint:Point, radius:Double) -> (Point, Point) {
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
