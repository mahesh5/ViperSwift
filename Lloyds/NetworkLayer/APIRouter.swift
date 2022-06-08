//
//  APIRouter.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation

public enum APIRouter  {
    
    case getArticles
    
    public var path: String? {
        switch self {
        case .getArticles:
            return EndPoint.home
        }
    }
}
