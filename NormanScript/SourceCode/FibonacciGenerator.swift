



import Foundation


class FibonacciGenerator {
    // Public Funcs
    func next() -> Int {
        
        // Bootstrapping Case
        switch bootstrapI {
        case 0:
            bootstrapI += 1
            return 0
        case 1:
            bootstrapI += 1
            return 1
        default:
            break
        }
        
        // Max Value
        if (back1 >= 7540113804746346429) {
            return back1
        }
        
        let new = back1+back2
        back2 = back1
        back1 = new
        
        return new
    }
    
    private var back1 = 1
    private var back2 = 0
    private var bootstrapI = 0
}
