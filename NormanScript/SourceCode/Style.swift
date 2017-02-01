



import Foundation

enum LineCap: String {
    case butt = "butt"
    case square = "square"
    case round = "round"
}

enum LineJoin: String {
    case miter = "miter"
    case round = "round"
    case bevel = "bevel"
}


struct Style {
    var strokeColor: Color?
    var strokeWidth: Double?
    var fillColor: Color?
    var lineCap: LineCap?
    var lineJoin: LineJoin?
    var clipPathID: String?
    
    init(strokeColor: Color? = nil,
         strokeWidth: Double? = nil,
         fillColor: Color? = nil,
         lineCap: LineCap? = nil,
         lineJoin: LineJoin? = nil,
         clipPathID: String? = nil)
    {
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.fillColor = fillColor
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.clipPathID = clipPathID
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
            svgString.append("fill=\"\(fillColor.generateSVG())\" ")
        } else {
            svgString.append("fill=\"none\"  ")
        }
        
        if let lineCap = lineCap {
            svgString.append("stroke-linecap=\"\(lineCap.rawValue)\" ")
        }
        
        if let lineJoin = lineJoin {
            svgString.append("stroke-linejoin=\"\(lineJoin.rawValue)\" ")
        }
        
        if let clipPathID = clipPathID {
            svgString.append("clip-path=\"url(#\(clipPathID))\" ")
        }
        
        return svgString
    }
}

// Static Variables
extension Style {
    static var standard: Style {
        return Style(strokeColor: .black, strokeWidth: 1, fillColor: .gray, lineCap: .round, lineJoin: .round)
    }
}





