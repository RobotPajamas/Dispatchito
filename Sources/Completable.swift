//
//  Completable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public typealias CompletionBlock<T> = (Result<T>) -> Void

protocol Completable {
    var completions: [CompletionBlock<Any>] { get set }
    func complete(result: Result<Any>)
}

extension Completable {
    func complete(result: Result<Any>)  {
        completions.forEach { $0(result) }
    }
}
