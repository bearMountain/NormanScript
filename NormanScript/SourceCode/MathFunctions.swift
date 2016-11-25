



import Foundation


func dist(startPoint p_0: Point, endPoint p_1: Point) -> Double {
    return sqrt( (p_1.x-p_0.x).squared + (p_1.y-p_0.y).squared )
}

func dist(_ line: LineSegment) -> Double {
    return dist(startPoint: line.start, endPoint: line.end)
}
