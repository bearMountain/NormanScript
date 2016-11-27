



import Foundation

//MARK: - Point
struct Point {
    var x: Double
    var y: Double
}

func rotate(point: Point, aroundPoint: Point, delta: Double) -> Point {
    let transformMatrix = m([
        [cos(delta), sin(delta)],
        [-sin(delta), cos(delta)]
        ])
    let pointToMove = m(point)
    let axisPoint = m(aroundPoint)
    
    let resultMatrix = transformMatrix*(pointToMove-axisPoint) + axisPoint
    
    return p(resultMatrix)
}

extension Point {
    mutating func translate(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
    
    mutating func rotate(degree: Double, aroundPoint pivot: Point) {
        let transformMatrix = m([
            [cos(degree), sin(degree)],
            [-sin(degree), cos(degree)]
            ])
        let pointToMove = m(self)
        let axisPoint = m(pivot)
        
        let resultMatrix = transformMatrix*(pointToMove-axisPoint) + axisPoint
        
        self.x = resultMatrix[0,0]
        self.y = resultMatrix[1,0]
    }
}

//MARK: - Convenience Constructors
func p(_ x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}

func p(_ matrix: Matrix) -> Point {
    return Point(x: matrix[0,0], y: matrix[1,0])
}
