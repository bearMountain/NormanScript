



import Foundation


class Rectangle: Trapezoid {
    init(width: Double, height: Double, cornerRadius: Double = 0) {
        super.init(topWidth: width, bottomWidth: width, height: height)
    }
}
