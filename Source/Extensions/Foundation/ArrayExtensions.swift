import Foundation

public extension Array where Element: Equatable {
    public func object(atIndex index: Int) -> Element? {
        guard index < count else {
            return nil
        }
        
        return self[index]
    }
    
    public mutating func upsert(_ newElement: Element) {
        if let element = filter({ $0 == newElement }).first,
            let index = index(of: element) {
            remove(at: index)
            insert(newElement, at: index)
        } else {
            append(newElement)
        }
    }
    
    @discardableResult
    public mutating func remove(_ element: Element) -> Bool {
        if let index = index(of: element) {
            remove(at: index)
            return true
        }
        return false
    }

    @discardableResult
    public mutating func remove(_ elements: [Element]) -> Bool {
        var somethingIsRemoved = false
        elements.forEach { element in
            if let index = index(of: element) {
                remove(at: index)
                somethingIsRemoved = true
            }
        }
        return somethingIsRemoved
    }
    
    public func removing(_ element: Element) -> [Element] {
        var copy = Array(self)
        if let index = copy.index(of: element) {
            copy.remove(at: index)
        }
        return copy
    }
    
    public func removing(_ elements: [Element]) -> [Element] {
        var copy = Array(self)
        elements.forEach { element in
            if let index = copy.index(of: element) {
                copy.remove(at: index)
            }
        }
        return copy
    }
}

public extension Array {
    @discardableResult
    public mutating func remove(_ isIncluded: (Element) -> Bool) -> Bool {
        var somethingIsRemoved = false
        for ele in enumerated().reversed() where isIncluded(ele.element) {
            remove(at: ele.offset)
            somethingIsRemoved = true
        }
        return somethingIsRemoved
    }
}
