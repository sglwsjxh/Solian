//
//  NotifyDelegate.swift
//  Runner
//
//  Created by LittleSheep on 2025/6/1.
//

import Foundation
import Alamofire

class NotifyDelegate: UIResponder, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let textResponse = response as? UNTextInputNotificationResponse {
            let content = response.notification.request.content
            guard let metadata = content.userInfo["meta"] as? [AnyHashable: Any] else {
                return
            }
            
            var token: String? = UserDefaults.standard.getFlutterToken()
            if token == nil {
                return
            }
            
            let serverUrl = UserDefaults.standard.getServerUrl()
            let url = "\(serverUrl)/chat/\(metadata["room_id"] ?? "")/messages"
            
            let parameters: [String: Any?] = [
                "content": textResponse.userText,
                "replied_message_id": metadata["message_id"]
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(
                [HTTPHeader(name: "Authorization", value: "AtField \(token!)")]
            ))
                .validate()
                .responseString { response in
                    switch response.result {
                    case .success(_):
                        break
                    case .failure(let error):
                        print("Failed to send chat reply message: \(error)")
                        break
                    }
                }
        }
        
        completionHandler()
    }
}
