



import Foundation

let numZigs = 20
let zigHeight = 250.0
let zigWaveSpace = 12.0
let zigStrokeWidth = 14.0

let paperWidth = 425.0
let paperHeight = 550.0
let paperRadius = 5.0


func makeMoDrawing() {
    let (paper, paperClipper) = makePaperAndClipper()
    let clippedZig = ClippedShape(shape: makeGrid(), clipPath: paperClipper)
    let piece = [paper, clippedZig]
    
    ship(piece)
}

func makePaperAndClipper() -> (Shape, Shape) {
    let paperStyle = Style(fillColor: .slate)
    let paper = Rectangle(width: paperWidth, height: paperHeight, cornerRadius: paperRadius, style: paperStyle)
    
    paper.translate(p(paper.width.half, 0))
    
    let clipperWidthInset = paper.width * 0.01
    let paperClipper = Rectangle(width: paper.width-clipperWidthInset,
                                 height: paper.height-clipperWidthInset,
                                 cornerRadius: paper.cornerRadius,
                                 style: Style(fillColor: .green))
    paperClipper.translate(p(paperClipper.width.half, 0))
    let paperClipperInset = p((paper.width-paperClipper.width).half, (paper.height-paperClipper.height).half)
    paperClipper.translate(paperClipperInset)
    
    return (paper, paperClipper)
}

func makeZig() -> Shape {
    let lines = makeZigLines(numZigs: numZigs, zigHeight: zigHeight, zigWaveSpace: zigWaveSpace)
    let drawableLines = Group(shapes: lines, style: Style(strokeColor: .gray, strokeWidth: zigStrokeWidth, lineJoin: .bevel))
    drawableLines.translate(p(-drawableLines.width.half, -drawableLines.height.half))
    
    return drawableLines
}

func makeZigLines(numZigs: Int, zigHeight: Double, zigWaveSpace: Double) -> [Line] {
    var lines: [Line] = []
    
    var x: Double = 0
    var y: Double = 0
    
    for i in 1...numZigs {
        let start = p(x, y)
        
        x += zigWaveSpace.random(withDeviationRatio: 1.5)
        let polarity = Double(i % 2)
        let randBonus = zigHeight.random(withDeviationRatio: 0.2) - zigHeight
        y = polarity * zigHeight + randBonus
        let end = p(x, y)
        
        lines.append(Line(start: start, end: end))
    }
    
    return lines
}

func makeGrid() -> Shape {
    let baseWidth = 11
    let numRows = 10
    let xSpacer = zigWaveSpace*Double(numZigs)
    let ySpacer = zigHeight
    
    let colorPalette = ColorPalette()
    
    let pyramidSpacing = [3, 6, 9, 9, 11, 11, 11, 11, 11, 11]
    
    var dots: [Shape] = []
    for y in 0..<numRows {
        for x in 0..<baseWidth {
            let currentPyramid = pyramidSpacing[y]
            if abs(x-5) > currentPyramid/2 {
                continue
            }
            
            let center = p(xSpacer*Double(x), ySpacer*Double(y))
            let zig = makeZig()
            zig.translate(center)
            zig.style?.strokeColor = colorPalette.nextColor()
            
            dots.append(zig)
        }
    }
    
    let grid = Group(shapes: dots)
    
    let scale = paperWidth/grid.width
    grid.scale(scale+0.03)
    
    grid.rotate(degrees: 40, aroundPoint: p(grid.minX, grid.maxY))
    grid.translate(p(-240, -100))
    
    return grid
}
