



import Foundation

enum LineCap: String {
    case butt = "butt"
    case square = "square"
    case round = "round"
}


struct Style {
    var strokeColor: Color?
    var strokeWidth: Double?
    var fillColor: Color?
    var lineCap: LineCap?
    
    init(strokeColor: Color? = nil, strokeWidth: Double? = nil, fillColor: Color? = nil, lineCap: LineCap? = nil) {
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.fillColor = fillColor
        self.lineCap = lineCap
    }
}

// SVG Exportable
extension Style: SVGExportable {
    func generateSVG() -> String {
        var svgString = ""
        
        if let strokeColor = strokeColor {
            svgString.append("stroke=\"\(strokeColor.generateSVG())\" ")
        }
        
        if let strokeWidth = strokeWidth {
            svgString.append("stroke-width=\"\(strokeWidth)\" ")
        }
        
        if let fillColor = fillColor {
            svgString.append("fill=\"\(fillColor)\" ")
        }
        
        if let lineCap = lineCap {
            svgString.append("stroke-linecap=\"\(lineCap.rawValue)\" ")
        }
        
        return svgString
    }
}

// Static Variables
extension Style {
    static var standard: Style {
        return Style(strokeColor: .black, strokeWidth: 1, fillColor: .gray, lineCap: .round)
    }
}





