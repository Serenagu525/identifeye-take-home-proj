//
//  basic-tests.swift
//  client-exam-project
//
//  Created by Yuxuan Gu on 3/31/24.
//

import Foundation

func my_tests() -> Bool{
    //given example input
    patients = [String: Patient]()
    exams = [String: String]()
    orderedPatients = [String]()
    var filename = "../example-input.txt"
    if !compareLines(expected: "Name: JOHN DOE, Id: 123, Exam Count: 0" + "\n" + "Name: JANE CROW, Id: 789, Exam Count: 2", actual: aggregateData(from: filename)) {
        print(aggregateData(from: filename))
        return false
    }
    
    //test edge cases
    patients = [String: Patient]()
    exams = [String: String]()
    orderedPatients = [String]()
    filename = "../edge-cases.txt"
    if !compareLines(expected: "Name: JOHN DOE, Id: 123, Exam Count: 1", actual: aggregateData(from: filename)) {
        return false
    }
    
    //extensive test
    patients = [String: Patient]()
    exams = [String: String]()
    orderedPatients = [String]()
    filename = "../extensive-test.txt"
    if !compareLines(expected: "Name: JOHN DOE TEST LONG NAME, Id: 123, Exam Count: 0" + "\n" + "Name: JOHN, Id: 789, Exam Count: 2", actual: aggregateData(from: filename)) {
        return false
    }
    return true
    
}
func compareLines(expected: String, actual: String) -> Bool {
    let resultLines = expected.split(separator: "\n").map { String($0) }
    let expectedLines = actual.split(separator: "\n").map { String($0) }
    return resultLines == expectedLines
}
