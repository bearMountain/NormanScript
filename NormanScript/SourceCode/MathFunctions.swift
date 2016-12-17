



import Foundation


func dist(startPoint p_0: Point, endPoint p_1: Point) -> Double {
    return sqrt( (p_1.x-p_0.x).squared + (p_1.y-p_0.y).squared )
}

func dist(_ line: LineSegment) -> Double {
    return dist(startPoint: line.start, endPoint: line.end)
}

func interpolatedPoint(startPoint p_0: Point, endPoint p_1: Point, distance d: Double) -> Point {
    let fullLength = dist(startPoint: p_0, endPoint: p_1)
    let t = d / fullLength // Ratio
    
    // (xt,yt)=(((1−t)x0+tx1),((1−t)y0+ty1))
    let x_t = (1-t)*p_0.x + t*p_1.x
    let y_t = (1-t)*p_0.y + t*p_1.y
    
    return p(x_t, y_t)
}

func interpolatedPoint(startPoint p_0: Point, endPoint p_1: Point, distanceFromEndpoint d: Double) -> Point {
    let totalDistance = dist(startPoint: p_0, endPoint: p_1)
    let newDistance = totalDistance-d
    return interpolatedPoint(startPoint: p_0, endPoint: p_1, distance: newDistance)
}
