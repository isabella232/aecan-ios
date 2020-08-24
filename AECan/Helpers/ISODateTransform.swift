//
//  ISODateTransform.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

open class ISODateTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    private var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
    
    public init() {}
    
    public func transformFromJSON (_ value: Any?) -> Date? {
        guard let dateString = value as? String else { return nil }
        return formatter.date(from: dateString)
    }

    public func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return formatter.string(from: date)
        }
        return nil
    }
}
