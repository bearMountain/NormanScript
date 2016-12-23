



import Foundation


//MARK: - Point
struct Point: PointProtocol {
    var x: Double
    var y: Double
}


// Annoying, but necessary until Swift 3.1 is released
protocol PointProtocol {
    var x: Double { get set}
    var y: Double { get set}
}


extension Point: Translatable {
    mutating func translate(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
    
    mutating func translate(_ point: Point) {
        translate(x: point.x, y: point.y)
    }
    
    mutating func rotate(radians: Double, aroundPoint pivot: Point) {
        let transformMatrix = m([
            [cos(radians), sin(radians)],
            [-sin(radians), cos(radians)]
            ])
        let pointToMove = m(self)
        let axisPoint = m(pivot)
        
        let resultMatrix = transformMatrix*(pointToMove-axisPoint) + axisPoint
        
        self.x = resultMatrix[0,0]
        self.y = resultMatrix[1,0]
    }
    
    mutating func mirror(plane: LineSegment) {
        let m = (plane.start.y-plane.end.y)/(plane.start.x-plane.end.x)
        let b = plane.start.y-m*plane.start.x
        
        let d = (x + m*(y-b)) / (1 + m.squared)
        
        x = 2*d - x
        y = 2*d*m - y + 2*b
    }
    
    mutating func scale(_ factor: Double) {
        x = x*factor
        y = y*factor
    }
}


// Convenience Class Var
extension Point {
    static var origin: Point {
        return p(0,0)
    }
}


//MARK: - Convenience Constructors
func p(_ x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}

func p(_ matrix: Matrix) -> Point {
    return Point(x: matrix[0,0], y: matrix[1,0])
}


// Min/Max finding extension
extension Array where Element: PointProtocol {
    func find(_ comparator: @escaping (Double, Double)->(Double), coordinateSelector:@escaping (Point)->(Double)) -> Double {
        return self.reduce(coordinateSelector(self[0] as! Point)) { current, point in
            return comparator(current, coordinateSelector(point as! Point))
        }
    }
}
