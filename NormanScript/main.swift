



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"

//<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
//<rect x="25" y="25" width="200" height="200" fill="lime" stroke-width="4" stroke="pink" />
//<circle cx="125" cy="125" r="75" fill="orange" />
//<polyline points="50,150 50,200 200,200 200,100" stroke="red" stroke-width="4" fill="none" />
//<line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
//</svg>


extension String {
    //
    // <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
    // ...
    // </svg>
    //
    func addSVGTags() -> String {
        let begin = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">"
        let end = "</svg>"
        
        return begin + "\n" + self + "\n" + end
    }
    
    //
    // Write to `ExportPath` on disc
    //
    func export() {
        ExportPath.createFile()
        do {
            try self.write(toFile: ExportPath, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
        }
    }
    
    //
    // Create file at `self` path
    //
    func createFile() {
        FileManager.default.createFile(atPath: self, contents: nil, attributes: nil)
    }
}

extension String {
    //
    // <g id="group1" stroke="red" stroke-width="5">
    // ...
    // </g>
    //
    func groupWithProperties(_ properties: [String: Any]) -> String {
        var propertiesString = ""
        for (key, value) in properties {
            propertiesString += (key + "=\"\(value)\" ")
        }
        
        let begin = "<g \(propertiesString)>"
        let end = "</g>"
        
        return begin + "\n" + self + "\n" + end
    }
}




//////////////
//////////////
//////////////

//let l1 = Line(start: p(0, 0), end: p(700,400))
//let l2 = Line(start: p(0, 300), end: p(800,0))
//let l3 = Line(start: p(33, 897), end: p(2000, 34))
//
//let lines = [l1, l2, l3]
////let shape = Shape(geometry: lines, color: "green", strokeWidth: 35)
//
////shape.generateSVG().addSVGTags().export()
//
//let c1 = Circle(diameter: 20, center: p(400, 400))
//let properties = ["stroke": "green", "stroke-width": 2, "fill": "clear" ] as [String : Any]
//Group(shapes: [l1, l2, l3, c1], properties: properties).ship()

let insetZero = 100.0
let l1Start = p(insetZero, insetZero)
let l1End = p(800, insetZero)
let l2Start = p(300 , 600)
let l2End = p(insetZero, insetZero)

let circleDiameter = 10.0
let c1 = Circle(diameter: circleDiameter, center: l1Start)
let c2 = Circle(diameter: circleDiameter, center: l1End)
let c3 = Circle(diameter: circleDiameter, center: l2Start)
let c4 = Circle(diameter: circleDiameter, center: l2End)

let l1 = Line(start: l1Start, end: l1End)
let l2 = Line(start: l2Start, end: l2End)


extension Double {
    var squared: Double {
        return pow(self, 2)
    }
}

func dist(startPoint p_0: Point, endPoint p_1: Point) -> Double {
    return sqrt( (p_1.x-p_0.x).squared + (p_1.y-p_0.y).squared )
}

func dist(_ line: Line) -> Double {
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

func interpolatedPoint(line: Line, distance d: Double) -> Point {
    return interpolatedPoint(startPoint: line.start, endPoint: line.end, distance: d)
}

let steps = 15.0
let ratio = 1/steps
let l1_d = l1.length
let l2_d = l2.length
let l1_step = l1_d * ratio
let l2_step = l2_d * ratio

var newCircles: [Shape] = []
var newLines: [Shape] = []
for i in 1..<Int(steps) {
    let i_d_type = Double(i)
    let l1_i = interpolatedPoint(line: l1, distance: i_d_type * l1_step)
    let l2_i = interpolatedPoint(line: l2, distance: i_d_type * l2_step)
    
    let lb_i = Line(start: l2_i, end: l1_i)
    let b_i = interpolatedPoint(line: lb_i, distance: lb_i.length * i_d_type * ratio)
    
    let newC1 = Circle(diameter: circleDiameter, center: l1_i)
    let newC2 = Circle(diameter: circleDiameter, center: l2_i)
    let c_b = Circle(diameter: circleDiameter, center: b_i)
    
//    newCircles.append(newC1)
//    newCircles.append(newC2)
    newCircles.append(c_b)
    
    newLines.append(lb_i)
}




let properties = ["stroke": "green", "stroke-width": 2, "fill": "clear" ] as [String : Any]
let lines: [Shape] = [l1, l2]
let circles: [Shape] = [c1, c2, c3, c4]
let shapes = lines+circles+newCircles+newLines
Group(shapes: shapes, properties: properties).ship()
















