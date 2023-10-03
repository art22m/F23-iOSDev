import Foundation

// Task 1

// Class with generic

class Node<T> {
    
    var next: Node?
    var value: T
    
    init(value: T) {
        self.next = nil
        self.value = value
    }
    
}

class MyQueue<T> {
    
    private var len: Int
    private var head: Node<T>?
    private var tail: Node<T>?
    
    init() {
        self.head = nil
        self.tail = nil
        self.len = 0
    }
    
    func enqueue(value: T) {
        let node = Node<T>(value: value)
        
        if len == 0 {
            head = node
            tail = head
        } else {
            tail?.next = node
            tail = tail?.next
        }
        
        len += 1
    }
    
    func dequeue() -> T? {
        guard len > 0 else {
            return nil
        }
        
        let res = head?.value
        if len == 1 {
            head = nil
            tail = nil
        } else {
            head = head?.next
        }
        
        len -= 1
        return res
    }
    
}

// Extension with generic

extension MyQueue where T: Comparable {
    
    func `max`() -> T? {
        guard len > 0 else {
            return nil
        }
        
        var res = head!.value
        
        var ptr = head?.next
        while ptr != nil {
            if let val = ptr?.value, val > res {
                res = val
            }
            ptr = ptr?.next
        }
        
        return res
    }
    
}

// Example of usage

let queue = MyQueue<Int>()
queue.enqueue(value: 1)
queue.enqueue(value: 5)

let maxVal = queue.max()
print(maxVal ?? "nil")

let deq1 = queue.dequeue()
print(deq1 ?? "nil")

let deq2 = queue.dequeue()
print(deq2 ?? "nil")

let deq3 = queue.dequeue()
print(deq3 ?? "nil")


// Task 2

// Protocols with associated types

protocol Printable {
    
    func printElements()
    
}

protocol Appendable {
    
    associatedtype Item
    
    func append(item: Item)
    
}

class StringsCollection: Printable, Appendable {
    
    private var arr: [String] = []
    
    func append(item: String) {
        arr.append(item)
    }
    
    func printElements() {
        print(arr)
    }
    
}

class IntCollection: Printable, Appendable {
    
    private var arr: [Int] = []
    
    func append(item: Int) {
        arr.append(item)
    }
    
    func printElements() {
        print(arr)
    }
    
}

// Usage example


func printAllCollections(collections: Printable...) {
    for collection in collections {
        collection.printElements()
    }
}


var col1 = StringsCollection()
col1.append(item: "hello")
col1.append(item: "music")

var col2 = IntCollection()
col2.append(item: 1)
col2.append(item: 4)

printAllCollections(collections: col1, col2)


// Type erasure

class AnyCollection<Item>: Appendable, Printable {
    
    private var _append: (Item) -> Void
    private var _printElements: () -> Void
    
    init<T: Appendable & Printable>(_ collection: T) where T.Item == Item {
        _append = collection.append
        _printElements = collection.printElements
    }
    
    func append(item: Item) {
        _append(item)
    }
    
    func printElements() {
        _printElements()
    }
    
}

var col3 = AnyCollection<String>(col1)
var col4 = AnyCollection<Int>(col2)
