



import Foundation


class Circle: Shape {
    init(diameter: Double, center: Point) {
        self.diameter = diameter
        self._center = center
    }
    
    var diameter: Double
    override var center: Point {
        get {
            return _center
        }
        set {
            _center = center
        }
    }
    
    // Necessary to convert Shape's `center` into a readwrite for Circle
    private var _center: Point
    
    // SVG Generation
    override func generateSVG() -> String {
        // <circle cx="125" cy="125" r="75" fill="orange" />
        return "<circle cx=\"\(center.x)\" cy=\"\(center.y)\" r=\"\(diameter.half)\" fill=\"none\" stroke=\"rgb(100,0,0)\" stroke-width=\"1.0\" />"
    }

    // Translation
    override func scale(_ factor: Double) {
        center.scale(factor)
        diameter = diameter*factor
    }

    override func translate(_ point: Point) {
        center.translate(point)
    }
    
    override func mirror(plane: Line) {
        center.mirror(plane: plane)
    }
    
    override func rotate(radians: Double, aroundPoint point: Point){
        center.rotate(radians: radians, aroundPoint: point)
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
}
