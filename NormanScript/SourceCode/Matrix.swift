



import Foundation

struct Matrix {
    let grid: [[Double]]
    var rows: Int {
        return grid[0].count
    }
    
    var columns: Int {
        return grid.count
    }
    
    init(grid: [[Double]]) {
        self.grid = grid
    }
    
    subscript(row: Int, column: Int) -> Double {
        return grid[column][row]
    }
}

// Matrix Convenience Constructors

func m(_ grid: [[Double]]) -> Matrix {
    return Matrix(grid: grid)
}

func m(_ column: [Double]) -> Matrix {
    return Matrix(grid: [column])
}

func m(_ point: Point) -> Matrix {
    return Matrix(grid: [[point.x, point.y]])
}

//
// Currently only works for 2x2 * 2x1
//
func *(lhs: Matrix, rhs: Matrix) -> Matrix {
    var column: [Double] = []

    for row in 0..<lhs.rows {
        var sum = 0.0
        for column in 0..<lhs.columns {
            sum += lhs[row, column] * rhs[column, 0]
        }
        column.append(sum)
    }
    
    return m(column)
}

//
// Currently only works for 2x1
//
func -(lhs: Matrix, rhs: Matrix) -> Matrix {
    let x3 = lhs[0,0]-rhs[0,0]
    let y3 = lhs[1,0]-rhs[1,0]
    
    return m([x3, y3])
}

//
// Currently only works for 2x1
//
func +(lhs: Matrix, rhs: Matrix) -> Matrix {
    let x3 = lhs[0,0]+rhs[0,0]
    let y3 = lhs[1,0]+rhs[1,0]
    
    return m([x3, y3])
}












