//
//  NSDate+DateComponents.h
//  Pippin
//
//  Created by Andrew McKnight on 10/2/16.
//  Copyright © 2016 andrew mcknight. All rights reserved.
//

@import Foundation;

@interface NSDate (DateComponents)

- (NSDateComponents *)dateComponents;
- (NSDateComponents *)dayMonthYearComponents;

@end
