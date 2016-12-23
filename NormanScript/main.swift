



import Foundation

let ExportPath = "/Users/jeff/Desktop/test.svg"




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

struct Side {
    static let width = MainFace.bottomWidth * 0.8
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

// Side
var side = trapezoid(bottomWidth: Side.width, height: MainFace.height, taper: MainFace.taper)

// Tray
let trayBottom = middleCutout.maxY
let blip = tan(MainFace.taper.radians)*trayBottom
let trayDepth = blip.doubled+1
let trayWidth = 23.5
let trayBumpoutRatio = 0.98
let bumpoutWidth = MiddleCutout.width*trayBumpoutRatio
let bumpoutDepth = 2.0
var trayBase = trapezoid(bottomWidth: trayWidth, height: trayDepth, taper: 0)
var trayBumpout = trapezoid(bottomWidth: bumpoutWidth, height: bumpoutDepth, taper: 0)
trayBumpout.translate(p(0, -bumpoutDepth))


// Assembly
var completedFace = [mainFace, bottomCutout, middleCutout, slit1, slit2, slit3, slit4]

// Move MainFace on sheet
let verticalInset = 1.0
let horizontalInset = 2.0

// Sheet
let sheetWidth = 48.0
let sheetHeight = 96.0
var sheet = Polygon(points: [
    .origin,
    p(sheetWidth, 0),
    p(sheetWidth, sheetHeight),
    p(0, sheetHeight)
])
sheet.translate(p(-sheetWidth.half, 0))

// Move side on sheet
side.rotate(radians: -(90.0+MainFace.taper).radians, aroundPoint: side.corners[1])
side.translate(p(sheet.minX-side.minX+horizontalInset, sheetHeight-horizontalInset))

var side2 = side
side2.rotate(radians: 180.0.radians, aroundPoint: side2.corners[0])

let sideYDim = side.maxY-side.minY

side2.translate(p(side.minX-side2.minX, -MainFace.bottomWidth))




completedFace.mutate { shape in
    shape.rotate(radians: MainFace.taper.radians, aroundPoint: mainFace.corners[1])
    shape.translate(p(0, verticalInset))
}

let shiftToEdge = sheet.maxX-completedFace[0].maxX-horizontalInset
completedFace.mutate { shape in
        shape.translate(p(shiftToEdge,0))
}

// Add Back Plate
var backPlate = mainFace
backPlate.mirror(plane: LineSegment(start: p(0, MainFace.height.half), end: p(1, MainFace.height.half)))
backPlate.rotate(radians: MainFace.taper.radians, aroundPoint: backPlate.corners[0])
let shiftLeft = sheet.minX-backPlate.minX+horizontalInset
backPlate.translate(p(shiftLeft, verticalInset))

// Place on Sheet
//var everything = [sheet as Shape]
//everything += completedFace
//everything += [backPlate as Shape]
//everything += [side as Shape]
//everything += [side2 as Shape]
//everything += [trayBase as Shape]
//everything += [trayBumpout as Shape]

var everything: [Any] = completedFace + [sheet, backPlate, side, side2, trayBase, trayBumpout]
//everything += completedFace
//everything += [backPlate as Shape]
//everything += [side as Shape]
//everything += [side2 as Shape]
//everything += [trayBase as Shape]
//everything += [trayBumpout as Shape]


////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Display Helpers ////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

let scaleFactor = 10.0
let inset = 0.0

var e2: [Translatable] = everything as! [Translatable]

e2.mutate { piece in
    piece.scale(scaleFactor)
    piece.translate(p(MainFace.bottomWidth.half*scaleFactor+inset, inset))
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Export /////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

ship(shapes: e2)





//var sideAndFront = [side, mainFace]
//
//sideAndFront.mutate { piece in
//    piece.scale(10)
//    piece.translate(p(mainFace.maxX.doubled, 30))
//}
//
//sideAndFront.mutate { piece in
//    piece.translate(p(sideAndFront[1].maxX.doubled, 30))
//}
//
//ship(shapes: sideAndFront)





