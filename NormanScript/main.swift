



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"

//<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
//<rect x="25" y="25" width="200" height="200" fill="lime" stroke-width="4" stroke="pink" />
//<circle cx="125" cy="125" r="75" fill="orange" />
//<polyline points="50,150 50,200 200,200 200,100" stroke="red" stroke-width="4" fill="none" />
//<line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
//</svg>

// <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
// ...
// </svg>
extension String {
    func addSVGTags() -> String {
        let begin = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">"
        let end = "</svg>"
        
        return begin + "\n" + self + "\n" + end
    }
    
    func export() {
        ExportPath.createFile()
        do {
            try self.write(toFile: ExportPath, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
        }
    }
    
    func createFile() {
        FileManager.default.createFile(atPath: self, contents: nil, attributes: nil)
    }
}

struct Point {
    let x: Double
    let y: Double
}

func p(_ x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}

struct Line {
    let start: Point
    let end: Point
}

protocol SVGExportSupport {
    func generateSVG() -> String
}

extension Line: SVGExportSupport {
    //
    // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
    //
    func generateSVG() -> String {
//        return "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" stroke=\"blue\" stroke-width=\"1\" />"
        return "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" />"
    }
}



typealias Geometry = [SVGExportSupport]
typealias Color = String

extension String {
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

class Shape: SVGExportSupport {
    init(geometry: Geometry, color: Color, strokeWidth: Double) {
        self.geometry = geometry
        self.color = color
        self.strokeWidth = strokeWidth
    }
    

    
    func generateSVG() -> String {
        let geometrySVG = geometry.map{$0.generateSVG()}.joined(separator: "\n")
        let properties = ["stroke": color, "stroke-width": strokeWidth ] as [String : Any]
        
        return geometrySVG.groupWithProperties(properties)
    }
    
    //MARK: - Private Vars
    private var geometry: Geometry
    private var color: Color
    private var strokeWidth: Double
}





let l1 = Line(start: p(0, 0), end: p(700,400))
let l2 = Line(start: p(0, 300), end: p(800,0))
let l3 = Line(start: p(33, 897), end: p(2000, 34))

let lines = [l1, l2, l3]
let shape = Shape(geometry: lines, color: "green", strokeWidth: 35)

shape.generateSVG().addSVGTags().export()










