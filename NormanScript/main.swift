



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"



func buildingPolyTest() {
    let radius = 0.5
    
    let corners = [
        Corner(point: .origin, radius: 0),
        Corner(point: p(0,2), radius: 0),
        Corner(point: p(1,2), radius: 0),
        Corner(point: p(1,1), radius: radius),
        Corner(point: p(2,1), radius: radius),
        Corner(point: p(2,2), radius: 0),
        Corner(point: p(3,2), radius: 0),
        Corner(point: p(3,0), radius: 0)
        ]
    
    let polypath = Polypath(corners: corners)
    
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

buildingPolyTest()




