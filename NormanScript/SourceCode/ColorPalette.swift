



import Foundation

class ColorPalette {
    // Public Func
    func nextColor() -> Color {
        if let next = workingSet.popLast() {
            return next
        } else {
            workingSet = colors.shuffled()
            return nextColor()
        }
    }
    
    // Private Vars
    private var workingSet: [Color] = []
    private let colors = [
        color255(61, 93, 127),  // Navy
        color255(118, 177, 96), // Green
        color255(214, 174, 92), // Orange
        color255(62, 60, 49),   // Black
        color255(218, 201, 191),// Beige
        color255(227, 200, 69), // Yellow
        color255(169, 116, 90), // Brown
        color255(218, 105, 69), // Burnt Orange
        color255(146, 170, 188),// Light Blue
        color255(177, 135, 177),// Purple
    ]
}
