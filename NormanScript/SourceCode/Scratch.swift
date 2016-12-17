

import Foundation

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

//func rotate(point: Point, aroundPoint: Point, delta: Double) -> Point {
//    let transformMatrix = m([
//        [cos(delta), sin(delta)],
//        [-sin(delta), cos(delta)]
//        ])
//    let pointToMove = m(point)
//    let axisPoint = m(aroundPoint)
//
//    let resultMatrix = transformMatrix*(pointToMove-axisPoint) + axisPoint
//
//    return p(resultMatrix)
//}

//var s2 = s1
//s2.rotate(degree: Double.pi.half, aroundPoint: s1.start)
//
//var l1 = Line(segments: [s1,s2])
//var l2 = l1
//l2.translate(x: 10, y: 10)
////l2.rotate(degree: Double.pi.half, aroundPoint: p(300,300))
//
//ship(shapes: [l1, l2])
//let lines: Array<Shape> = [l1]
//lines.ship()


//[s1, s2].ship()

/////////////////////////////////////////////////
