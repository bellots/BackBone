//
//  Router.swift
//  BackBone
//
//  Created by Andrea Bellotto on 05/10/17.
//  Copyright © 2017 Andrea Bellotto. All rights reserved.
//

import Foundation
import Apollo


class Router {
    class var instance:Router {
        struct Static {
            static let instance:Router = Router()
        }
        return Static.instance
    }
    
    var client:ApolloClient {
        return ApolloClient(networkTransport: AuthHTTPNetworkTransport(url: URL(string: Constants.endPoint)!))
    }
    /*
    static func event(for stringId:String)->Promise<BaseModel>{
        return Promise<BaseModel>{ fulfill, reject in
            DispatchQueue.main.async {
                if let id = GraphQLID(stringId){
                    
                     
                    Router.instance.client.fetch(query: GraphQLQuery(withParams)){(result, error) in
                        if let event = result?.data?.event {
                            fulfill(event)
                        }
                        if let error = error{
                            reject(ErrorModel.genericError(message:error.localizedDescription))
                        }
                    }
 
 
                }
            }
        }
    }
     */

    
}
