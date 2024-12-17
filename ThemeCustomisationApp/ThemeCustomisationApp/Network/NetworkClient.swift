//
//  NetworkClient.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 17/12/2024.
//

import Foundation
import Alamofire

final class NetworkClient {
    let session: Session
    private init() {
        session = Session()
    }

    // MARK: - Static Definitions
    private static let shared = NetworkClient()
    static func request<T: Decodable>(endpoint: APIConfiguration, decoder: JSONDecoder = JSONDecoder(),
                                      completion: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        return shared.session.request(endpoint).validate(statusCode: 200..<300)
            .responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
                print("Response", response)
                completion(response)
            }
            .cURLDescription { description in
                print(description)
            }
    }
    
    static func cancelAllRequests() {
        shared.session.session.getAllTasks { tasks in
            tasks.forEach({ $0.cancel() })
        }
    }
}
