



import Foundation


class Group: Shape {
    //MARK: - Public Vars
    var style: Style?
    var shapes: [Shape] {
        didSet {
            validateShapes()
        }
    }
    
    init(shapes: [Shape], style: Style? = nil) {
        self.shapes = shapes
        self.style = style
        super.init()
        
        validateShapes()
    }
    
    // SVG Generation
    override func generateSVG() -> String {
        let begin = "<g \(style?.generateSVG() ?? "")>"
        let end = "</g>"
        
        let geometrySVG = shapes.map{$0.generateSVG()}.joined(separator: "\n")
        
        return begin + "\n" + geometrySVG + "\n" + end
    }
    
    // Location
    override var maxX: Double {
        return shapes.reduce(shapes.first!.maxX) { max($0, $1.maxX) }
    }
    
    override var minX: Double {
        return shapes.reduce(shapes.first!.minX) { min($0, $1.minX) }
    }
    
    override var maxY: Double {
        return shapes.reduce(shapes.first!.maxY) { max($0, $1.maxY) }
    }
    
    override var minY: Double {
        return shapes.reduce(shapes.first!.minY) { min($0, $1.minY) }
    }
    
    // Translation
    override func translate(_ point: Point) {
        shapes.mutate{ $0.translate(point) }
    }
    
    override func mirror(plane: Line) {
        shapes.mutate{ $0.mirror(plane: plane) }
    }
    
    override func rotate(radians: Double, aroundPoint point: Point = .origin) {
        shapes.mutate{ $0.rotate(radians: radians, aroundPoint: point) }
    }
    
    override func scale(_ factor: Double) {
        shapes.mutate{ $0.scale(factor) }
        
        if (style?.strokeWidth != nil) {
            style!.strokeWidth! *= factor
        }
    }
    
    // Copy
    override func copy() -> Group {
        return Group(shapes: shapes.map{$0.copy()}, style: style)
    }
    
    //MARK: - Private Funcs
    private func validateShapes() {
        assert(shapes.count > 0, "Error: Groups must contain at least 1 shape.")
    }
}
