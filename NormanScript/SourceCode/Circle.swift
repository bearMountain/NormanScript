



import Foundation


class Circle: Shape {
    init(diameter: Double = 10, center: Point = .origin, style: Style? = .standard) {
        self.diameter = diameter
        self._center = center
        super.init()
        self.style = style
    }
    

    var diameter: Double
    var radius: Double {
        return diameter.half
    }
    override var center: Point {
        get {
            return _center
        }
        set {
            _center = newValue
        }
    }
    
    // Necessary to convert Shape's `center` into a readwrite for Circle
    private var _center: Point
    
    // SVG Generation
    override func generateSVG() -> String {
        // <circle cx="125" cy="125" r="75" fill="orange" />
        return "<circle cx=\"\(_center.x)\" cy=\"\(_center.y)\" r=\"\(radius)\" \(style?.generateSVG() ?? "") />"
    }

    // Translation
    override func scale(_ factor: Double) {
        _center.scale(factor)
        diameter = diameter*factor
        
        if (style?.strokeWidth != nil) {
            style!.strokeWidth! *= factor
        }
    }

    override func translate(_ point: Point) {
        _center.translate(point)
    }
    
    override func mirror(plane: Line) {
        _center.mirror(plane: plane)
    }
    
    override func rotate(radians: Double, aroundPoint point: Point){
        _center.rotate(radians: radians, aroundPoint: point)
    }
    
    // Location
    override var maxX: Double {
        return _center.x+diameter.half
    }
    
    override var minX: Double {
        return _center.x-diameter.half
    }
    
    override var maxY: Double {
        return _center.y+diameter.half
    }
    
    override var minY: Double {
        return _center.y-diameter.half
    }
    
    // Copy
    override func copy() -> Shape {
        return Circle(diameter: diameter, center: _center.copy())
    }
}
