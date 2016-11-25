



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"

////////////////////////////////////////////////////////////////////////////////
// Sample SVG
////////////////////////////////////////////////////////////////////////////////

//<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
//<rect x="25" y="25" width="200" height="200" fill="lime" stroke-width="4" stroke="pink" />
//<circle cx="125" cy="125" r="75" fill="orange" />
//<polyline points="50,150 50,200 200,200 200,100" stroke="red" stroke-width="4" fill="none" />
//<line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
//</svg>







////////////////////////////////////////////////////////////////////////////////
// Bezier
////////////////////////////////////////////////////////////////////////////////

//let insetZero = 100.0
//let l1Start = p(insetZero, insetZero)
//let l1End = p(600, insetZero)
//let l2Start = p(300 , 300)
//let l2End = p(insetZero, insetZero)
//
//let circleDiameter = 10.0
//let c1 = Circle(diameter: circleDiameter, center: l1Start)
//let c2 = Circle(diameter: circleDiameter, center: l1End)
//let c3 = Circle(diameter: circleDiameter, center: l2Start)
//let c4 = Circle(diameter: circleDiameter, center: l2End)
//
//let l1 = Line(start: l1Start, end: l1End)
//let l2 = Line(start: l2Start, end: l2End)
//
//
//
//func interpolatedPoint(startPoint p_0: Point, endPoint p_1: Point, distance d: Double) -> Point {
//    let fullLength = dist(startPoint: p_0, endPoint: p_1)
//    let t = d / fullLength // Ratio
//    
//    // (xt,yt)=(((1−t)x0+tx1),((1−t)y0+ty1))
//    let x_t = (1-t)*p_0.x + t*p_1.x
//    let y_t = (1-t)*p_0.y + t*p_1.y
//    
//    return p(x_t, y_t)
//}
//
//func interpolatedPoint(line: Line, distance d: Double) -> Point {
//    return interpolatedPoint(startPoint: line.start, endPoint: line.end, distance: d)
//}
//
//let steps = 100.0
//let ratio = 1/steps
//let l1_d = l1.length
//let l2_d = l2.length
//let l1_step = l1_d * ratio
//let l2_step = l2_d * ratio
//
//var baseColor = c(0,1,0.5)
//var strokeWidth = 0.6
//
//var newCircles: [Shape] = []
//var newLines: [Shape] = []
//for i in 1..<Int(steps) {
//    let i_d_type = Double(i)
//    let l1_i = interpolatedPoint(line: l1, distance: i_d_type * l1_step)
//    let l2_i = interpolatedPoint(line: l2, distance: i_d_type * l2_step)
//    
//    baseColor.r += 0.01
//    baseColor.g -= 0.01
//    baseColor.b += 0.005
//    
//    strokeWidth -= 0.005
//    
//    let lb_i = Line(start: l2_i, end: l1_i, strokeColor: baseColor, strokeWidth: strokeWidth)
//    let b_i = interpolatedPoint(line: lb_i, distance: lb_i.length * i_d_type * ratio)
//    
//    let newC1 = Circle(diameter: circleDiameter, center: l1_i)
//    let newC2 = Circle(diameter: circleDiameter, center: l2_i)
//    let c_b = Circle(diameter: circleDiameter, center: b_i)
//    
//    newCircles.append(newC1)
//    newCircles.append(newC2)
//    newCircles.append(c_b)
//    
//    newLines.append(lb_i)
//}
//
//
//
//
//let properties = ["stroke": "gray", "stroke-width": 1, "fill": "clear" ] as [String : Any]
//let lines: [Shape] = [l1, l2]
//let circles: [Shape] = [c1, c2, c3, c4]
////let shapes = lines+circles+newCircles+newLines
//let shapes = newLines
//Group(shapes: shapes, properties: [:]).ship()

///
//let ll1 = Line(start: p(100, 100), end: p(700, 700), strokeColor: c(1,0.35,0), strokeWidth: 2)
//let ll2 = Line(start: p(100, 500), end: p(500, 600), strokeColor: c(0,1,0.911), strokeWidth: 4)
//
//[ll1, ll2].map{$0.generateSVG()}.joined(separator: "\n").addSVGTags().export()





//let s1 = LineSegment(start: p(100, 100), end: p(150,100), strokeColor: nil, strokeWidth: nil, fillColor: nil)
//let s2 = LineSegment(start: p(100, 100), end: p(100, 150), strokeColor: nil, strokeWidth: nil, fillColor: nil)
//
//let line1 = s1 + s2
//let line2 = line1.rotated(90)


//let twoByTwo = m([[1,2],[3,4]])
//let twoByOne = m([5,6])
//
//let result = twoByTwo*twoByOne
//print(result)
//
//let p1 = m([5,5])
//let p2 = m([6,2])
//let p3 = p1-p2
//print(p3)
//
//
//
//
//let origin = p(2,2)
//let twoOut = p(4,2)
//let twoUp = rotate(point: twoOut, aroundPoint: origin, delta: Double.pi.half.half)
//print(twoUp)

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


let segmentLength = 10.0
let origin = p(300, 300)

let s1 = LineSegment(start: p(0,0), end: p(segmentLength, 0), strokeColor: c(0,0,0), strokeWidth: 5)

[s1].ship()







