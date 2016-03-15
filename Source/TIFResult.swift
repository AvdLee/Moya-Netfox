//
//  TIFResult.swift
//  Pods
//
//  Created by Antoine van der Lee on 14/03/16.
//
//


import Foundation
import Result

// TO-DO: As soon as https://github.com/antitypical/Result/issues/77 is resolved, this file should be removed
struct TIFResult<T, Error : ErrorType> {
    typealias t = Result<T, Error>
}