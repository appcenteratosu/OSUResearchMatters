//
//  ColorCode.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/4/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit

struct ColorCode {
    
    let VPR = #colorLiteral(red: 0.9633523822, green: 0.5470512509, blue: 0.2126187086, alpha: 1)
    let DASNR = #colorLiteral(red: 0.6373615265, green: 0.6335752606, blue: 0.6402737498, alpha: 1)
    let ArtsSciences = #colorLiteral(red: 0.1008877531, green: 0.1766014695, blue: 0.8010639548, alpha: 1)
    let Business = #colorLiteral(red: 0, green: 0.406540364, blue: 0, alpha: 1)
    let Education = #colorLiteral(red: 1, green: 0.9805650115, blue: 0, alpha: 1)
    let CEAT = #colorLiteral(red: 0.7549046874, green: 0.4226810932, blue: 1, alpha: 1)
    let HumanSciences = #colorLiteral(red: 0.5488849282, green: 0.4376385808, blue: 0.3732229471, alpha: 1)
    let CVHS = #colorLiteral(red: 0.9468200803, green: 0, blue: 0, alpha: 1)
    let GradCollege = #colorLiteral(red: 0.4165593386, green: 0.8386890292, blue: 0.9972121119, alpha: 1)
    let Library = #colorLiteral(red: 0.9175626636, green: 0.8091819882, blue: 0.7050410509, alpha: 1)
    let TDC = #colorLiteral(red: 0.1703742743, green: 0.912766397, blue: 0.3849914968, alpha: 1)
    let CenterForHealthSciences = #colorLiteral(red: 0.8675895929, green: 0.7453619838, blue: 0.2566216588, alpha: 1)
    let SpecialPrograms = #colorLiteral(red: 0.4165593386, green: 0.8386890292, blue: 0.9972121119, alpha: 1)
    
    
    func getSponsorColor(sponsor: String) -> UIColor {
        switch sponsor {
        case "RESEARCH", "VICE PRESIDENT FOR RESEARCH":
            return #colorLiteral(red: 0.9633523822, green: 0.5470512509, blue: 0.2126187086, alpha: 1)
        case "BAE", "CASNR", "DASNR", "ESGP", "FOOD AND AG PRODUCT CENTER", "HORTICULTURE AND LANDSCAPE ARCHITECTURE", "PLANT AND SOIL SCIENCES", "THE BOTANIC GARDEN":
            return #colorLiteral(red: 0.6373615265, green: 0.6335752606, blue: 0.6402737498, alpha: 1)
        case "ALLIED ARTS",
            "ART DEPARTMENT",
            "ARTS & SCIENCES",
            "BOTANY",
            "ENGLISH DEPARTMENT",
            "HISTORY DEPT",
            "MUSIC DEPARTMENT",
            "PHILOSOPHY",
            "THEATRE":
            return #colorLiteral(red: 0.1008877531, green: 0.1766014695, blue: 0.8010639548, alpha: 1)
        case "CENTER FOR EXEC AND PROF DEVE",
             "SPEARS SCHOOL OF BUSINESS":
            return #colorLiteral(red: 0, green: 0.406540364, blue: 0, alpha: 1)
        case "COLLEGE OF EDUCATION",
             "COLLEGE OF EDUCATION OUTREACH":
            return #colorLiteral(red: 1, green: 0.9805650115, blue: 0, alpha: 1)
        case "CEAT":
            return #colorLiteral(red: 0.7549046874, green: 0.4226810932, blue: 1, alpha: 1)
        case "COLLEGE OF HUMAN SCIENCES":
            return #colorLiteral(red: 0.5488849282, green: 0.4376385808, blue: 0.3732229471, alpha: 1)
        case "CENTER FOR VETERINARY HEALTH SCIENCES",
             "OSU CENTER FOR VET HEALTH SCIENCES":
            return #colorLiteral(red: 0.9468200803, green: 0, blue: 0, alpha: 1)
        case "GRADUATE COLLEGE":
            return #colorLiteral(red: 0.4165593386, green: 0.8386890292, blue: 0.9972121119, alpha: 1)
        case "CENTER FOR HEALTH SYSTEMS INNOVATION":
            return #colorLiteral(red: 0.8675895929, green: 0.7453619838, blue: 0.2566216588, alpha: 1)
        case "ACADEMIC AFFAIRS",
             "ADMINISTRATION",
             "ALUMNI ASSOCIATION",
             "ARC",
             "ATHLETICS",
             "CAREER SERVICES",
             "CENTER FOR ETHICAL LEADERSHIP",
             "CENTER FOR SOVEREIGN NATIONS",
             "DEPARTMENT OF WELLNESS",
             "DIVISION OF INTERNATIONAL STUDIES AND OUTREACH",
             "ENVIRONMENTAL HEALTH AND SAFETY",
             "FELLOWSHIP OF CHRISTIAN FACULTY AND STAFF",
             "FRATERNITY & SORORITY AFFAIRS",
             "HUMAN RESOURCES",
             "INFORMATION TECHNOLOGY",
             "INSTITUTIONAL DIVERSITY",
             "INTERNATIONAL STUDENT ORGANIZATION",
             "INTERNATIONAL STUDENTS AND SCHOLARS",
             "INTERNATIONAL STUDIES AND OUTREACH",
             "ITLE",
             "LEADERSHIP AND CAMPUS LIFE",
             "MINORITY WOMEN’S ASSOCIATION",
             "MORTAR BOARD",
             "NATIVE AMERICAN STUDENT ASSOCIATION",
             "NEW STUDENT ORIENTATION & ENROLLMENT",
             "NON-TRADITIONAL STUDENT ORGANIZATION",
             "OFF CAMPUS STUDENT ASSOCIATION",
             "OKLAHOMA STATE QUEERS AND ALLIES",
             "OSTATETV",
             "OSU FOUNDATION",
             "OSU FULBRIGHT OFFICE",
             "OSU MUSEUM OF ART",
             "OSU PARENTS ASSOCIATION",
             "REGISTRAR",
             "RES LIFE",
             "TRAINING SERVICES",
             "UNITED WAY",
             "UNIVERSITY CLUB",
             "UNIVERSITY COLLEGE",
             "UNIVERSITY COUNSELING SVCS",
             "UNIVERSITY DINING SERVICES",
             "UNIVERSITY HEALTH SERVICES",
             "UNIVERSITY STORE",
             "WOMEN’S PROGRAMS",
             "STAFF ADVISORY COUNCIL",
             "STUDENT AFFAIRS",
             "STUDENT CONDUCT",
             "STUDENT GOVERNMENT ASSOCIATION",
             "STUDENT UNION ACTIVITIES BOARD",
             "STUDENT UNION MARKETING",
             "STUDY ABROAD OFFICE",
             "SCHOLAR DEVELOPMENT & RECOGNITION",
             "THE OFFICE OF MULTICULTURAL AFFAIRS",
             "OSU WRITING CENTER":
            return #colorLiteral(red: 0.3727787733, green: 0.3705678582, blue: 0.3744815588, alpha: 1)
        default:
            return #colorLiteral(red: 0.3961746991, green: 0.396246016, blue: 0.3961652517, alpha: 1)
        }
    }
}
