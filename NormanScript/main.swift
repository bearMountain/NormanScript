



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"

struct Trapezoid: Shape {
    var corners: [Point]
    var cornerRadius: Double = 0
    var maxY: Double {
        var maxY = corners[0].y
        for corner in corners {
            maxY = max(maxY, corner.y)
        }
        return maxY
    }
    var minY: Double {
        var minY = corners[0].y
        for corner in corners {
            minY = min(minY, corner.y)
        }
        return minY
    }
    
    func generateSVG() -> String {
        // Helper Funcs
        func S(controlPoint: Point, endPoint: Point) -> String {
            return "S\(controlPoint.x),\(controlPoint.y) \(endPoint.x),\(endPoint.y)"
        }
        
        func L(_ point: Point) -> String {
            return "L\(point.x),\(point.y)"
        }
        
        // Trapezoid Sanity Check
        if (corners.count != 4) {
            assertionFailure("Trapezoid must have 4 corners.")
        }
        
        // Path Generation
        let pathStringStart = "<path d=\""
        let pathStringEnd = "z\" fill=\"none\" stroke=\"black\" stroke-width=\"1\" />"
        var path = ""
        let radius = cornerRadius
        
        let p0_1 = interpolatedPoint(startPoint: corners[0], endPoint: corners[3], distance: radius)
        let p0_2 = interpolatedPoint(startPoint: corners[0], endPoint: corners[1], distance: radius)
        
        let p1_1 = interpolatedPoint(startPoint: corners[1], endPoint: corners[0], distance: radius)
        let p1_2 = interpolatedPoint(startPoint: corners[1], endPoint: corners[2], distance: radius)
        
        let p2_1 = interpolatedPoint(startPoint: corners[2], endPoint: corners[1], distance: radius)
        let p2_2 = interpolatedPoint(startPoint: corners[2], endPoint: corners[3], distance: radius)
        
        let p3_1 = interpolatedPoint(startPoint: corners[3], endPoint: corners[2], distance: radius)
        let p3_2 = interpolatedPoint(startPoint: corners[3], endPoint: corners[0], distance: radius)
        
        path += "M\(p0_1.x),\(p0_1.y)"
        path += S(controlPoint: corners[0], endPoint: p0_2)
        path += L(p1_1)
        path += S(controlPoint: corners[1], endPoint: p1_2)
        path += L(p2_1)
        path += S(controlPoint: corners[2], endPoint: p2_2)
        path += L(p3_1)
        path += S(controlPoint: corners[3], endPoint: p3_2)
        
        return pathStringStart + path + pathStringEnd
    }
    
    mutating func translate(_ point: Point) {
        corners.mutate { corner in
            corner.translate(point)
        }
    }
    
    func rotate(radians: Double, aroundPoint point: Point) {
        
    }
    
    func mirror(plane: LineSegment) {
        
    }
    
    mutating func scale(_ factor: Double) {
        corners.mutate { corner in
            corner.scale(factor)
        }
    }
}


struct MainFace {
    static let taper = 14.5
    static let bottomWidth = 30.0
    static let height = 42.625
}

struct BottomCutout {
    static let width = 25.125
    static let height = 8.6875
    static let radius = 4.0
    static let bottomSpacer = 1.0
}

struct MiddleCutout {
    static let width = 19.625
    static let height = 11.5625
    static let bottomSpacer = 2.0
}


func trapezoid(topWidth: Double, bottomWidth: Double, height: Double) -> Trapezoid {
    let corners = [
        p(-bottomWidth.half, height),
        p(-topWidth.half, 0),
        p(topWidth.half, 0),
        p(bottomWidth.half, height)
    ]
    
    return Trapezoid(corners: corners, cornerRadius: 0)
}

func trapezoid(bottomWidth: Double, height: Double, taper: Double) -> Trapezoid {
    let cuttofWidth = tan(taper.radians)*height
    
    let corners = [
        p(-bottomWidth.half, height),
        p(-bottomWidth.half+cuttofWidth, 0),
        p(bottomWidth.half-cuttofWidth, 0),
        p(bottomWidth.half, height)
    ]
    
    return Trapezoid(corners: corners, cornerRadius: 0)
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Construction ///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Main
var mainFace = trapezoid(bottomWidth: MainFace.bottomWidth, height: MainFace.height, taper: MainFace.taper)

// Bottom Cutout
var bottomCutout = trapezoid(bottomWidth: BottomCutout.width, height: BottomCutout.height, taper: MainFace.taper)
bottomCutout.cornerRadius = BottomCutout.radius
bottomCutout.translate(p(0, MainFace.height-BottomCutout.height-BottomCutout.bottomSpacer))

// Middle Cutout
var middleCutout = trapezoid(bottomWidth: MiddleCutout.width, height: MiddleCutout.height, taper: MainFace.taper)
middleCutout.cornerRadius = BottomCutout.radius
middleCutout.translate(p(0, bottomCutout.minY-MiddleCutout.height-MiddleCutout.bottomSpacer))

// Slits
func slit(vertSpacer: Double) -> Trapezoid {
    let slitHeight = 1.0
    let newEdgePoint = interpolatedPoint(startPoint: middleCutout.corners[0], endPoint: middleCutout.corners[1], distanceFromEndpoint: -vertSpacer)
    let slitWidth = newEdgePoint.x*(-2.0)
    var slit = trapezoid(bottomWidth: slitWidth, height: slitHeight, taper: MainFace.taper)
    slit.cornerRadius = BottomCutout.radius
    slit.translate(p(0, newEdgePoint.y-slitHeight))
    
    return slit
}

let slit1 = slit(vertSpacer: 4)
let slit2 = slit(vertSpacer: 8)
let slit3 = slit(vertSpacer: 12)
let slit4 = slit(vertSpacer: 16)

// Assembly
var completedFace: [Shape] = [mainFace, bottomCutout, middleCutout, slit1, slit2, slit3, slit4]

// Sheet
let sheetWidth = 48.0
let sheetHeight = 96.0
var sheet: Shape = Polygon(points: [
    .origin,
    p(sheetWidth, 0),
    p(sheetWidth, sheetHeight),
    p(0, sheetHeight)
])
sheet.translate(p(-sheetWidth.half, 0))

var everything = [sheet] + completedFace


////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Display Helpers ////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

let scaleFactor = 10.0
let inset = 20.0

everything.mutate { piece in
    piece.scale(scaleFactor)
    piece.translate(p(MainFace.bottomWidth.half*scaleFactor+inset, inset))
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Export /////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

ship(shapes: everything)





