//
//  Extensions.swift
//  Instagram
//
//  Created by Roy Park on 3/6/21.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return left + width
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return top + height
    }
    
}

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-")
            .replacingOccurrences(of: "#", with: "-")
            .replacingOccurrences(of: "[", with: "-")
            .replacingOccurrences(of: "]", with: "-")
            .replacingOccurrences(of: "$", with: "-")
    }
}
