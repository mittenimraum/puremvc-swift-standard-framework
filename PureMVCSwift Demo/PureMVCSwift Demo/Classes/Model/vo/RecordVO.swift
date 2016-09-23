//
//  RecordVO.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 06.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import SwiftyJSON

func == (a: RecordVO, b: RecordVO) -> Bool {
    return a.interpret == b.interpret && a.album == b.album && a.year == b.year && a.genres == b.genres
}

class RecordVO: Equatable {

    var interpret: String?
    var album: String?
    var year: String?
    var genres: String?

    class func initWithData(data: JSON) -> RecordVO {
        return RecordVO(interpret: data["interpret"].string!,
            album: data["album"].string!,
            year: data["year"].string!,
            genres: data["genres"].string!)
    }

    init(interpret: String?, album: String?, year: String?, genres: String?) {
        self.interpret = interpret
        self.album = album
        self.year = year
        self.genres = genres
    }

    func sortedGenres() -> String {

        var a: Array = self.genres!.componentsSeparatedByString(", ")
        a.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }

        return a.combine(", ")
    }
}
