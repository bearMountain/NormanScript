# NormanScript
##A Swift framework to generate 2D Drawings  
Code in [Xcode](https://developer.apple.com/xcode/), export to [.stl](https://en.wikipedia.org/wiki/STL_(file_format))
<br>

##Use precise measurements and mathematics
```
let pentagon = Pentagon(radius: 100)
let delta = Double.pi*2/5

var flower: [Pentagon] = []

for i in 0..<5 {
    let j1 = i
    let j2 = (i+1) < 5 ? i+1 : 0
    let plane = LineSegment(start: pentagon.points[j1], end: pentagon.points[j2])
    var p1 = pentagon
    p1.rotate(radians: delta*Double(i+1), aroundPoint: .origin)
    p1.mirror(plane: plane)
    flower.append(p1)
}
```


##To generate mechanical models

<img src="https://github.com/bearMountain/NormanScript/blob/master/GitResources/Screen%20Shot%202016-12-09%20at%2011.26.26%20AM.png" width="500">
<br><br><br>

##Or write elegant code
```
let s1 = LineSegment(start: p(segmentLength, 0), end: origin, strokeColor: strokeColor, strokeWidth: strokeWidth)
var l1 = Line(segments: [s1])

for _ in 0..<12 {
    // Duplicate Line
    var l2 = l1
    
    // Rotate Line around previous line endpoint
    l2.rotate(radians: Double.pi.half, aroundPoint: l1.endpoint)
    
    // Reverse l2 point ordering
    l2.reverse()
    
    // Join lines
    l1 = Line(segments: l1.segments+l2.segments)
}
```

##To generate intricate drawings 

<img src="https://github.com/bearMountain/NormanScript/blob/master/GitResources/Screen%20Shot%202016-12-09%20at%2011.02.52%20AM.png" width="500">
<br><br><br>


Created by [Jeff Camealy](https://www.branchcomputing.com) 
