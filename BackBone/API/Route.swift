//
//  Route.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 04/03/17.
//  Copyright © 2017 JoeBee Srl. All rights reserved.
//

import Foundation
import Alamofire
import Dotzu

enum Route: URLRequestConvertible {
    
    case login(email:String, password:String)
    case socialLogin(type:SocialLoginType, token:String)
    case resetPassword(email:String)
    case refreshToken
    case userMe
    case professionTypes
    case professionsFromProfessionType(professionType:Int)
    case professions
    case workers(filteredBy:String, pagination:PaginationComponent)
    case worker(withWorkerId:Int, andProfessionSlug:String)
    //MARK: - UNUSED
    case availableDays(fromWorkerId:Int, fromDate:Date, toDate:Date, minHours:Int)
    case calculateTariff(fromWorkerProfessionId:Int, andJobLocationDays:[JobLocationDay])
    case authorizePrePayment(withCart:Cart)
    case simulatePrePayment(withCart:Cart)
    case upload(media:Media)
    case employerJobs(phase:Int, pagination:PaginationComponent)
    case workerJobs(phase:Int, pagination:PaginationComponent)
    case calendar(workerId:Int, from:Date, to:Date, types:[Int]?, showOnlyRepetitions:Bool?, splitMidnight:Bool?)
    case fetchContacts(contacts:[String])
    case fetchCircles(type:Circle.CircleType)
    case addCircle(withCircle:Circle)
    
    private static let sessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        Dotzu.sharedManager.addLogger(session: configuration)
        let session = Alamofire.SessionManager(configuration: configuration)
        return session
    }()
    
    var isTokenRequired:TokenRequest{
        switch self {
        case .login, .socialLogin, .resetPassword:
            return .notRequired
        case .refreshToken:
            return .requiredRefresh
        default:
            return .required
        }
    }
    
    var expectedResponseType:ResponseType{
        switch self{
        case .login:
            return .json
        case .socialLogin:
            return .json
        case .resetPassword:
            return .json
        case .refreshToken:
            return .json
        case .userMe:
            return .json
        case .professionTypes:
            return .array
        case .professionsFromProfessionType:
            return .array
        case .professions:
            return .array
        case .workers:
            return .array
        case .worker:
            return .json
        case .availableDays:
            return .array
        case .calculateTariff:
            return .json
        case .authorizePrePayment:
            return .json
        case .simulatePrePayment:
            return .json
        case .upload:
            return .json
        case .employerJobs:
            return .array
        case .workerJobs:
            return .array
        case .calendar:
            return .array
        case .fetchContacts:
            return .array
        case .fetchCircles:
            return .array
        case .addCircle:
            return .json
        }
    }
    
    enum TokenRequest{
        case required
        case notRequired
        case requiredRefresh
    }
    
    enum ResponseType{
        case json
        case array
    }
    
    static let version = 2
    
    #if STAGING
    static let baseURLString = "http://be-st.joebee.com/it"
//    static let baseURLString = "http://52.169.180.164/it"
    static let workerURL = "http://preview.joebee.com/it/app/profession/new" // staging
    static let registerURL = "http://preview.joebee.com/it/register"
    static let dashboardURL = "http://preview.joebee.com/it/app/dashboard"
    static let host = "preview.joebee.com"
    static let employerJobDetail = "http://preview.joebee.com/it/app/employer/job/%d"
    static let workerJobDetail = "http://preview.joebee.com/it/app/worker/job/%d"
    #elseif PREPROD
    static let baseURLString = "http://be.iwillbejb.me/it"
    static let workerURL = "http://iwillbejb.me/it/app/profession/new" // preprod
    static let dashboardURL = "http://iwillbejb.me/it/app/dashboard"
    static let registerURL = "http://iwillbejb.me/it/register"
    static let host = "iwillbejb.me"
    static let employerJobDetail = "http://iwillbejb.me/it/app/employer/job/%d"
    static let workerJobDetail = "http://iwillbejb.me/it/app/worker/job/%d"
    #else
    static let baseURLString = "https://be.joebee.com/it"
    static let workerURL = "https://joebee.com/it/app/profession/new" // prod
    static let dashboardURL = "http://joebee.com/it/app/dashboard"
    static let registerURL = "https://joebee.com/it/register"
    static let host = "joebee.com"
    static let employerJobDetail = "https://joebee.com/it/app/employer/job/%d"
    static let workerJobDetail = "https://joebee.com/it/app/worker/job/%d"
    #endif
    
    
    var firstPart:String {
        return Route.baseURLString+"/api/v\(Route.version)"
    }
    
    
    
    var httpHeaders:[String:String]{
        var headers = [String:String]()
        switch self {
        case .upload:
            headers["Content-Type"] = "multipart/form-data; boundary=\(String.generateBoundaryString())"
        default:
            break
        }
        switch self.isTokenRequired {
        case .notRequired:
            headers["authorization"] = "Bearer public"
        case .required:
            if let token = SessionManager.instance.currentSession?.token{
                headers["authorization"] = "Bearer \(token)"
            }
            else{
                headers["authorization"] = "Bearer public"
            }
        case .requiredRefresh:
            guard let refreshToken = SessionManager.instance.currentSession?.refreshToken else {
                headers["authorization"] = "no_refresh_token"
                return headers
            }
            headers["authorization"] = refreshToken
        }
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .socialLogin:
            return .post
        case .resetPassword:
            return .post
        case .refreshToken:
            return .get
        case .userMe:
            return .get
        case .professionTypes:
            return .get
        case .professionsFromProfessionType:
            return .get
        case .professions:
            return .get
        case .workers:
            return .get
        case .worker:
            return .get
        case .availableDays:
            return .get
        case .calculateTariff:
            return .post
        case .authorizePrePayment:
            return .post
        case .simulatePrePayment:
            return .post
        case .upload:
            return .post
        case .employerJobs:
            return .get
        case .workerJobs:
            return .get
        case .calendar:
            return .get
        case .fetchContacts:
            return .get
        case .fetchCircles:
            return .get
        case .addCircle:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .socialLogin:
            return "/social_user"
        case .resetPassword:
            return "/reset_password/request"
        case .refreshToken:
            return "/token/refresh"
        case .userMe:
            return "/me"
        case .professionTypes:
            return "/profession_type"
        case .professionsFromProfessionType(let professionTypeId):
            return  "/profession_type/\(professionTypeId)/profession"
        case .professions:
            return "/profession"
        case .workers(let filters, _):
            return "/worker/search?\(filters)"
        case .worker(let workerId, let professionSlug):
            return "/user/\(workerId)/profession/\(professionSlug)"
        case .availableDays(let workerId,_,_,_):
            return "/worker/\(workerId)/availability"
        case .calculateTariff(let workerProfessionId, _):
            return "/calculate_tariff/\(workerProfessionId)"
        case .authorizePrePayment:
            return "/cart/pre_payment"
        case .simulatePrePayment:
            return "/cart/pre_payment/simulate"
        case .upload(let media):
            return "/user/media/\(media.type.rawValue)"
        case .employerJobs(let phase, _):
            return "/employer/job?filter_by[phase]=\(phase)"
        case .workerJobs(let phase, _):
            return "/worker/job?filter_by[phase]=\(phase)"
        case .calendar(let workerId, _, _, _, _, _):
            return "/worker/\(workerId)/calendar"
        case .fetchContacts:
            return "/user/search"
        case .addCircle:
            return "/circle"
        case .fetchCircles:
            return "/me/circle"
        }
        
    }
    
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try (firstPart + path).asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = httpHeaders
        switch self {
        case .login(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email":email, "password":password])
        case .socialLogin(let type, let token):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["role":"worker","token_type":type.rawValue,"token":token])
        case .resetPassword(let email):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email":email])
        case .refreshToken:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .userMe:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .professionTypes:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .professionsFromProfessionType:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .professions:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .workers(_, let paginationComponent):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["per_page" : paginationComponent.perPage, "page" : paginationComponent.page])
        case .worker:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .availableDays(_, let startDate, let toDate, let hours):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["from": startDate.yyyyMMdd, "to": toDate.yyyyMMdd,"day_hours": hours])
        case .calculateTariff(_, let jobLocationDays):
            urlRequest = try JSONEncoding.default.encode(urlRequest, withJSONObject: ["job_location_days":JobLocationDay.serialize(from: jobLocationDays)])
        case .authorizePrePayment(let cart):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: cart.serialized())
        case .simulatePrePayment(let cart):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: cart.serialized())
        case .upload:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with:nil)
        case .employerJobs(_, let paginationComponent):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["per_page" : paginationComponent.perPage, "page" : paginationComponent.page])
        case .workerJobs(_, let paginationComponent):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["per_page" : paginationComponent.perPage, "page" : paginationComponent.page])
        case .calendar(_, let fromDate, let toDate, let types, let showOnlyRepeats, let splitMidnight):
            var dict = GenericDictionary()
            
            dict["from"] = fromDate.yyyyMMdd
            dict["to"] =   toDate.yyyyMMdd
            if let types = types{
                let string = types.map({"\($0)"}).joined(separator:",")
                dict["type"] = string
            }
            if let showOnlyRepeats = showOnlyRepeats{
                dict["repeat"] = showOnlyRepeats ? 1 : 0
            }
            if let splitMidnight = splitMidnight{
                dict["split_midnight"] = splitMidnight ? 1 : 0
            }
            urlRequest = try URLEncoding.default.encode(urlRequest, with: dict)
        
        case .fetchContacts(let contacts):
            if contacts.count == 0 {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            }
            else{
                urlRequest = try URLEncoding.default.encode(urlRequest, with: ["phone" : contacts.joined(separator: ",")])
            }
        case .fetchCircles(let type):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["type": type.rawValue])
        case .addCircle(let circle):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: circle.serialized())
        }
        
        
        return urlRequest
    }
    func dataRequest(completion:@escaping (_ request:DataRequest)->Void){
        switch self{
        case .upload(let media):
            do {
                let url = try self.asURLRequest()
                Route.sessionManager.upload(multipartFormData: { multipartFormData in
                    
                    multipartFormData.append(UIImageJPEGRepresentation(media.image, 0.2)!, withName: "file", fileName: "file", mimeType: "image/png")
                }, with: url, encodingCompletion: {
                    encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        completion(upload)
                    case .failure:
                        completion(Route.sessionManager.request(self))
                    }
                })
            }
            catch{
                
            }
        default:
            completion(Route.sessionManager.request(self))
        }
    }
    
}

