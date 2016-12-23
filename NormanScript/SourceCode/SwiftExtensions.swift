



import Foundation

extension Double {
    var half: Double {
        return self/2.0
    }
    
    var doubled: Double {
        return self*2.0
    }
    
    var squared: Double {
        return pow(self, 2)
    }
    
    var radians: Double {
        return self*Double.pi / 180.0
    }
}

extension Array {
    mutating func mutate(f: (inout Element)->()) {
        for i in 0..<self.count {
            f(&self[i])
        }
    }
}
