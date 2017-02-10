



import Foundation


func reverse(line: [Line]) -> [Line] {
    var copy = Array(line.reversed())
    copy.mutate { line in
        let point = line.start
        line.start = line.end
        line.end = point
    }
    
    return copy
}

func makeDragonCurve() {
    let segmentLength = 5.0
    
    let lineStyle = Style(strokeWidth: 2)
    let line = Line(start: .origin, end: p(segmentLength, 0), style: lineStyle)
    var lines: [Line] = [line]
    
    for _ in 0..<19 {
        let reversedLines = reverse(line: lines)
        var linesCopy = reversedLines.map{ $0.copy() }
        
        linesCopy.mutate { line in
            line.rotate(degrees: 90, aroundPoint: lines.last!.end)
        }
        
        lines = lines + linesCopy
    }
    
    lines.mutate { line in
        line.translate(p(900,500))
    }
    
    var c = Color.black
    
    let palette = ColorPalette()
    
    for line in lines {
        c.b += 0.0001
        line.style?.strokeColor = palette.nextColor()
    }

    
    ship(lines)
}







































