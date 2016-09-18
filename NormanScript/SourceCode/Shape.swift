



import Foundation


protocol SVGExportSupport {
    func generateSVG() -> String
}

protocol Shape: SVGExportSupport {
    
}


class Group: Shape {
    init(shapes: [Shape], properties: [String: Any]) {
        self.shapes = shapes
        self.properties = properties
    }
    
    func generateSVG() -> String {
        let geometrySVG = shapes.map{$0.generateSVG()}.joined(separator: "\n")
        return geometrySVG.groupWithProperties(properties)
    }
    
    //MARK: - Private Vars
    private var shapes: [Shape]
    private var properties: [String: Any]
}

extension Group {
    func ship() {
        self.generateSVG().addSVGTags().export()
    }
}
