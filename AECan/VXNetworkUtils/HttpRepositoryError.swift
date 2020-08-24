//
//  HttpRepositoryError.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HttpRepositoryError: Mappable {
    init()
    var httpStatusCode: Int? { get set }
}
