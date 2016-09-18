



import Foundation


struct Circle {
    let diameter: Double
    let center: Point
}

extension Circle: Shape {
    //
    // <circle cx="125" cy="125" r="75" fill="orange" />
    //
    func generateSVG() -> String {
        return "<circle cx=\"\(center.x)\" cy=\"\(center.y)\" r=\"\(diameter.half)\"/>"
    }
}
