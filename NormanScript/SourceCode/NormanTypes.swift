



import Foundation

//MARK: - Color
struct Color {
    var r: Double
    var g: Double
    var b: Double
}

extension Color {
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

//MARK: - DisplayProperties
struct DisplayProperties {
    var strokeColor: Color?
    var strokeWidth: Double?
    var fillColor: Color?
}





