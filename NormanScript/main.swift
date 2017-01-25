






func trapTest() {
    let points = [
        .origin,
        p(10,0),
        p(10,20),
        p(100,100),
        p(10, 80)
    ]
    let poly = Polyline(points: points)
    poly.scale(3)
    
    ship(poly)
}

trapTest()


