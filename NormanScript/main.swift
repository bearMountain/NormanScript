



let numZigs = 20
let zigHeight = 100.0
let zigWaveSpace = 25.0

func makeZigs() {
    let lines = makeLines()
    
    let drawableLines = Group(shapes: lines, style: Style(strokeColor: .gray, strokeWidth: 3, lineJoin: .bevel))
    drawableLines.translate(p(-drawableLines.width.half, drawableLines.height.half))
    
    // Viewable
    let inset = 100.0
    drawableLines.translate(p(drawableLines.width.half+inset, drawableLines.height.half+inset))
    
    ship(drawableLines)
}

func makeLines() -> [Line] {
    var lines: [Line] = []
    
    var x: Double = 0
    var y: Double = 0
    
    for i in 1...numZigs {
        let start = p(x, y)
        
        x += zigWaveSpace
        y = Double(i % 2) * -zigHeight
        let end = p(x, y)
        
        lines.append(Line(start: start, end: end))
    }
    
    return lines
}

makeZigs()

