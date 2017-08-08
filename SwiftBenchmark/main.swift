//
//  main.swift
//  SwiftBenchmark
//
//  Created by Brendon Matusch on 2017-08-07.
//  Copyright © 2017 Brendon Matusch. All rights reserved.
//

import Foundation
import Accelerate

let randomBound: UInt32 = 1_000_000
let divisor: Float = 100
let arrayLength = 100
let numIterations = 100_000_000

func randomFloat() -> Float {
    return Float(arc4random_uniform(randomBound)) / divisor
}

let startingTime = NSDate().timeIntervalSince1970
print("Beginning Swift test")

var x = [Float](repeating: 0, count: arrayLength)
var y = [Float](repeating: 0, count: arrayLength)
for j in 0..<arrayLength {
    x[j] = randomFloat()
    y[j] = randomFloat()
}

for i in 0..<numIterations {
    var result: Float = 0
    vDSP_dotpr(x, 1, y, 1, &result, vDSP_Length(x.count))
}

let endingTime = NSDate().timeIntervalSince1970
print("Swift test complete. Time: \(endingTime - startingTime) seconds.")

print("Beginning C test.")
let cTestTime = secondsToPerformTest(randomBound, divisor, Int32(arrayLength), Int32(numIterations))
print("C test complete. Time: \(cTestTime) seconds.")
