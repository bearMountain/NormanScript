



import Foundation

class ClippedShape: Shape {
    var shape: Shape
    var clipPath: Shape
    
    init(shape: Shape, clipPath: Shape) {
        self.shape = shape
        self.clipPath = clipPath
    }
    
    // SVG Generation
    override func generateSVG() -> String {
        //<defs>
        //  <clipPath id="cut-off-bottom">
        //      <rect x="0" y="0" width="200" height="100" />
        //  </clipPath>
        //</defs>
        //
        //<circle cx="100" cy="100" r="100" clip-path="url(#cut-off-bottom)" />
        
        // If ClippedShape has a style, apply it to 'shape'
        if let style = style {
            shape.style = style
        }
        
        let clipPathID = IDGenerator.shared.make()
        shape.style?.clipPathID = clipPathID
        let header = "<defs>\n<clipPath id=\"\(clipPathID)\">"
        let footer = "</clipPath>\n</defs>"
        let defs = header + "\n" + clipPath.generateSVG() + "\n" + footer
        let clippedShapeSVG = defs + "\n" + shape.generateSVG()
        
        return clippedShapeSVG
    }
    
    // Translation
    override func translate(_ point: Point) {
        shape.translate(point)
        clipPath.translate(point)
    }
    
    override func mirror(plane: Line) {
        shape.mirror(plane: plane)
        clipPath.mirror(plane: plane)
    }
    
    override func rotate(radians: Double, aroundPoint point: Point = .origin) {
        shape.rotate(radians: radians, aroundPoint: point)
        clipPath.rotate(radians: radians, aroundPoint: point)
    }
    
    override func scale(_ factor: Double) {
        shape.scale(factor)
        clipPath.scale(factor)
    }
    
    // Location
    //
    // It's unclear exactly what to do here.  I don't have the math for what the
    // 'shape' will look like after it is clipped, so I am unable to return maxX etc
    // for that shape.  Thus, we just pass through the location details of 'shape'
    //
    override var maxX: Double {
        return shape.maxX
    }
    
    override var minX: Double {
        return shape.minX
    }
    
    override var maxY: Double {
        return shape.maxY
    }
    
    override var minY: Double {
        return shape.minY
    }
    
    // Copy
    override func copy() -> ClippedShape {
        return ClippedShape(shape: shape.copy(), clipPath: clipPath.copy())
    }
}

class IDGenerator {
    static var shared = IDGenerator()
    
    func make() -> String {
        n += 1
        return "\(n)"
    }
    
    private var n: Int = -1
}
