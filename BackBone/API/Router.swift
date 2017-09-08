//
//  Router.swift
//  JoeBee
//
//  Created by Andrea Bellotto on 03/03/17.
//  Copyright © 2017 JoeBee Srl. All rights reserved.
//

import Foundation
import Alamofire
import Dotzu

class RefreshBlock{
    var route:Route
    var refreshCallback:(_ response:Response<Any>)->Void
    
    init(with route:Route, and refreshCallback:@escaping (_ response:Response<Any>)->Void){
        self.route = route
        self.refreshCallback = refreshCallback
    }
}

struct ApiError:Error{
    let statusCode:Router.StatusCode
    let description:String
}


enum Response<Element>{
    case success(result:Element, pagination: Pagination?)
    case error(e: ApiError)
}


public enum ParserError:Error{
    case missingParams
}

class Router{
    
    class var instance : Router {
        struct Static {
            static let instance : Router = Router()
        }
        return Static.instance
    }
    
    struct BackendErrorType {
        static let NoError = 0
        static let NoConnectionError = -1
        static let DataFormatMismatch = -2
        static let NoAccessToken = -3
        static let MissingUserRegistration = -4
    }
    
    
    enum StatusCode: String {
        
        case UNDEFINED_STATUS = ""
        case SUCCESS_STATUS = "200"
        case CREATE_SUCCESS_STATUS = "201"
        case MOVED_PERMANENTLY_STATUS = "301"
        case BAD_REQUEST_STATUS = "400"
        case UNAUTHORIZED_STATUS = "401"
        case FORBIDDEN_STATUS = "403"
        case NOT_FOUND_STATUS = "404"
        case METHOD_NOT_ALLOWED_STATUS = "405"
        case CONFLICT = "409"
        case ERROR_SERVER_STATUS = "500"
        case GENERIC_ERROR = "00"
        case GENERIC_FRIWIX_ERROR = "01"
        case JSON_MALFORMED = "02"
        case QUERYSTRING_MALFORMED = "03"
        case REGISTRATION_TOKEN_NOT_FOUND = "04"
        case REGISTRATION_TOKEN_EXPIRED = "05"
        case VIOLATION_CONSTRAINT = "601"
        case USER_ALREADY_EXIST = "602"
        case USER_ALREADY_EXIST_FRIWIX = "603"
        case TOKEN_EXPIRED = "604"
        case INVALID_ACCESS_TOKEN = "605"
        case INVALID_REFRESH_TOKEN = "606"
        case USER_NOT_FOUND = "607"
        case EMPLOYER_NOT_FOUND = "608"
        case EVENT_ERROR = "609"
        case RESET_TOKEN_NOT_FOUND = "610"
        case RESET_TOKEN_EXPIRED = "611"
        case ACTIVITY_TIMEFRAME_NOT_EXIST = "AT01"
        case WORKER_NOT_EXIST = "WW01"
        case WORKER_PROFESSION_NOT_EXIST = "WW02"
        case WORKER_PROFESSION_EXPERIENCE_NOT_EXIST = "WW03"
        case WORKER_PROFESSION_SKILL_NOT_EXIST = "WW04"
        case WORKER_PROFESSION_RATE_NOT_EXIST = "WW05"
        case WORKER_PROFESSION_EXPERIENCE_DELETE = "WW06"
        case WORKER_PROFESSION_SKILL_DELETE = "WW07"
        case WORKER_PROFESSION_RATE_DELETE = "WW08"
        case WORKER_BUSY_NOT_EXISTI = "WW09"
        case WORKER_BUSY_DELETE = "WW10"
        case LANGUAGE_NOT_EXIST = "WW11"
        case DAYTYPE_NOT_EXIST = "WW12"
        case PROFESSION_NOT_EXIST = "WW13"
        case PROFESSION_SKILL_NOT_EXIST = "WW14"
        case RATE_TYPE = "WW15"
        case COUNTRY_NOT_EXIST = "WW16"
        case WORKER_JOB_NOT_EXIST = "WW17"
        case WORKER_VEHICLE_NOT_EXIST = "WW18"
        case WORKER_DEVICE_NOT_EXIST = "WW19"
        case WORKER_INSTRUMENT_INS_ERROR = "WW20"
        case WORKER_PROFESSION_NOT_WORKER = "WW21"
        case WORKER_INSTRUMENT_NOT_EXIST = "WW22"
        case WORKER_INSTRUMENT_NOT_WORKER = "WW23"
        case WORKER_INSTRUMENT_NOT_IMAGE_SEND = "WW24"
        case WORKER_INSTRUMENT_UPLOAD_ERROR = "WW25"
        case WORKER_PROFESSION_NOT_IMAGE_SEND = "WW26"
        case WORKER_PROFESSION_UPLOAD_ERROR = "WW27"
        case WORKER_PROFESSION_IMAGE_NOT_FOUND = "WW28"
        case WORKER_PROFESSION_EXPERIENCE_NOT_WORKER = "WW29"
        case WORKER_PROFESSION_EXPERIENCE_IMAGE_NOT_FOUND = "WW30"
        case VEHICLE_TYPE_NOT_FOUND = "WW31"
        case VEHICLE_PRESENT = "WW32"
        case WORKER_PROFESSION_AVATAR_NOT_FOUND = "WW33"
        case WORKER_AVATAR_FILE_SIZE_ZERO = "WW34"
        case WORKER_PROFESSION_FILE_SIZE_ZERO = "WW35"
        case WORKER_INSTRUMENT_FILE_SIZE_ZERO = "WW36"
        case WORKER_PROFESSION_PORTFOLIO_FILE_SIZE_ZERO = "WW37"
        case WORKER_INSTRUMENT_NOT_WORKER_LOGGED = "WW38"
        case WP_PROFESSION_NOT_EXIST = "WP01"
        case PROFESSION_SERVICE_INS_ERROR = "WP02"
        case PROFESSION_SERVICE_NOT_EXIST = "WP03"
        case FILTER_BY_SKILL_IS_NOT_ARRAY = "EE01"
        case FILTER_BY_DATE_IS_NOT_ARRAY = "EE02"
        case FILTER_BY_TIMEFRAME_IS_NOT_ARRAY = "EE03"
        case EMP_WORKER_NOT_EXIST = "EE04"
        case EMPLOYER_NOT_EXIST = "EJ04"
        case EMP_PROFESSION_NOT_EXIST = "EJ05"
        case EMP_JOB_NOT_EXIST = "EJ06"
        case EMP_JOB_UNCHANGEABLE = "EJ07"
        case EMP_JOB_NOT_ERASABLE = "EJ08"
        case JOB_DELETE = "EJ09"
        case JOB_IMAGE_EMPTY = "EJ10"
        case EMP_JOB_BRIEF_NOT_EXIST = "EJ11"
        case EMP_UPLOAD_JOB_IMAGE_ERROR = "EJ12"
        case EMP_JOB_WORKER_NOT_EXIST = "EJ13"
        case EMP_JOB_NOT_ACCEPTABLE = "EJ14"
        case EMP_JOB_NOT_ACCEPTABLE_FROM_WORKER = "EJ15"
        case EMP_EVENT_NOT_POSSIBLE = "EJ16"
        case EE_EMPLOYER_NOT_EXIST = "EE17"
        case EE_JOB_NOT_EXIST = "EE18"
        case EE_JOB_NOT_EMPLOYER = "EE19"
        case EE_JOB_NOT_ACTIVED = "EE20"
        case EE_JOB_ACTIVITY_NOT_FOR_WORKER = "EE21"
        case EE_JOB_ACTIVITY_NOT_FINISHED = "EE22"
        case EE_JOB_RATING_EXIST = "EE23"
        case EJ_CONFIRM_EMAIL = "EJ24"
        case EJ_TIMEFRAME_ERROR = "EJ25"
        case EMP_JOB_BRIEF_FILE_SIZE_ZERO = "EJ26"
        case EMP_WORKER_BUSY = "EJ27"
        case EJ_PROFESSION_SERVICE_NOT_EXIST = "EJ28"
        case EJ_PROFESSION_SERVICE_NOT_IN_PROFESSION = "EJ29"
        case EJ_WORKER_INSTRUMENT_NOT_EXIST = "EJ30"
        case EJ_WORKER_INSTRUMENT_NOT_FOR_WORKER = "EJ31"
        case EJ_WORKER_PROFESSION_NOT_EXIST = "EJ32"
        case EJ_WORKER_PROFESSION_SERVICE_NOT_EXIST = "EJ33"
        case ACT_CHECK_NOT_POSSIBLE = "AA01"
        case ACT_EVENT_NOT_POSSIBLE = "AA02"
        case ACT_JOB_NOT_EXIST = "AA03"
        case ACT_JOB_NOT_FOR_EMPLOYER = "AA04"
        case ACT_CHECK_WORKER_NOT_EXIST = "AA05"
        case ACT_CHECK_NOT_EXIST = "AA06"
        case ACT_CHECK_NOT_IMAGE_SEND = "AA07"
        case ACT_CHECK_UPLOAD_ERROR = "AA08"
        case ACT_CHECK_NOT_IN_JOB_ADDRESS = "AA10"
        case ACT_CHECK_FILE_SIZE_ZERO = "AA11"
        case NOTIFICATION_NOT_SET = "NN01"
        case NOTIFICATION_SENDER_NOT_EXIST = "NN02"
        case NOTIFICATION_PHASE_NOT_EXIST = "NN03"
        case NOTIFICATION_RECEIVER_NOT_EXIST = "NN04"
        case NOTIFICATION_INSERT_ERROR = "NN05"
        case NOTIFICATION_TYPE_TEMPLATE_NOT_EXIST = "NN06"
        case NOTIFICATION_INSERT_RECIPIENT_ERROR = "NN07"
        case NOTIFICATION_UPDATE_RECIPIENT_ERROR = "NN08"
        case DEVICE_MODEL_NOT_FOUND = "MD01"
        case DEVICE_INSERT_ERROR = "MD02"
        case DEVICE_USER_NOT_FOUND = "MD03"
        case DEVICE_TYPE_NOT_FOUND = "MD04"
        case DEVICE_MODEL_PRESENT = "MD05"
        case FILE_SIZE_ZERO = "MM01"
        case FILE_NOT_FOUND = "MM02"
        case FACEBOOK_GRAPH_ERROR = "FB01"
        case FACEBOOK_SDK_ERROR = "FB02"
        case LI_API_ERROR = "LI01"
        case PP_WORKER_PROFESSION_SERVICE_NOT_EXIST = "PP01"
        case PP_WORKER_INSTRUMENT_NOT_EXIST = "PP02"
        
    }
    
    var refreshBlocks = [RefreshBlock]()
    
    static func showFailureError(with error:ApiError, failureAction:(()->Void)?){
        MainViewController.show(error, failureAction:failureAction)
    }
    
    
    private static func makeCall(route:Route, showAlert:Bool = true, failureAction:(()->Void)? = nil, completion:@escaping (_ response:Response<Any>)->Void){
        var forceByPass = true
        
        
        
        let currentSession = SessionManager.instance.currentSession
        //Add the network logger on the configuration
        
        if route.isTokenRequired == .required && currentSession != nil {
            forceByPass = false
        }

        self.authMiddleware(forceByPass: true, refreshBlock: RefreshBlock(with:route, and:completion), completion: { (middlewareResponse) in
            switch middlewareResponse{
            case .error(let error):
                completion(Response.error(e: error))
            case .success:
                route.dataRequest(completion: { (dataRequest) in
                    
                dataRequest.validate().responseJSON(completionHandler: { (finalResponse) in
                    switch finalResponse.result{
                    case .success(let data):
                        let pagination:Pagination?
                        if let urls = finalResponse.response?.allHeaderFields["Link"] as? String{
                            pagination = Pagination()
                            if urls != "" {
                                pagination?.components = PaginationComponent.paginations(from: urls)
                            }
                        }
                        else{
                            pagination = nil
                        }
                        if let dict = data as? GenericDictionary{
                            completion(Response.success(result: dict, pagination: pagination))
                        }
                        else if let array = data as? [Any]{
                            completion(Response.success(result: array, pagination: pagination))
                        }
                        else {
                            let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "undefined error")
                            if showAlert {
                                Router.showFailureError(with: error, failureAction: failureAction)
                            }
                            completion(Response.error(e: error))
                        }
                    case .failure(let error):
                        guard let data = finalResponse.data else {
                            let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "no data")
                            if showAlert {
                                Router.showFailureError(with: error, failureAction: failureAction)
                            }
                            completion(Response.error(e: error))
                            return
                        }
                        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else {
                            let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "alert_generic_error".localized)
                            if showAlert {
                                Router.showFailureError(with: error, failureAction: failureAction)
                            }
                            completion(Response.error(e: error))
                            return
                        }
                        guard let errors = dict["errors"] as? GenericArray else {
                            let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "no errors json")
                            if showAlert {
                                Router.showFailureError(with: error, failureAction: failureAction)
                            }
                            completion(Response.error(e: error))
                            return
                        }
                        if errors.count > 0 {
                            let errorDict = errors[0]
                            guard let errorCode = errorDict["code"] as? String, let description = errorDict["description"] as? String else {
                                let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "error without description")
                                if showAlert {
                                    Router.showFailureError(with: error, failureAction: failureAction)
                                }
                                completion(Response.error(e: error))
                                return
                            }
                            guard let statusCode = Router.StatusCode(rawValue:errorCode) else {
                                let error = ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: description)
                                if showAlert {
                                    Router.showFailureError(with: error, failureAction: failureAction)
                                }
                                completion(Response.error(e: error))
                                return
                            }
                            let error = ApiError(statusCode: statusCode, description: description)
                            if error.statusCode == .TOKEN_EXPIRED {
                                self.refreshToken(refreshBlock: RefreshBlock(with:route, and:completion))
                                return
                            }
                            else {
                                if showAlert {
                                    Router.showFailureError(with: error, failureAction: failureAction)
                                }
                                completion(Response.error(e: error))
                            }
                        }
                        print(error.localizedDescription)
                        print("error!")
                    }
                })
                })
            }
        })
    }
    
    private static func authMiddleware(forceByPass:Bool, refreshBlock:RefreshBlock, completion:@escaping (_ response:Response<Any>)->Void){
        if forceByPass {
            completion(Response.success(result: [Any](), pagination:nil))
        }
        else {
            if SessionManager.instance.tokenIsValid {
                completion(Response.success(result: [Any](), pagination:nil))
            }
            else {
                refreshToken(refreshBlock: refreshBlock)
            }
        }
    }
    
    private static func refreshToken(refreshBlock:RefreshBlock){
        Router.instance.refreshBlocks.append(refreshBlock)
        if Router.instance.refreshBlocks.count == 1 {
            makeCall(route: .refreshToken) { (refreshCompletion) in
                switch refreshCompletion{
                case .error(let error):
                    refreshBlock.refreshCallback(Response.error(e: error))
                case .success(let result, _):
                    do{
                        try Token.setupSessionToken(from: result as! GenericDictionary)
                        for refreshBlock in Router.instance.refreshBlocks{
                            makeCall(route: refreshBlock.route, completion: refreshBlock.refreshCallback)
                        }
//                        refreshBlock.refreshCallback(Response.success(result: result))
                        Router.instance.refreshBlocks = [RefreshBlock]()
                    }
                    catch(let err){
                        print(err)
                        refreshBlock.refreshCallback(Response.error(e: ApiError(statusCode: .UNDEFINED_STATUS, description: "Unable to save session token")))
                    }
                }
            }
        }
    }

    static func login(email:String, password:String, completion: @escaping(_ response:Response<Any>)->Void){
        makeCall(route: .login(email: email, password: password)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                do{
                    try Token.setupSessionToken(from: result as! GenericDictionary)
                    completion(Response.success(result: result, pagination:nil))
                }
                catch(let err){
                    print(err)
                    completion(Response.error(e: ApiError(statusCode: .UNDEFINED_STATUS, description: "Unable to save session token")))
                }
            }
        }
    }
    
    
    static func socialLogin(type:SocialLoginType, token:String, completion:@escaping(_ response:Response<Any>)->Void){
        makeCall(route: .socialLogin(type: type, token: token)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                do{
                    try Token.setupSessionToken(from: result as! GenericDictionary)
                    completion(Response.success(result: result, pagination:nil))
                }
                catch(let err){
                    print(err)
                    completion(Response.error(e: ApiError(statusCode: .UNDEFINED_STATUS, description: "Unable to save session token")))
                }
            }
        }
    }
    
    static func resetPassword(for email:String, completion:@escaping(_ response:Response<Any>)->Void){
        makeCall(route: .resetPassword(email:email)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                completion(Response.success(result: result, pagination:nil))
            }
        }
    }
    
    //MARK: - User infos
    
    static func fetchUserMe(showAlert:Bool = true, completion: @escaping(_ response:Response<User>)->Void){
        makeCall(route: .userMe, showAlert: showAlert) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                let user = User(with: result)
                SessionManager.instance.currentUser = user
                if !user.hasCompletedProfile {
                    var token:Token?
                    if let currentSession = SessionManager.instance.currentSession{
                        let userToken = currentSession.token
                        let refresh = currentSession.refreshToken
                        let expire = currentSession.expiration
                        let userId = currentSession.userId
                        token = Token(token: userToken, refreshToken: refresh, userId: userId, date: expire)
                    }
                    
                    SessionManager.instance.deleteTokenFromDefaults()
                    SessionManager.instance.currentUser = nil
                    SessionManager.instance.currentSession = nil
                    MainViewController.showAlertForRegister(passToken: token)
                }
                
                completion(Response.success(result: user, pagination:nil))
            }
        }
    }
    
    //MARK: - ProfessionCategories

    
    static func fetchProfessionTypes(completion:@escaping(_ r:Response<[ProfessionCategory]>)->Void){
        makeCall(route: .professionTypes, completion: {(data) in
            switch data{
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let categories = ProfessionCategory.parse(from: result) as [ProfessionCategory]
                completion(Response.success(result: categories, pagination:nil))
            case .error(let error):
                completion(Response.error(e: error))
            }
        })
    }

    //MARK: - Professions
    
    
    static func fetchProfessions(completion:@escaping(_ r:Response<[Profession]>)->Void){
        makeCall(route: .professions) { (data) in
            switch data {
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let professions = Profession.parse(from: result) as [Profession]
                completion(Response.success(result: professions, pagination:nil))
            }
        }
    }
    
    
    static func fetchProfessions(from professionTypeId:Int, completion:@escaping(_ r:Response<[Profession]>)->Void){
        makeCall(route: .professionsFromProfessionType(professionType: professionTypeId), completion: {(data) in
            switch data{
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let professions = ProfessionCategory.parse(from: result) as [Profession]
                completion(Response.success(result: professions, pagination:nil))
            case .error(let error):
                completion(Response.error(e: error))
            }
        })
    }
    
    
    
    //MARK: - Workers
    
    static func fetchContacts(contacts:[String], completion:@escaping(_ r:Response<[User]>)->Void){
        makeCall(route: .fetchContacts(contacts: contacts)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let users:[User] = User.parse(from: result)
                
                completion(Response.success(result: users, pagination:nil))
            }
        }
    }
    
    static func fetchWorkers(filters:GenericDictionary, pagination:PaginationComponent,  completion:@escaping(_ response:Response<[User]>)->Void){
        var filterString = ""
        var count = 0
        for (key,value) in filters{
            if count == 0 {
                filterString += "filter_by[\(key)]=\(value)"
            }
            else {
                filterString += "&filter_by[\(key)]=\(value)"
            }
            count += 1
        }
        makeCall(route: .workers(filteredBy: filterString, pagination:pagination)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, let pagination):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let workers:[Worker] = Worker.parse(from: result)
                
                completion(Response.success(result: Worker.getUsers(from: workers), pagination:pagination))
            }
        }
    }
    
    static func fetchWorkerDetail(from workerId:Int, professionSlug:String, failureAction:(()->Void)? = nil, completion:@escaping(_ r:Response<User>)->Void){
        makeCall(route:  .worker(withWorkerId: workerId, andProfessionSlug: professionSlug), failureAction: failureAction, completion: { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                let worker = Worker(with: result)
                completion(Response.success(result: worker.user, pagination:nil))
            }
        })
    }
    
    
    //MARK: - UNUSED
    static func fetchAvailability(for workerId:Int, startingFrom startDate:Date, to endDate:Date, forHours hours:Int, completion:@escaping(_ r:Response<[JobLocationDay]>)->Void){
        

        makeCall(route: .availableDays(fromWorkerId: workerId, fromDate: startDate, toDate: endDate, minHours: hours)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                let jobLocationDays = JobLocationDay.parse(from: result) as [JobLocationDay]
                completion(Response.success(result: jobLocationDays, pagination:nil))
                
            }
        }
    }
    
    static func fetchWorkerJobs(filteredBy phase:JobPhase, pagination:PaginationComponent, completion:@escaping(_ r:Response<[Job]>)->Void){
        makeCall(route: .workerJobs(phase: phase.rawValue, pagination:pagination)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, let pagination):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                
                let jobs = Job.parse(from: result) as [Job]
                completion(Response.success(result: jobs, pagination:pagination))
            }
            
        }
    }
    
    static func fetchWorkerCalendar(for workerId:Int, from:Date, to:Date, filteredTypes:[Int]? = nil, showOnlyRepetitions:Bool? = nil, splitMidnight:Bool? = nil, completion:@escaping(_ r:Response<[CalendarInterval]>)->Void){
        makeCall(route: .calendar(workerId: workerId, from: from, to: to, types: filteredTypes, showOnlyRepetitions: showOnlyRepetitions, splitMidnight: splitMidnight)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                
                let calendarIntervals = CalendarInterval.parse(from: result) as [CalendarInterval]
                completion(Response.success(result: calendarIntervals, pagination:nil))
            }
        }
    }

    
    static func calculateTariff(for workerProfession:Int, and jobLocationDays:[JobLocationDay], completion:@escaping(_ r:Response<FiscalData>)->Void){
        
        makeCall(route: .calculateTariff(fromWorkerProfessionId: workerProfession, andJobLocationDays: jobLocationDays)) { (data) in
            switch data {
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                let fiscalData = FiscalData(with: result)
                completion(Response.success(result: fiscalData, pagination:nil))
            }
        }
    }

    //MARK: - Payment
    
    static func preAuthorizePayment(cart:Cart, completion:@escaping(_ r:Response<PrePayment>)->Void){
        makeCall(route: .authorizePrePayment(withCart: cart), showAlert: false) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                
                let prePaymentData = PrePayment(with: result)
                completion(Response.success(result: prePaymentData, pagination:nil))
            }
            
        }
        
    }
    
    
    static func simulatePayment(cart:Cart, completion:@escaping(_ r:Response<PrePayment>)->Void){
        makeCall(route: .simulatePrePayment(withCart: cart)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                
                let prePaymentData = PrePayment(with: result)
                completion(Response.success(result: prePaymentData, pagination:nil))
            }
        }
    }
    
    
    
    //MARK: - Media
    
    static func upload(media:Media, completion:@escaping(_ r:Response<Media>)->Void){
        makeCall(route: .upload(media:media)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                
                let media = Media(with: result)
                completion(Response.success(result: media, pagination:nil))
            }
            
        }
    }
    
    
    //MARK: - Employers
    
    static func fetchEmployerJobs(filteredBy phase:JobPhase, pagination:PaginationComponent, completion:@escaping(_ r:Response<[Job]>)->Void){
        makeCall(route: .employerJobs(phase: phase.rawValue, pagination: pagination)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, let pagination):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                
                let jobs = Job.parse(from: result) as [Job]
                completion(Response.success(result: jobs, pagination:pagination))
            }
        }
    }
    
    
    //MARK: - Circles
    
    static func fetchCircles(filteredBy type:Circle.CircleType, completion:@escaping(_ r:Response<[Circle]>)->Void){
        makeCall(route: .fetchCircles(type: type)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericArray else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected array)")))
                    return
                }
                
                let circles = Circle.parse(from: result) as [Circle]
                completion(Response.success(result: circles, pagination:nil))
            }
        }
    }
    

    static func addCircle(circle:Circle, completion:@escaping(_ r:Response<Circle>)->Void){
        makeCall(route: .addCircle(withCircle:circle)) { (data) in
            switch data{
            case .error(let error):
                completion(Response.error(e: error))
            case .success(let result, _):
                guard let result = result as? GenericDictionary else {
                    completion(Response.error(e: ApiError(statusCode: Router.StatusCode.UNDEFINED_STATUS, description: "wrong struct (expected dictionary)")))
                    return
                }
                
                let circle = Circle(with: result)
                completion(Response.success(result: circle, pagination:nil))
            }
        }
    }
}

