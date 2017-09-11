//
//  AuthHTTPNetworkTransport.swift
//  Peplo Events
//
//  Created by Andrea Bellotto on 11/09/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import Apollo

/// Based on HTTPNetworkTransport from Apollo to add Authentication header dynamically
public class AuthHTTPNetworkTransport: NetworkTransport {
    
    enum GQLError: Error {
        case errorResponse(body: Data?, response: HTTPURLResponse)
        case invalidResponse(body: Data?, response: HTTPURLResponse)
    }
    
    let url: URL
    let session: URLSession
    let serializationFormat = JSONSerializationFormat.self
    
    public init(url: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default, sendOperationIdentifiers: Bool = false) {
        self.url = url
        self.session = URLSession(configuration: configuration)
        self.sendOperationIdentifiers = sendOperationIdentifiers
    }
    
    
    
    public func send<Operation: GraphQLOperation>(operation: Operation, completionHandler: @escaping (GraphQLResponse<Operation>?, Error?) -> Void) -> Cancellable {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add your custom headers here
        // Example
//        if let token = Session.token {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
//        
        let body = requestBody(for: operation)
        request.httpBody = try! serializationFormat.serialize(value: body)
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("Response should be an HTTPURLResponse")
            }
            
            if (httpResponse.statusCode != 200) {
                completionHandler(nil, GQLError.errorResponse(body: data, response: httpResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(nil, GQLError.invalidResponse(body: nil, response: httpResponse))
                return
            }
            
            do {
                guard let body =  try self.serializationFormat.deserialize(data: data) as? JSONObject else {
                    completionHandler(nil, GQLError.invalidResponse(body: data, response: httpResponse))
                    return
                }
                let response = GraphQLResponse(operation: operation, body: body)
                completionHandler(response, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        
        task.resume()
        
        return task
    }
    
    private let sendOperationIdentifiers: Bool
    
    private func requestBody<Operation: GraphQLOperation>(for operation: Operation) -> GraphQLMap {
        if sendOperationIdentifiers {
            guard let operationIdentifier = type(of: operation).operationIdentifier else {
                preconditionFailure("To send operation identifiers, Apollo types must be generated with operationIdentifiers")
            }
            return ["id": operationIdentifier, "variables": operation.variables]
        }
        return ["query": type(of: operation).requestString, "variables": operation.variables]
    }
}
