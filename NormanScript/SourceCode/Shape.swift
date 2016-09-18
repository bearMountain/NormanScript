



import Foundation


protocol SVGExportSupport {
    func generateSVG() -> String
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

extension Shape {
    func ship() {
        self.generateSVG().addSVGTags().export()
    }
}
