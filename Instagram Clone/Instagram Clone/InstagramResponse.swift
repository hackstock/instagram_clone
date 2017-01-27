//
//  ResponseMetaData.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import Foundation

struct Response{
    var metaData: ResponseMetaData!
    var paginationInfo: PaginationInfo!
    
    init(metaData: ResponseMetaData, paginationInfo: PaginationInfo) {
        self.metaData = metaData
        self.paginationInfo = paginationInfo
    }
}


