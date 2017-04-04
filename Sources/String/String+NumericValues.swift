//
//  String+NumericValues.swift
//  shared-utils
//
//  Created by Andrew McKnight on 12/18/16.
//  Copyright © 2016 Two Ring Software. All rights reserved.
//

import Foundation

extension String {

    func isAllDigits() -> Bool {
        if self.characters.count == 0 {
            return false
        }

        let nondecimalDigitSet = NSCharacterSet.decimalDigits.inverted

        let nondecimalCharacters = self.characters.filter { char in
            let str = String(char)
            guard let uni = UnicodeScalar(str) else { return false }
            return nondecimalDigitSet.contains(uni)
        }

        return nondecimalCharacters.count == 0
    }

    var doubleValue: Double {
        return (self as NSString).doubleValue
    }

    var intValue: Int32 {
        return (self as NSString).intValue
    }

    /// 0 if no unsigned integer exists.
    var unsignedIntegerValue: UInt {
        var value: UInt64 = 0
        let scanner = Scanner(string: self)
        if scanner.scanUnsignedLongLong(&value) {
            if value == UInt64(ULLONG_MAX) {
                print("[%@] could not extract unsigned integer from %@ due to overflow.", instanceType(self as NSObject), self)
            }

            return UInt(value)
        } else {
            print("[%@] could not extract unsigned integer from %@.", instanceType(self as NSObject), self)
            return 0
        }

    }

}
