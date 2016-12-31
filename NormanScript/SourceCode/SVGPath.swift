



import Foundation

class SVGPath {
    //MARK: - Public Var
    var string: String {
        return "<path d=\"\(pathString)\" fill=\"none\" stroke=\"black\" stroke-width=\"1\" />"
    }
    
    //MARK: - Public Funcs
    func move(toPoint point: Point) {
        pathString += "M\(point.x),\(point.y)"
    }
    
    func addCurve(controlPoint: Point, endPoint: Point) {
        pathString += "S\(controlPoint.x),\(controlPoint.y) \(endPoint.x),\(endPoint.y)"
    }
    
    func addLine(toPoint point: Point) {
        pathString += "L\(point.x),\(point.y)"
    }
    
    func close() {
        pathString += "Z"
    }
    
    //MARK: - Private Var
    private var pathString = ""
}
