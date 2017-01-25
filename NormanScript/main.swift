






func trapTest() {
    
    
    let style = Style(strokeColor: .gray, strokeWidth: 0.5, fillColor: .gray)
    let trap = Trapezoid(topWidth: 100, bottomWidth: 200, height: 88, cornerRadius: 1, style: style)
    trap.translate(p(trap.width.half, 0))

    trap.scale(3)
    trap.translate(p(50, 50))
    
    ship(trap)
}

trapTest()


