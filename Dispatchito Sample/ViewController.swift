//
//  ViewController.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import UIKit
import Dispatchito

class ViewController: UIViewController {

    private let dispatcher = SerialDispatcher(executeOn: DispatchQueue.main, dispatchOn: DispatchQueue.main)
    private lazy var dispatchNone: Dispatch<String> = {
        return Dispatch<String>(id: "", execution: { (_) in
        })
    }()
    private lazy var dispatchRetry: Dispatch<String> = {
        return Dispatch<String>(id: "", execution: { (_) in
        })
    }()
    private lazy var dispatchReschedule: Dispatch<String> = {
        return Dispatch<String>(id: "", execution: { (_) in
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passAll()
        failAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dispatcher.start()
        }
    }
    
    private func passAll() {
        dispatchNone = Dispatch(
            id: "NONE",
            retryPolicy: .none,
            execution: { (cb) in
                let message = "\(self.dispatchNone.id): Executing... Will pass.\n"
                print(message)
                cb(.success("\(self.dispatchNone.id) - Woot!"))
        }) { (result) in
            print("\(self.dispatchNone.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchNone.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchNone.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatchRetry = Dispatch(
            id: "RETRY",
            retryPolicy: .retry,
            execution: { (cb) in
                let message = "\(self.dispatchRetry.id): Executing... Will pass.\n"
                print(message)
                cb(.success("\(self.dispatchRetry.id) - Woot!"))
        }) { (result) in
            print("\(self.dispatchRetry.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchRetry.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchRetry.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatchReschedule = Dispatch(
            id: "RESCHEDULE",
            retryPolicy: .reschedule,
            execution: { (cb) in
                let message = "\(self.dispatchReschedule.id): Executing... Will pass.\n"
                print(message)
                cb(.success("\(self.dispatchReschedule.id) - Woot!"))
        }) { (result) in
            print("\(self.dispatchReschedule.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchReschedule.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchReschedule.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatcher.enqueue(item: dispatchReschedule)
        dispatcher.enqueue(item: dispatchNone)
        dispatcher.enqueue(item: dispatchRetry)
    }
    
    private func failAll() {
        dispatchNone = Dispatch(
            id: "NONE",
            retryPolicy: .none,
            execution: { (cb) in
                let message = "\(self.dispatchNone.id): Executing... Will fail.\n"
                print(message)
                cb(.failure(FakeError.faked))
        }) { (result) in
            print("\(self.dispatchNone.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchNone.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchNone.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatchRetry = Dispatch(
            id: "RETRY",
            retryPolicy: .retry,
            execution: { (cb) in
                let message = "\(self.dispatchRetry.id): Executing... Will fail.\n"
                print(message)
                cb(.failure(FakeError.faked))
        }) { (result) in
            print("\(self.dispatchRetry.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchRetry.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchRetry.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatchReschedule = Dispatch(
            id: "RESCHEDULE",
            retryPolicy: .reschedule,
            execution: { (cb) in
                let message = "\(self.dispatchReschedule.id): Executing... Will fail.\n"
                print(message)
                cb(.failure(FakeError.faked))
        }) { (result) in
            print("\(self.dispatchReschedule.id): Completion running")
            switch(result) {
            case .success(let value):
                let message = "\(self.dispatchReschedule.id): Completion success - \(value)\n"
                print(message)
            case .failure(let error):
                let message = "\(self.dispatchReschedule.id): Completion failure - \(error)\n"
                print(message)
            }
        }
        
        dispatcher.enqueue(item: dispatchReschedule)
        dispatcher.enqueue(item: dispatchNone)
        dispatcher.enqueue(item: dispatchRetry)
    }
}

enum FakeError: Error {
    case faked
}

