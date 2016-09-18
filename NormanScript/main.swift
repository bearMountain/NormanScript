



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

let l1 = Line(start: p(0, 0), end: p(700,400))
let l2 = Line(start: p(0, 300), end: p(800,0))
let l3 = Line(start: p(33, 897), end: p(2000, 34))

let lines = [l1, l2, l3]
let shape = Shape(geometry: lines, color: "green", strokeWidth: 35)

//shape.generateSVG().addSVGTags().export()

let c1 = Circle(diameter: 20, center: p(400, 400))
Shape(geometry: [c1], color: "green", strokeWidth: 2).ship()

// Shape -> Group
// Geometry = [SVGExportable] -> 

//
//protocol Clothes: SVGExportSupport {
//    
//}
//
//struct Hat: Clothes {
//    func generateSVG() -> String {
//        return ""
//    }
//}
//
//
//let shapes: [Clothes] = []
//for shape in shapes {
//    print(shape.generateSVG())
//}
//
//


