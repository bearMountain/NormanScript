



import Foundation

// Annoying, but necessary until Swift 3.1 is released
protocol CornerProtocol {
    var point: Point { get set}
    var radius: Double { get set}
}

class Corner: Shape, CornerProtocol {
    var point: Point
    var radius: Double
    
    init(point: Point, radius: Double = 0) {
        self.point = point
        self.radius = radius
    }
    
    // Translation
    override func translate(_ p: Point) {
        point.translate(p)
    }
    
    override func scale(_ factor: Double) {
        point.scale(factor)
        radius *= factor
    }
}

// Min/Max finding extension
extension Array where Element: CornerProtocol {
    func find(_ comparator: @escaping (Double, Double)->(Double), coordinateSelector:@escaping (Point)->(Double)) -> Double {
        return self.reduce(coordinateSelector(self[0].point)) { current, corner in
            return comparator(current, coordinateSelector(corner.point))
        }
    }
}
