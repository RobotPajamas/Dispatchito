////
////  Completable.swift
////  Dispatchito
////
////  Created by Suresh Joshi on 2018-10-20.
////  Copyright © 2018 Robot Pajamas. All rights reserved.
////
//
//public typealias CompletionBlock<T> = (Result<T>) -> Void
//
//protocol Completable {
//    associatedtype CompletableType
//    var completions: [CompletionBlock<CompletableType>] { get set }
//    func complete(result: Result<CompletableType>)
//}
//
//extension Completable {
//    func complete(result: Result<CompletableType>)  {
//        completions.forEach { $0(result) }
//    }
//}
