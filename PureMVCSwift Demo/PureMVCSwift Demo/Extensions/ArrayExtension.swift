//
//  ArrayExtension.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 09.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

extension Array
    {
    
    func indexOf <U: Equatable> (item: U) -> Int?
    {
        if item is Element
        {
            return find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
    
    func contains<T : Equatable>(obj: T) -> Bool
    {
        
        let filtered = self.filter { $0 as? T == obj }
        
        return filtered.count > 0
        
    }
    
    mutating func removeObject<U: Equatable>(object: U)
    {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self)
        {
            if let to = objectToCompare as? U
            {
                if object == to
                {
                    index = idx
                }
            }
        }
        
        if(index != nil)
        {
            self.removeAtIndex(index!)
        }
    }
    
    func combine( separator: String ) -> String
    {
        var str : String = ""
        for (idx, item) in enumerate(self)
        {
            str += "\(item)"
            if idx < self.count-1
            {
                str += separator
            }
        }
        return str
    }
}
