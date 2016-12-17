



import Foundation

func makeDragonCurve() {
    let segmentLength = 5.0
    let translatedOrigin = p(600, 300)
    let origin = p(0,0)
    let strokeColor = c(0,0,0)
    let strokeWidth = 1.5
    
    let s1 = LineSegment(start: p(segmentLength, 0), end: origin, strokeColor: strokeColor, strokeWidth: strokeWidth)
    var l1 = Line(segments: [s1])
    
    for _ in 0..<10 {
        // Duplicate Line
        var l2 = l1
        
        // Rotate Line around previous line endpoint
        l2.rotate(radians: Double.pi.half*1.2, aroundPoint: l1.endpoint)
        
        // Reverse l2 point ordering
        l2.reverse()
        
        // Join lines
        l1 = Line(segments: l1.segments+l2.segments)
    }
    
    
    var color = c(0,1,0.5)
    let colorIncriment = 1.0/Double(l1.segments.count)
    for i in 0..<l1.segments.count {
        l1.segments[i].displayProperties?.strokeColor = color
        color.r += colorIncriment
        color.g -= colorIncriment
        color.b += colorIncriment.half
    }
    
    var l3 = l1
    l3.rotate(radians: Double.pi.half.half, aroundPoint: origin)
    l3.translate(translatedOrigin)
    
    
    l1.translate(translatedOrigin)
    
    ship(shapes: [l1])
}
