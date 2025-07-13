import UIKit

/// A model for API requests and image fetching.
class NetworkManager {
    /// Logs in a user with the provided username and password.
    ///
    /// - Parameters:
    ///   - username: The username of the user.
    ///   - password: The password of the user.
    ///   - completion: A closure that is called with the result of the login request.
    public static func login(username: String, password: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "http://joypal.natapp1.cc/login"
        
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        sendPostRequest(urlString: urlString, body: body, completion: completion)
    }
    
    /// Signs up a new user with the provided username and password.
    ///
    /// - Parameters:
    ///   - username: The username of the new user.
    ///   - password: The password of the new user.
    ///   - completion: A closure that is called with the result of the signup request.
    public static func signUp(username: String, password: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "http://joypal.natapp1.cc/register"
        
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        sendPostRequest(urlString: urlString, body: body, completion: completion)
    }
    
    /// Generate a character based on the provided profile parameters and optional image data.
    ///
    /// - Parameters:
    ///   - imgData: Optional image data for the character. If provided, the request will be sent to the image-to-image generation endpoint.
    ///   - profileParam: The parameters describing the character's characteristics.
    ///   - completion: A closure that is called with the result of the request.
    public static func generateCharacter(imgData: Data? = nil, userToken: String, profileParam: ProfileParam, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = imgData == nil ? "http://joypal.natapp1.cc/generate/text2img" : "http://joypal.natapp1.cc/generate/img2img"

        if imgData == nil {
            let body: [String: Any] = [
                "description": [
                    ["Name": profileParam.name],
                    ["Gender": profileParam.gender],
                    ["Appearance": profileParam.appearance],
                    ["Personality": profileParam.personality]
                ]
            ]
            sendPostRequest(urlString: urlString, userToken: userToken, body: body, completion: completion)
        } else {
            var request = URLRequest(url: URL(string: urlString)!)
            let boundary = UUID().uuidString
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.setValue(userToken, forHTTPHeaderField: "token")
        
            let description: [[String: String]] = [
                ["Name": profileParam.name],
                ["Gender": profileParam.gender],
                ["Appearance": profileParam.appearance],
                ["Personality": profileParam.personality]
            ]
            let descriptionData = try! JSONSerialization.data(withJSONObject: description)
            
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
            body.append(String(data: descriptionData, encoding: .utf8)!.data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
            
            if let imgData = imgData {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imgData)
                body.append("\r\n".data(using: .utf8)!)
            }
                
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"character_name\"\r\n\r\n".data(using: .utf8)!)
            body.append(profileParam.name.data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(json))
                    } else {
                        completion(.failure(NSError(domain: "ParsingError", code: -1, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    /// Generate text based on the provided message and profile.
    ///
    /// - Parameters:
    ///   - message: The input message for text generation.
    ///   - profile: The profile containing the character's characteristics.
    ///   - completion: A closure that is called with the result of the request.
    public static func generateText(message: String, userToken: String, profile: Profile, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "http://joypal.natapp1.cc/generate-text"

        let body: [String: Any] = [
            "dialogues": [
                ["Input": message]
            ],
            "description": [
                ["Name": profile.name],
                ["Gender": profile.gender],
                ["Appearance": profile.appearance],
                ["Personality": profile.personality]
            ]
        ]
        
        sendPostRequest(urlString: urlString, userToken: userToken, body: body, completion: completion)
    }
    
    /// Fetch an image from the provided URL string.
    ///
    /// - Parameters:
    ///   - urlString: The URL string of the image to fetch.
    ///   - completion: A closure that is called with the result of the image fetch.
    public static func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let downloadedImage = UIImage(data: data) else {
                completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: nil)))
                return
            }

            completion(.success(downloadedImage))
        }
        task.resume()
    }
    
    private static func sendPostRequest(urlString: String, userToken: String? = nil, body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let userToken = userToken {
            request.setValue(userToken, forHTTPHeaderField: "token")
        }
            
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "ParsingError", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
