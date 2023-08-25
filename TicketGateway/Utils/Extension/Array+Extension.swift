//
//  Array+Extension.swift
//  TicketGateway
//
//  Created by Apple on 10/07/23.
//

import UIKit

extension Array {
    func unique(selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
    
    mutating func appendAtBeginning(newItem : [Element]){
        let copy = self
        self = []
        self.append(contentsOf: newItem)
        self.append(contentsOf: copy)
    }
}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
