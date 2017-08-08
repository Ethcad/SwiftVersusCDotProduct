//
//  ctest.c
//  SwiftBenchmark
//
//  Created by Brendon Matusch on 2017-08-07.
//  Copyright © 2017 Brendon Matusch. All rights reserved.
//

#include "ctest.h"
#include <time.h>
#include <stdlib.h>

float randomFloat(uint32_t randomBound, float divisor) {
    int random = rand() % randomBound;
    return (float)random / divisor;
}

float dotProduct(float *x, float *y, int length) {
    float result = 0;
    for (int i = 0; i < length; i++) {
        result += x[i] * y[i];
    }
    return result;
}

float secondsToPerformTest(uint32_t randomBound, float divisor, int arrayLength, int numIterations) {
    float x[arrayLength];
    float y[arrayLength];
    srand(time(NULL));
    
    for (int j = 0; j < arrayLength; j++) {
        x[j] = randomFloat(randomBound, divisor);
        y[j] = randomFloat(randomBound, divisor);
    }
    
    time_t startingTime = time(NULL);
    
    for (int i = 0; i < numIterations; i++) {
        dotProduct(x, y, arrayLength);
    }
    
    time_t endingTime = time(NULL);
    time_t totalTime = endingTime - startingTime;
    return (float)totalTime;
}
