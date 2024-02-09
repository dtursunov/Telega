//
//  Debouncer.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import Foundation

import UIKit

// Базовый класс, для реализации логики отложенных вызовов throttle и debounce
class CallLimiter {
    fileprivate let queue: DispatchQueue = .main

    fileprivate let maxInterval: TimeInterval

    fileprivate var workItem: DispatchWorkItem?

    fileprivate var previousRun: Date = .distantPast

    public init(seconds: TimeInterval) {
        maxInterval = seconds
    }
}

// Отменяет все предыдущие вызовы, пока не пройдет время, большее чем maxInterval
final class Throttler: CallLimiter {
    public func throttle(block: @escaping () -> Void) {
        if Date.seconds(from: previousRun) > maxInterval {
            workItem?.cancel()
            workItem = DispatchWorkItem { [weak self] in
                self?.previousRun = Date()
                block()
            }

            // swiftlint:disable force_unwrapping
            queue.async(execute: workItem!)
            // swiftlint:enable force_unwrapping
        }
    }
}

// Ставит новые вызовы в очередь с задержкой, отменяя все предыдущие вызовы,
// которые не успели пройти за maxInterval
final class Debouncer: CallLimiter {
    public func debounce(block: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem {
            block()
        }
        // swiftlint:disable force_unwrapping
        queue.asyncAfter(deadline: .now() + Double(maxInterval), execute: workItem!)
        // swiftlint:enable force_unwrapping
    }
}

extension Date {
    fileprivate static func seconds(from referenceDate: Date) -> TimeInterval {
        Date().timeIntervalSince(referenceDate).rounded()
    }
}
