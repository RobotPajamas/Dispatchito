//
//  Dispatch.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public class Dispatch<T> : Dispatchable {
    
    var maxRetries: Int
    var retryPolicy: RetryPolicy
    var retries: Int = 0
    var retryBlock: RetryBlock = {}
    
    var id: String
    var isCancelled: Bool = false
    var completions: [CompletionBlock<T>] = []
    var execution: ExecutionBlock<T>
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
        self.maxRetries = maxRetries
        self.retryPolicy = retryPolicy
        self.execution = execution
        if let c = completion {
            completions.append(c)
        }
    }
    
    internal func addCompletion(_ completion: @escaping () -> Void) {
        completions.append {_ in
            completion()
        }
    }
    
    internal func run() {
        if isCancelled {
            complete(result: .failure(Errors.cancelled))
            return
        }
        execute()
    }
    
    internal func execute() {
        execution { (result) in
            complete(result: result)
        }
    }
    
    private func finish(result: Result<T>) {
        completions.forEach { $0(result) }
    }
    
    internal func complete(result: Result<T>) {
        switch(result) {
        case .failure(_):
            switch(retryPolicy) {
            case .none:
                finish(result: result)
            default:
                retries < maxRetries ? retry() : finish(result: result)
            }
            
        case .success(_):
            finish(result: result)
        }
    }
    
    internal func retry() {
        retries += 1
        retryBlock()
    }
    
    internal func timedOut() {
        complete(result: .failure(Errors.timeout))
//        complete(Result.Failure<T>(TimeoutException("$id timed out after $timeout seconds")))
    }
}

enum Errors: Error {
    case cancelled
    case timeout
}
