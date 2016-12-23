



import Foundation


protocol SVGExportable {
    func generateSVG() -> String
}

protocol Translatable {
    mutating func translate(_ point: Point)
    mutating func mirror(plane: LineSegment)
    mutating func rotate(radians: Double, aroundPoint point: Point)
    mutating func scale(_ factor: Double)
}

protocol Locatable {
    var maxY: Double { get }
    var minY: Double { get }
    var maxX: Double { get }
    var minX: Double { get }
}


//class Group: Shape {
//    init(shapes: [Shape], properties: [String: Any]) {
//        self.shapes = shapes
//        self.properties = properties
//    }
//    
//    func generateSVG() -> String {
//        let geometrySVG = shapes.map{$0.generateSVG()}.joined(separator: "\n")
//        return geometrySVG.groupWithProperties(properties)
//    }
//    
//    //MARK: - Private Vars
//    private var shapes: [Shape]
//    private var properties: [String: Any]
//}

//extension Group {
//    func ship() {
//        self.generateSVG().addSVGTags().export()
//    }
//}
