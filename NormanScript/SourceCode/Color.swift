



import Foundation


struct Color {
    var r: Double
    var g: Double
    var b: Double
}

extension Color: SVGExportable {
    //
    // "rgb(205,133,63)"
    //
    func generateSVG() -> String {
        return "rgb(\(Int(r*255.0)),\(Int(g*255.0)),\(Int(b*255.0)))"
    }
}

func c(_ r: Double, _ g: Double, _ b: Double) -> Color {
    return Color(r: r, g: g, b: b)
}

func color255(_ r: Double, _ g: Double, _ b: Double) -> Color {
    return Color(r: r/255.0, g: g/255.0, b: b/255.0)
}

// Default Colors
extension Color {
    static var black: Color {
        return c(0, 0, 0)
    }
    
    static var white: Color {
        return c(1, 1, 1)
    }
    
    static var gray: Color {
        return c(0.5, 0.5, 0.5)
    }
    
    static var red: Color {
        return c(1, 0.2, 0.2)
    }
    
    static var blue: Color {
        return c(0.2, 0.2, 1)
    }
    
    static var beige: Color {
        return c(0.843, 0.831, 0.819)
    }
    
    static var green: Color {
        return c(0.474, 0.674, 0.372)
    }
}





