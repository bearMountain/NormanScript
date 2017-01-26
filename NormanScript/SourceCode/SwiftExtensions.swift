



import Foundation

extension Double {
    var half: Double {
        return self/2.0
    }
    
    var third: Double {
        return self/3.0
    }
    
    var forth: Double {
        return self/4.0
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

public extension Double {
    //
    // Returns a random floating point number between 0.0 and 1.0, inclusive.
    //
    public static var random: Double {
        get {
            return Double(arc4random()) / 0xFFFFFFFF
        }
    }
    
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    func random(withDeviationRatio deviationRatio: Double) -> Double {
        let deviationRange = self * deviationRatio
        let deviation = Double.random * deviationRange
        return self - deviationRange.half + deviation
    }
}

extension Array {
    mutating func mutate(f: (inout Element)->()) {
        for i in 0..<self.count {
            f(&self[i])
        }
    }
}
