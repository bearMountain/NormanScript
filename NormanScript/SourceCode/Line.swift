



import Foundation


struct Line {
    let start: Point
    let end: Point
}

extension Line: Shape {
    //
    // <line x1="50" y1="50" x2="200" y2="200" stroke="blue" stroke-width="4" />
    //
    func generateSVG() -> String {
        //        return "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" stroke=\"blue\" stroke-width=\"1\" />"
        return "<line x1=\"\(self.start.x)\" y1=\"\(self.start.y)\" x2=\"\(self.end.x)\" y2=\"\(self.end.y)\" />"
    }
}
