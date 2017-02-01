



import Foundation


class Rectangle: Trapezoid {
    init(width: Double, height: Double, cornerRadius: Double = 0, style: Style? = nil) {
        super.init(topWidth: width, bottomWidth: width, height: height, cornerRadius: cornerRadius, style: style)
    }
}
