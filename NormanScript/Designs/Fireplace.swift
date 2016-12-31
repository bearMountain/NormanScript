



import Foundation

////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Dimensions /////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct MainFace {
    static let taper = 14.5
    static let bottomWidth = 30.0
    static let height = 42.625
}

struct BottomCutout {
    static let width = 25.125
    static let height = 8.6875
    static let radius = 1.0
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
    let slit = trapezoid(bottomWidth: slitWidth, height: slitHeight, taper: MainFace.taper)
    slit.cornerRadius = BottomCutout.radius.half
    slit.translate(p(0, newEdgePoint.y-slitHeight))
    
    return slit
}

let slit1 = slit(vertSpacer: 4)
let slit2 = slit(vertSpacer: 8)
let slit3 = slit(vertSpacer: 12)
let slit4 = slit(vertSpacer: 16)

// Assembly
var completedFace = [mainFace, bottomCutout, middleCutout, slit1, slit2, slit3, slit4]

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


// Move MainFace on sheet
let verticalInset = 1.0
let horizontalInset = 2.0

// Sheet
let sheetWidth = 48.0
let sheetHeight = 96.0
let sheet = Polygon(points: [
    .origin,
    p(sheetWidth, 0),
    p(sheetWidth, sheetHeight),
    p(0, sheetHeight)
    ])
sheet.translate(p(-sheetWidth.half, 0))

// Move side on sheet
side.rotate(radians: -(90.0+MainFace.taper).radians, aroundPoint: side.corners[1])
side.translate(p(sheet.minX-side.minX+horizontalInset, sheetHeight-horizontalInset))

var side2 = side.copy()
side2.rotate(radians: 180.0.radians, aroundPoint: side2.corners[0])

let sideYDim = side.maxY-side.minY

side2.translate(p(side.minX-side2.minX, -MainFace.bottomWidth))


// Add Back Plate
var backPlate = mainFace.copy()
backPlate.mirror(plane: Line(start: p(0, MainFace.height.half), end: p(1, MainFace.height.half)))
backPlate.rotate(radians: MainFace.taper.radians, aroundPoint: backPlate.corners[0])
let shiftLeft = sheet.minX-backPlate.minX+horizontalInset
backPlate.translate(p(shiftLeft, verticalInset))

// Shift Face
completedFace.mutate { shape in
    shape.rotate(radians: MainFace.taper.radians, aroundPoint: mainFace.corners[1])
    shape.translate(p(0, verticalInset))
}

let shiftToEdge = sheet.maxX-completedFace[0].maxX-horizontalInset
completedFace.mutate { shape in
    shape.translate(p(shiftToEdge,0))
}



//// Place on Sheet
var everything = completedFace + [sheet, backPlate, side, side2] as [Shape]

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Display Helpers ////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

everything.mutate { shape in
    shape.scale(7)
    shape.translate(p(500, 15))
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Export /////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


//ship(everything)

let trayCenterWidth = 18.125
let trayCenterDepth = 14.75
let flapAngle = 60.0

/////////
// Flaps
/////////
let additionalFlapDist = 1.0/tan(flapAngle.radians)
let sideBase = trayCenterDepth+additionalFlapDist.doubled
let bottomBase = trayCenterWidth+additionalFlapDist.doubled

let leftBar = trapezoid(bottomWidth: sideBase, height: 1, taper: 90-flapAngle)
let bottomBar = trapezoid(bottomWidth: bottomBase, height: 1, taper: 90-flapAngle)


///////
// Rack
///////
let rack = trapezoid(bottomWidth: trayCenterWidth, height: trayCenterDepth, taper: 0)



var pieces = [leftBar, bottomBar, rack]
pieces.mutate { flap in
    flap.scale(10)
}


//ship(pieces)
let additional = 3.0
let bottom = trapezoid(bottomWidth: MainFace.bottomWidth+additional, height: Side.width+additional, taper: 0)
bottom.cornerRadius = 1.0

bottom.scale(90)
ship(bottom)
