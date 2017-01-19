



import Foundation

//
// Custom Paperweight Object
// Design in NormanScript
//
func makePaperweight() {
    // Dimensions
    let legWidth = 1.0
    let mainLength = legWidth*5.0
    let mainWidth = legWidth*2.0
    let mainHeight = legWidth*3.0
    let spacer = 0.2
    
    // Side Creation
    let top = Rectangle(length: mainLength, width: mainWidth)
    let side1 = Rectangle(length: mainWidth, width: mainHeight)
    let side2 = side1.copy()
    let bottom1 = Rectangle(length: mainWidth, width: legWidth)
    let bottom2 = bottom1.copy()
    let innerSide1 = Rectangle(length: mainWidth, width: mainHeight-legWidth)
    let innerSide2 = innerSide1.copy()
    let underside = Rectangle(length: mainLength-legWidth.doubled, width: mainWidth)
    
    let face1 = Polygon(points: [
        .origin,
        p(mainLength, 0),
        p(mainLength, mainHeight),
        p(mainLength-legWidth, mainHeight),
        p(mainLength-legWidth, legWidth),
        p(legWidth, legWidth),
        p(legWidth, mainHeight),
        p(0, mainHeight),
        ])
    let face2 = face1.copy()
    
    // Layout
    side1.translate(p(0, top.maxY+spacer))
    side2.translate(p(side1.maxX+spacer, side1.minY))
    bottom1.rotate(radians: 90.radians, aroundPoint: .origin)
    bottom1.translate(p(top.maxX+spacer+abs(bottom1.minX), 0))
    bottom2.rotate(radians: 90.radians, aroundPoint: .origin)
    bottom2.translate(p(bottom1.maxX+spacer+abs(bottom2.minX), 0))
    innerSide1.translate(p(side2.maxX+spacer, side2.minY))
    innerSide2.translate(p(innerSide1.maxX+spacer, innerSide1.minY))
    underside.translate(p(0, side1.maxY+spacer))
    face1.translate(p(innerSide1.minX, innerSide1.maxY+spacer))
    face2.rotate(radians: 180.radians, aroundPoint: face2.center)
    face2.translate(p(underside.maxX+spacer, underside.minY+spacer))
    
    let sides = [top, side1, side2, bottom1, bottom2, innerSide1, innerSide2, underside, face1, face2]
    
    ship(sides)
}
