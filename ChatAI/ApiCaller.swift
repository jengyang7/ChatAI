//
//  ApiCaller.swift
//  ChatAI
//
//  Created by Jeng Yang on 13/12/2022.
//

import Foundation
import OpenAISwift

final class ApiCaller {
    
    static let shared = ApiCaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void){
        client?.sendCompletion(with: input, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
