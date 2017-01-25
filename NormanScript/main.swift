






func circleTest() {
    let circle = Circle(diameter: 50, center: .origin, style: Style(strokeColor: .black, strokeWidth: 4, fillColor: .red))
    circle.translate(p(circle.radius, circle.radius))
    circle.scale(15)
    
    ship(circle)
}

circleTest()


