//
//  BodyTypeRequest.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import Foundation

protocol BodyTypeRequest {
    func setBodyInRequest(_ request: inout URLRequest) throws
}
