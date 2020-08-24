//
//  Logger.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 28/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

class Log {

    static func configureLog(){
       let destination = ConsoleDestination()
       destination.format = "$L $DHH:mm:ss$d $N.$F:$l $M"
       destination.levelString.verbose = "💬"
       destination.levelString.debug = "✳️"
       destination.levelString.info = "ℹ️"
       destination.levelString.warning = "⚠️"
       destination.levelString.error = "❌"
       log.addDestination(destination)
    }
}
