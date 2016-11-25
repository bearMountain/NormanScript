



import Foundation

//MARK: - Point
struct Point {
    let x: Double
    let y: Double
}

//MARK: - Convenience Constructors
func p(_ x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}

func p(_ matrix: Matrix) -> Point {
    return Point(x: matrix[0,0], y: matrix[1,0])
}
