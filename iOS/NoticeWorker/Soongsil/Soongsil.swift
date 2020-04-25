//
//  Seoul_Soongsil.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class NW_Soongsil: Organization {
    public override init() {
        super.init()
        
        self.collegeCodeList = generateCollegeList()
        self.mappingCollegeDept()
        self.setOrganizationDept()
        self.organizationCode = .Soongsil
    }
    
    override func generateCollegeList() -> [CollegeName]? {
        var collegeList = [CollegeName]()
        for codeCase in SoongsilCollegeCode.allCases {
            collegeList.append(codeCase.rawValue)
        }
        return collegeList
    }
    
    public func testFunc() -> [Notice] {
        var items = [TestNotice]()
        let noticeProperty: [TestNoticeProperty] = [.date(value: "2020-04-26"),
                                                    .title(value: "Test Title"),
                                                    .isActive(value: false),
                                                    .url(value: "https://www.google.com"),
                                                    .author(value: "TestAuthor"),
                                                    .custom(key: "viewCount", value: 100),
                                                    .custom(key: "isNew", value: false)]
        
        let item = TestNotice(property: noticeProperty)
        items.append(item)
        
        let _ = noticeProperty.contains(where: ({ $0.key == TestNoticeProperty.title(value: "").key }))
        
        var testItems = [Notice]()
        var testItem = Notice(title: "Test Title", url: "https://www.google.com")
        testItem.author = "Test"
        testItem.date = "2020-04-25"
        testItem.isActive = true
        testItem.custom = ["viewCount": 100]
        testItems.append(testItem)
        
        let _ = testItem.custom?["viewCount"]
        return testItems
    }
    
    override func getNoticeList(html: String) -> [Notice]? {
        return testFunc()
    }
    
    override func getCollegeCount() -> Int? {
        return super.collegeList?.count
    }
    
    override func getSchoolName() -> String? {
        return "숭실대학교"
    }
    
    override func getNoticeURL(dept name: DeptName, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        // MARK: TEMP
        if name == SoongsilDept.IT_Computer(page: nil, keyword: nil).deptName {
            completion(.failure(.invalid))
        }
        completion(.failure(.emptyKeyword))
    }
    
    override func getDeptList(collegeName: CollegeName) -> [DeptItem]? {
        return collegeList?.filter({ $0.collegeName == collegeName }).first?.deptList
    }
    
    override func getDeptCount(collegeName: String) -> Int? {
        return super.collegeList?.filter({ $0.collegeName == collegeName }).first?.deptList?.count
    }
    
//    override func setOrganizationDept() {
//        collegeList = [College]()
//        
//        for collegeCode in self.collegeCodeList as! [CollegeName] {
//            var college = College()
//            college.collegeName = collegeCode
//            if let deptList = mappingTable?.filter({ $0.college == collegeCode }).first?.deptList {
//                var tempList = [DeptItem]()
//                for deptItem in deptList {
//                    tempList.append(deptItem)
//                }
//                college.deptList = tempList
//            }
//            collegeList?.append(college)
//        }
//    }
}
