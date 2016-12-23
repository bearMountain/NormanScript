



import Foundation

extension String {
    //
    // <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
    // ...
    // </svg>
    //
    func addSVGTags() -> String {
        let begin = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">"
        let end = "</svg>"
        
        return begin + "\n" + self + "\n" + end
    }
    
    //
    // Write to `ExportPath` on disc
    //
    func export() {
        ExportPath.createFile()
        do {
            try self.write(toFile: ExportPath, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error)
        }
    }
    
    //
    // Create file at `self` path
    //
    func createFile() {
        FileManager.default.createFile(atPath: self, contents: nil, attributes: nil)
    }
}

extension String {
    //
    // <g id="group1" stroke="red" stroke-width="5">
    // ...
    // </g>
    //
    func groupWithProperties(_ properties: [String: Any]) -> String {
        var propertiesString = ""
        for (key, value) in properties {
            propertiesString += (key + "=\"\(value)\" ")
        }
        
        let begin = "<g \(propertiesString)>"
        let end = "</g>"
        
        return begin + "\n" + self + "\n" + end
    }
}

extension Array where Element: SVGExportable {
    func ship() {
        self.map{$0.generateSVG()}.joined(separator: "\n").addSVGTags().export()
    }
}

func ship(shapes: [Any]) {
    let s = shapes as! [SVGExportable]
    s.map{$0.generateSVG()}.joined(separator: "\n").addSVGTags().export()
    print("Shipped sucka.")
}

func ship(_ shape: SVGExportable) {
    ship(shapes: [shape])
}
