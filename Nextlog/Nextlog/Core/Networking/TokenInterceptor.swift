//
//  TokenInterceptor.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Foundation
import Alamofire
 
class TokenInterceptor: RequestInterceptor, @unchecked Sendable {
    
    //MARK: - PROPERTIES -
    private var token: String? {
        return AppStorage.accessToken
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        if let token = self.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
}
