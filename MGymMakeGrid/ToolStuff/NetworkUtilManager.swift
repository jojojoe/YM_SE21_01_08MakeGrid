//
//  NetworkUtilManager.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/7.
//

import Foundation
import Alamofire
 
class NetworkUtilManager {
    
    static func networkReachable() -> Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true
         
    }
    
    static func cancelAllNetworkRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler {
            (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
         
    }
}
