



import Foundation







func lineTest() {
    let line = Line(start: .origin, end: p(200,200), style: Style(strokeColor: .blue, strokeWidth: 10))
    line.scale(4)
    ship(line)
}

lineTest()
