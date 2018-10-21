//
//  Dispatch.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public class Dispatch<T> : Dispatchable {
    var id: String
    var isCancelled: Bool = false
    var completions: [CompletionBlock<Any>] = []
    var execution: ExecutionBlock<Any>
    var timeout: Int = 1
    
    public init(
        id: String,
        timeout: Int = 1,
        retryPolicy: RetryPolicy = .none,
        maxRetries: Int = 2,
        execution: @escaping ExecutionBlock<T>,
        completion: CompletionBlock<T>? = nil) {
        
        assert(timeout >= 0, "Dispatch timeout must be >= 0")
        self.id = id
        self.timeout = timeout
        self.execution = execution as! ExecutionBlock<Any>
        if let c = completion {
            completions.append(c as! CompletionBlock<Any>)
        }
    }
    
    func run() {
        if isCancelled {
            complete(result: .failure(Errors.cancelled))
            return
        }
        execute()
    }
    
    func timedOut() {
        complete(result: .failure(Errors.timeout))
//        complete(Result.Failure<T>(TimeoutException("$id timed out after $timeout seconds")))
    }
}

enum Errors: Error {
    case cancelled
    case timeout
}
