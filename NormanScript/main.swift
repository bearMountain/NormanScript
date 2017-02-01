

import Darwin

let numZigs = 20
let zigHeight = 100.0
let zigWaveSpace = 25.0


class IDGenerator {
    static var shared = IDGenerator()
    
    func make() -> String {
        n += 1
        return "\(n)"
    }
    
    private var n: Int = -1
}

class ClippedShape: Shape {
    var shape: Shape
    var clipPath: Shape
    
    init(shape: Shape, clipPath: Shape) {
        self.shape = shape
        self.clipPath = clipPath
    }
    
    // SVG Generation
    override func generateSVG() -> String {
        //<defs>
        //  <clipPath id="cut-off-bottom">
        //      <rect x="0" y="0" width="200" height="100" />
        //  </clipPath>
        //</defs>
        //
        //<circle cx="100" cy="100" r="100" clip-path="url(#cut-off-bottom)" />
        let clipPathID = IDGenerator.shared.make()
        shape.style?.clipPathID = clipPathID
        let header = "<defs>\n<clipPath id=\"\(clipPathID)\">"
        let footer = "</clipPath>\n</defs>"
        let defs = header + "\n" + clipPath.generateSVG() + "\n" + footer
        let clippedShapeSVG = defs + "\n" + shape.generateSVG()
        
        return clippedShapeSVG
    }
}

func makeZigs() {
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
    let paper = Rectangle(width: 850, height: 1100, cornerRadius: 30, style: paperStyle)
    paper.scale(0.5)
    
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
    let lines = makeLines(numZigs: 20, zigHeight: 250, zigWaveSpace: 11)
    let drawableLines = Group(shapes: lines, style: Style(strokeColor: .gray, strokeWidth: 12, lineJoin: .bevel))
    drawableLines.translate(p(-drawableLines.width.half, -drawableLines.height.half))
    
    return drawableLines
}

func makeLines(numZigs: Int, zigHeight: Double, zigWaveSpace: Double) -> [Line] {
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


func zigTest() {
    let z1 = makeZig()
    let z2 = makeZig()
    
    z1.translate(p(z1.width, z1.height))
    z2.translate(p(z1.width*2, z1.height))
    
    let zigs = Group(shapes: [z1, z2])

    
    ship(zigs)
}

makeZigs()

