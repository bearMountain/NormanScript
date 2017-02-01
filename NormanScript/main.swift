

import Darwin

let numZigs = 20
let zigHeight = 250.0
let zigWaveSpace = 11.0
let paperWidth = 425.0
let paperHeight = 550.0



class ColorPalette {
    func nextColor() -> Color {
        if let next = workingSet.popLast() {
            return next
        } else {
            workingSet = colors.shuffled()
            return nextColor()
        }
    }
    
    
    
    // Private Vars
    private var workingSet: [Color] = []
    private let colors = [
        color255(61, 93, 127),  // Navy
        color255(118, 177, 96), // Green
        color255(214, 174, 92), // Orange
        color255(62, 60, 49),   // Black
        color255(218, 201, 191),// Beige
        color255(227, 200, 69), // Yellow
        color255(169, 116, 90), // Brown
        color255(218, 105, 69), // Burnt Orange
        color255(146, 170, 188),// Light Blue
        color255(177, 135, 177),// Purple
    ]
}



func makeMoDrawing() {
    let zig = makeZig()
    
    // Viewable
    let inset = 0.0
    zig.translate(p(zig.width.half+inset, zig.height.half+inset))
    
    // Make sheet of paper
    let (paper, paperClipper) = makePaperAndClipper()
    
    let clippedZig = ClippedShape(shape: zig, clipPath: paperClipper)
    
    let piece = [paper, clippedZig]
    
    
    ship(piece)
}

func makePaperAndClipper() -> (Shape, Shape) {
    let paperStyle = Style(fillColor: .beige)
    let paper = Rectangle(width: paperWidth, height: paperHeight, cornerRadius: 30, style: paperStyle)
    
    paper.translate(p(paper.width.half, 0))
    
    let clipperWidthInset = paper.width * 0.03
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
    let drawableLines = Group(shapes: lines, style: Style(strokeColor: .gray, strokeWidth: 12, lineJoin: .bevel))
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

func makeGrid() {
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
    grid.scale(scale)
    
    let inset = 30.0
    grid.translate(p(inset, inset))
    
    ship(grid)
}

makeGrid()










