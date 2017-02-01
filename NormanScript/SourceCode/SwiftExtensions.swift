



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

extension Array {
    func shuffled() -> Array {
        var array = self
        var shuffled = Array()
        while (array.count > 0) {
            let randomI = (0..<array.count).randomInt
            let item = array.remove(at: randomI)
            shuffled.append(item)
        }
        
        return shuffled
    }
}

extension Range {
    var randomInt: Int {
        get {
            var offset = 0
            
            if (lowerBound as! Int) < 0 {   // allow negative ranges
                offset = abs(lowerBound as! Int)
            }
            
            let mini = UInt32(lowerBound as! Int + offset)
            let maxi = UInt32(upperBound as! Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}
