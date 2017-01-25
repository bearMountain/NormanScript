







func lineTest() {
    let l1 = Line(start: p(100,100), end: p(200,200), style: nil)
    let l2 = Line(start: p(5,100), end: p(50,50))
//    let lines = [l1, l2]
    
    let lines = Group(shapes: [l1, l2], style: Style(strokeColor: .red, strokeWidth: 12))
//    lines.translate(p(-5,-50))
//    lines.scale(6)

    let lines2 = lines.copy()
    lines2.scale(2)
    
    let lines3 = lines.copy()
    lines3.scale(3)
    
    lines3.shapes = [Line(start: .origin, end: p(33,88))]
    
    
    ship([lines, lines2, lines3])
}

lineTest()


