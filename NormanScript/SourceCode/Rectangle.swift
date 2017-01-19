



import Foundation


class Rectangle: Trapezoid {
    init(length: Double, width: Double, cornerRadius: Double = 0) {
        super.init(corners: [
            .origin,
            p(length, 0),
            p(length, width),
            p(0, width)
            ])
    }
}
