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
DispatchQueue.concurrentPerform(iterations: 5) { (index) in
    safeArray.append(element: index)
}
print("safeArray: \(safeArray.elements)")

//without barrier
var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 5) { (index) in
    array.append(index)
}
print("array: \(array)")
//-----------------------------------------------------------
// Groups
let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}


group.notify(queue: .main) {
    print("All done in group: group")
}

let secondGroup = DispatchGroup()
secondGroup.enter()
queue.async(group: secondGroup) {
    for i in 0...30 {
        if i == 30 {
            sleep(2)
            print(i)
            secondGroup.leave()
        }
    }
}

var result = secondGroup.wait(timeout: .now() + 1)
print(result)

secondGroup.notify(queue: .main) {
    print("All done in group: secondGroup")
}
print("This print should be above")

secondGroup.wait()

print("Last print")
