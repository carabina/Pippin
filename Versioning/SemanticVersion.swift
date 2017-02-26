//
//  SemanticVersion.swift
//  shared-utils
//
//  Created by Andrew McKnight on 2/26/17.
//  Copyright © 2017 Two Ring Software. All rights reserved.
//

import Foundation

typealias SemanticRevision = UInt

struct SemanticVersion {

    var major: SemanticRevision
    var minor: SemanticRevision
    var patch: SemanticRevision

    static var zero: SemanticVersion {
        return SemanticVersion(major: 0, minor: 0, patch: 0)
    }
    
}

extension SemanticVersion: CustomStringConvertible {

    var description: String {
        return String(format: "%llu.%llu.%llu", major, minor, patch)
    }

}

extension SemanticVersion: LosslessStringConvertible {

    /// Greedily matches major, then minor, then patch, leaving undefined values as 0.
    ///
    /// "A.B.C" -> major: A; minor: B; patch: C
    /// "A.B" -> major: A; minor: B; patch: 0
    /// "A" -> major: A; minor: 0; patch: 0
    init?(_ description: String) {
        major = 0
        minor = 0
        patch = 0

        let components = description.components(separatedBy: ".")

        if components.count == 0 {
            return
        }

        major = components[0].unsignedIntegerValue

        if components.count == 1 {
            return
        }

        minor = components[1].unsignedIntegerValue

        if components.count == 2 {
            return
        }

        patch = components[2].unsignedIntegerValue
    }

}
