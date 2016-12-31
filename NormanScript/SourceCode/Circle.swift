



import Foundation


class Circle: Shape {
    var diameter: Double
    var center: Point
    
    init(diameter: Double, center: Point) {
        self.diameter = diameter
        self.center = center
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

    //
    // <circle cx="125" cy="125" r="75" fill="orange" />
    //
    override func generateSVG() -> String {
        return "<circle cx=\"\(center.x)\" cy=\"\(center.y)\" r=\"\(diameter.half)\" stroke=\"rgb(0,0,0)\" stroke-width=\"0.5\" />"
    }
}
