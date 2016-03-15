//
//  Moya+Helper.swift
//  Pods
//
//  Created by Antoine van der Lee on 14/03/16.
//
//

import Alamofire
import Moya

extension Moya.ParameterEncoding {
    var toAlamofire: Alamofire.ParameterEncoding {
        switch self {
        case .URL:
            return .URL
        case .JSON:
            return .JSON
        case .PropertyList(let format, let options):
            return .PropertyList(format, options)
        case .Custom(let closure):
            return .Custom(closure)
        }
    }
}