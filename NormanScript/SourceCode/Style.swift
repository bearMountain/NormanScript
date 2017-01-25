



import Foundation


struct Style {
    var strokeColor: Color?
    var strokeWidth: Double?
    var fillColor: Color?
    
    init(strokeColor: Color? = nil, strokeWidth: Double? = nil, fillColor: Color? = nil) {
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.fillColor = fillColor
    }
}

extension Style {
    static var standard: Style {
        return Style(strokeColor: .black, strokeWidth: 1, fillColor: .gray)
    }
}





