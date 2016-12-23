



import Foundation

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
