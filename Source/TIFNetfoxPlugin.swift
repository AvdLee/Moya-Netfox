//
//  TIFNetfoxPlugin.swift
//  Pods
//
//  Created by Antoine van der Lee on 08/03/16.
//
//

import Moya
import Result
import netfox

public typealias TIFEndpointClosure = TIFAPI -> NSURLRequest

public final class TIFNetfoxPlugin {
    
    private var modelsDict = [Int: NFXHTTPModel]()
    private let endpointClosure:TIFEndpointClosure
    
    public init(){
        self.endpointClosure = { (target) -> NSURLRequest in
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
            request.HTTPMethod = target.method.rawValue
            
            return target.parameterEncoding.toAlamofire.encode(request, parameters: target.parameters).0
        }
        
        
        
        NFX.sharedInstance().start(manualRecording: true)
    }
}

extension TIFNetfoxPlugin : PluginType {
    /// Called by the provider as soon as the request is about to start
    public func willSendRequest(request: RequestType, target: TargetType) {
        guard let tifTarget = target as? TIFAPI else { return }
        
        let urlRequest = endpointClosure(tifTarget)
        let model = NFXHTTPModel()
        model.saveRequest(urlRequest)
        modelsDict[urlRequest.hash] = model
    }
    
    /// Called by the provider as soon as a response arrives
    public func didReceiveResponse(result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        guard let tifTarget = target as? TIFAPI else { return }
        let urlRequest = endpointClosure(tifTarget)
        
        guard let model = modelsDict[urlRequest.hash] else { return }
        
        if case .Success(let response) = result, let urlResponse = response.response {
            model.saveResponse(urlResponse, data: response.data)
        }

        NFXHTTPModelManager.sharedInstance.add(model)
    }
}

public extension Hashable where Self:TargetType {
    var hashValue: Int {
        return baseURL.hash
    }
}
