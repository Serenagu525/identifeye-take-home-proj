//
//  main.swift
//  client-exam-project
//
//  Created by Yuxuan Gu on 3/31/24.
//

import Foundation

struct Patient {
    let name: String
    var numExam: Int
    mutating func incrementExam() {
        numExam += 1
    }
    mutating func decrementExam() {
        numExam -= 1
    }
}


var patients = [String: Patient]()
var exams = [String: String]()
var orderedPatients = [String]()  //used to maintain insertion order


func aggregateData(from filename: String) -> String{
    do {
        let contents = try String(contentsOfFile: filename)
        let lines = contents.split(separator:"\n")
        for instruction in lines {
            let components = instruction.components(separatedBy: .whitespaces)
                if components.isEmpty { continue }
            switch components[1] {
            case "PATIENT":
                if components[0] == "ADD" {
                    addPatient(inst: components)
                } else if components[0] == "DEL" {
                    deletePatient(inst: components)
                }
            case "EXAM":
                if components[0] == "ADD" {
                    addExam(inst: components)
                } else if components[0] == "DEL" {
                    deleteExam(inst: components)
                }
            default:
                break
            }
        }
        return displaySummary()
    } catch {
        return String("Error reading file: \(error)")
    }
    
}
func addPatient(inst: [String]) {
    let patientIdentifier = inst[2]
    let patientName = inst[3...].joined(separator: " ")
    //check if identifier already exists
    if patients.keys.contains(patientIdentifier) {
        return
    }
    patients[patientIdentifier] = Patient(name: patientName, numExam: 0)
    orderedPatients.append(patientIdentifier)
}

func addExam(inst:[String]) {
    let patientIdentifier = inst[2]
    let examIdentifier = inst[3]
    //check if patient identifier exists
    if !patients.keys.contains(patientIdentifier) {
        return
    }
    //check if exam identifier exists
    if exams.keys.contains(examIdentifier) {
        return
    }
    patients[patientIdentifier]!.incrementExam()
    exams[examIdentifier] = patientIdentifier
}

func deleteExam(inst: [String]) {
    let examIdentifier = inst[2]
    //check if exam identifier exists
    if !exams.keys.contains(examIdentifier) {
        return
    }
    patients[exams[examIdentifier]!]!.decrementExam()
    exams.removeValue(forKey: examIdentifier)
}

func deletePatient(inst: [String]) {
    let patientIdentifier = inst[2]
    if !patients.keys.contains(patientIdentifier) {
        return
    }
    exams = exams.filter {$0.value != patientIdentifier}
    patients.removeValue(forKey: patientIdentifier)
    orderedPatients.removeAll {$0 == patientIdentifier}
}

func displaySummary() -> String {
    var result = ""
    for id in orderedPatients {
        if let patientInfo = patients[id] {
            result += String("Name: \(patientInfo.name), Id: \(id), Exam Count: \(patientInfo.numExam)" + "\n")
        }
    }
    return result
}


//running for individual txt file path, use path relative to build products
print(aggregateData(from: "../../../../../../../../Desktop/swift/identifeye-proj/example-input.txt"))
//tests
print(my_tests())





