//
//  PDFGen.swift
//  CommaBusinessFlowApp
//
//  Created by Andrew Haentjens on 31/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import Foundation
import TPPDF

class PDFGen {
    
    static func generatePDF(projectName: String) {
        guard let businessCases = DataController.fetchAllBusinessCases() else { return }
        
        let pdf = PDFGenerator(format: .a4)
        
        // Generate header
        let headerTableStyle = TableStyleDefaults.simple
        let noneLineStyle = LineStyle(type: .none, color: .white, width: 0.0)
        let headerTableLeftCellStyle = TableCellStyle(fillColor: .white, textColor: .black, font: UIFont.systemFont(ofSize: 17.0), borderLeft: noneLineStyle, borderTop: noneLineStyle, borderRight: noneLineStyle, borderBottom: noneLineStyle)
        let headerTableRightCellStyle = TableCellStyle(fillColor: .white, textColor: .black, font: UIFont.systemFont(ofSize: 17.0), borderLeft: noneLineStyle, borderTop: noneLineStyle, borderRight: noneLineStyle, borderBottom: noneLineStyle)
        
        headerTableStyle.setCellStyle(row: 0, column: 0, style: headerTableLeftCellStyle)
        headerTableStyle.setCellStyle(row: 0, column: 1, style: headerTableRightCellStyle)
        pdf.addTable(.headerCenter, data: [["Business Case Canvas", "Project Name: \(projectName)"]], alignment: [[.left, .left]], relativeColumnWidth: [0.4, 0.6], padding: 4.0, margin: 0.0, style: headerTableStyle)
        
        
        // First row
        let contentDataFirstRow = [
            [businessCases[0].question!, businessCases[1].question!, businessCases[3].question!, businessCases[4].question!, businessCases[6].question!]
        ]
        
        let contentAlignmentFirstRow: [[TableCellAlignment]] = [
            [.left, .left, .left, .left, .left]
        ]
        
        let columnWidthsFirstRow: [CGFloat] = [0.25, 0.25, 0.25, 0.25, 0.25]
        
        pdf.addTable(.contentCenter, data: contentDataFirstRow, alignment: contentAlignmentFirstRow, relativeColumnWidth: columnWidthsFirstRow, padding: 4.0, margin: 0.0, style: TableStyleDefaults.simple)
        
        // Second row
        let contentDataSecondRow = [
            [businessCases[7].question!, businessCases[8].question!]
        ]
        
        let contentAlignmentSecondRow: [[TableCellAlignment]] = [
            [.left, .left]
        ]
        
        let columnWidthsSecondRow: [CGFloat] = [0.5, 0.5]
        
        pdf.addTable(.contentCenter, data: contentDataSecondRow, alignment: contentAlignmentSecondRow, relativeColumnWidth: columnWidthsSecondRow, padding: 4.0, margin: 0.0, style: TableStyleDefaults.simple)
        
        let url = pdf.generatePDFfile(projectName)
        UIApplication.shared.openURL(url)
    }
}
