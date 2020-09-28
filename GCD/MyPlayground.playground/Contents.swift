//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//barrier
class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync {
            result = self.array
        }
        return result
    }
}
var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    safeArray.append(element: index)
}
print("safeArray: \(safeArray.elements)")

//without barrier
var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    array.append(index)
}
print("array: \(array)")
