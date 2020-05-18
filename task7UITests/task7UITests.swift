//
//  task7UITests.swift
//  task7UITests
//
//  Created by Oksana Kotilevska on 12/6/19.
//  Copyright © 2019 Oksana Kotilevska. All rights reserved.
//

import XCTest

class task7UITests: XCTestCase {
    
        var app: XCUIApplication!
    var displayLabel: XCUIElement!
    let numericButtonIdentifierValues: [UInt] = Array(1 ... 7) + [0]

    // MARK: - Set Up & Tear Down

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        displayLabel = XCUIApplication().staticTexts.element(matching: .staticText, identifier: "displayLabel")
    }

    override func tearDown() {
        displayLabel = nil
        app = nil
    }

    
    // MARK: - Numberic Buttons Tests

    func test_pressingButtonWithNumber_WhenNoOperationsApplied_AppendsDigitToTheDisplay() {
        // 1. Arrange
        var desiredDisplayedText = ""

        numericButtonIdentifierValues.forEach {
            desiredDisplayedText += "\($0)"

            // 2. Act
            // Tap each number button, from 1 to 0
            tap($0)

            // 3. Assert
            XCTAssertEqual(displayLabel.label, desiredDisplayedText)
        }
    }

    // MARK: - Multiple Calculations (Different Operation)

    func test_performingMultipleCalculations_AdditionAndSubtraction_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "10"

        // 2. Test if subtraction after addition works
        // 2.1. Act
        tap(7)
        tap(.add)
        tap(8)
        tap(.subtract)
        tap(5)
        tap(.equals)

        // 2.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Subtraction after addition doesn't work properly")

        tap(.clear)

        // 3. Test if addition after multiplication works
        // 3.1. Act
        tap(9)
        tap(.subtract)
        tap(2)
        tap(.add)
        tap(3)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Addition after substraction doesn't work properly")
    }

    func test_performingMultipleCalculations_AdditionAndMultiplication_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "10"

        // 2. Test if multiplication after addition works
        // 2.1. Act
        tap(2)
        tap(.add)
        tap(3)
        tap(.multiply)
        tap(2)
        tap(.equals)
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiplication after addition doesn't work properly")

        tap(.clear)

        // 3. Test if addition after multiplication works
        // 3.1. Act
        tap(2)
        tap(.multiply)
        tap(4)
        tap(.add)
        tap(2)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Addition after multiplication doesn't work properly")
    }

    func test_performingMultipleCalculations_AdditionAndDivision_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "5"

        // 2. Test if division after multiplication works
        // 2.1. Act
        tap(7)
        tap(.add)
        tap(3)
        tap(.divide)
        tap(2)
        tap(.equals)

        // 2.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Division after addition doesn't work properly")

        tap(.clear)

        // 3. Test if addition after division works
        // 3.1. Act
        tap(8)
        tap(.divide)
        tap(2)
        tap(.add)
        tap(1)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Addition after division doesn't work properly")
    }

    func test_performingMultipleCalculations_MultiplicationAndDivision_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "2"

        // 2. Test if division after multiplication works
        // 2.1. Act
        tap(5)
        tap(.multiply)
        tap(2)
        tap(.divide)
        tap(5)
        tap(.equals)

        // 2.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Division after multiplication doesn't work properly")

        tap(.clear)

        // 3. Test if multiplication after division works
        // 3.1. Act
        tap(9)
        tap(.divide)
        tap(9)
        tap(.multiply)
        tap(2)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiplication after division doesn't work properly")
    }

    func test_performingMultipleCalculations_MultiplicationAndSubtraction_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "2"

        // 2. Test if subtraction after multiplication works
        // 2.1. Act
        tap(5)
        tap(.multiply)
        tap(2)
        tap(.subtract)
        tap(8)
        tap(.equals)

        // 2.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Subtraction after multiplication doesn't work properly")

        tap(.clear)

        // 3. Test if multiplication after subtraction works
        // 3.1. Act
        tap(9)
        tap(.subtract)
        tap(8)
        tap(.multiply)
        tap(2)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiplication after subtraction doesn't work properly")
    }

    func test_performingMultipleCalculations_SubtractionAndDivision_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "3"

        // 2. Test if division after subtraction works
        // 2.1. Act
        tap(9)
        tap(.subtract)
        tap(3)
        tap(.divide)
        tap(2)
        tap(.equals)
        XCTAssertEqual(displayLabel.label, desiredResult, "Division after subtraction doesn't work properly")

        // 2.2. Assert
        tap(.clear)

        // 3. Test if subtraction after division works
        // 3.1. Act
        tap(8)
        tap(.divide)
        tap(2)
        tap(.subtract)
        tap(1)
        tap(.equals)

        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Subtraction after division doesn't work properly")
    }

    // MARK: - Multiple Calculations (Same Operation With Multiple Numbers)

    func test_performingMultipleCalculations_MultipleAddition_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "10"

        // 2. Act
        tap(7)
        tap(.add)
        tap(1)
        tap(.add)
        tap(2)
        tap(.equals)

        // 3. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiple addition doesn't work properly")
    }

    func test_performingMultipleCalculations_MultipleSubtraction_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "1"

        // 2. Act
        tap(9)
        tap(.subtract)
        tap(5)
        tap(.subtract)
        tap(3)
        tap(.equals)

        // 3. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiple subtraction doesn't work properly")
    }

    func test_performingMultipleCalculations_MultipleMultiplication_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "30"

        // 2. Act
        tap(2)
        tap(.multiply)
        tap(3)
        tap(.multiply)
        tap(5)
        tap(.equals)

        // 3. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiple multiplication doesn't work properly")
    }

    func test_performingMultipleCalculations_MultipleDivision_WorksSequentially() {
        // 1. Arrange
        let desiredResult = "1"

        // 2. Act
        tap(8)
        tap(.divide)
        tap(4)
        tap(.divide)
        tap(2)
        tap(.equals)

        // 3. Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Multiple division doesn't work properly")
    }

    // MARK: - Percent Tests

    func test_percent_WhenNoOperationsPerformed_ShowsNumberDividedByHundred() {
        // 8 % must return 0.08
        // 1. Arrange
        let firstResult = "0.08"
        let secondResult = "0.0008"

        // 2. First tap on '%'
        // 2.1. Act
        tap(8)
        tap(.percent)
        // 2.2. Assert
        XCTAssertEqual(displayLabel.label, firstResult)

        // 3. Second tap on '%'
        // 3.1. Act
        tap(.percent)
        // 3.2. Assert
        XCTAssertEqual(displayLabel.label, secondResult)
    }
    
    func test_pressingModuloButtonAfterEqualsIsPressed_resultConvertsByPercent() {
        //1.Arrange
        let desiredResult = "0.05"
        
        //2.Act
        tap(2)
        tap(.add)
        tap(3)
        tap(.equals)
        tap(.percent)
        //Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "Modulo doesn't affect result")
    }
    
    func test_pressPercentAfterEqualsAndChangeSignAreApplied_performsPercentOperation(){
        //1.Arrange
        let desiredResult = "-0.08"
        
        //2.Act
        tap(6)
        tap(.add)
        tap(2)
        tap(.equals)
        tap(.changeSign)
        tap(.percent)
        
        //3.Assert
        XCTAssertEqual(displayLabel.label, desiredResult)
    }
    
    // MARK: - Equals Operation Tests
    
    func test_numberOnScreen_NumberEnteredAfterEqualsWasPressed_startsInputFromScratch() {
        //1.Arrange
        let desiredResult = "33"
        
        //2.Act
        tap(1)
        tap(.multiply)
        tap(5)
        tap(.equals)
        tap(3)
        tap(3)
        
        //3.Assert
        XCTAssertEqual(displayLabel.label, desiredResult, "")
    }

    func test_equals_AfterAddingTwoNumbersAndCallingPercent_ShowsHowMuchIsFirstNumberPlusSecondNumberPercentOfFirstNumber() {
        // 10 + 20 % must return 12

        // 1. Arrange
        let desiredResultAfterPercent = "2"
        let desiredResultAfterPercentAndEquals = "12"

        // 2. Act
        // Enter 10
        tap(1)
        tap(0)

        // Call '+'
        tap(.add)

        // Enter 20
        tap(2)
        tap(0)

        // Call '%'
        tap(.percent)
        
        XCTAssertEqual(displayLabel.label, desiredResultAfterPercent, "a + b % Should show b percent of a")

        // Call '='
        tap(.equals)

        // 3. Assert
        XCTAssertEqual(displayLabel.label, desiredResultAfterPercentAndEquals, "a + b % = Should show a plus b percent of a")
    }

    func test_equals_AfterAdditionWithSingleOperand_AddsNumberToItself() {
        // 1. Arrange
        let buttonValue: UInt = 5
        var desiredResultValue = buttonValue

        tap(buttonValue)
        tap(.add)

        for _ in 1...3 {
            desiredResultValue += buttonValue

            // 2. Act
            tap(.equals)

            // 3. Assert
            XCTAssertEqual(displayLabel.label, "\(desiredResultValue)", "Multiple addition with single operand doesn't work properly")
        }
    }

    func test_equals_AfterSubtractionWithSingleOperand_SubtractsNumberFromItself() {
        // 1. Arrange
        let buttonValue = 7
        var desiredResultValue: Int = buttonValue

        tap(UInt(buttonValue))
        tap(.subtract)

        for _ in 1...3 {
            desiredResultValue -= buttonValue

            // 2. Act
            tap(.equals)

            // 3. Assert
            XCTAssertEqual(displayLabel.label, "\(desiredResultValue)", "Multiple subtraction with single operand doesn't work properly")
        }
    }

    func test_equals_AfterMultiplicationWithSingleOperand_MultipliesNumberByItself() {
        // 1. Arrange
        let buttonValue: UInt = 8
        var desiredResultValue = buttonValue

        tap(buttonValue)
        tap(.multiply)

        for _ in 1...3 {
            desiredResultValue *= buttonValue

            // 2. Act
            tap(.equals)

            // 3. Assert
            XCTAssertEqual(displayLabel.label, "\(desiredResultValue)", "Multiple multiplication with single operand doesn't work properly")
        }
    }

    func test_equals_AfterDivisionWithSingleOperand_DividesNumberByItself() {
        // 1. Arrange
        let buttonValue: UInt = 2
        var desiredResultValue = 2.0
        tap(buttonValue)
        tap(.divide)

        for _ in 1...3 {
            desiredResultValue /= Double(buttonValue)

            // 2. Act
            tap(.equals)

            // 3. Assert
            XCTAssertEqual(Double(displayLabel.label), desiredResultValue, "Multiple division with single operand doesn't work properly")
        }

    }

    // MARK: - Error Message Tests

    func test_ErrorMessage_OnDivisionByZeroError_BlocksAllButtonsUntilCleared() {
        // 1. Arrange
        // Get division by zero error message to show and capture it.
        tap(6)
        tap(.divide)
        tap(0)
        tap(.equals)
        let errorMessage = displayLabel.label

        // 2. Try other operations
        Button.allCases.filter { $0 != .clear }.enumerated().forEach { offset, button in
            // 2.1.
            // Act: Tap number button.
            tap(UInt(offset))
            // Assert: Check if the error message is still there.
            XCTAssertEqual(displayLabel.label, errorMessage, "Not showing error anymore!")

            // 2.2.
            // Act: Tap action button.
            tap(button)
            // Assert: Check if the error message is still there.
            XCTAssertEqual(displayLabel.label, errorMessage, "Not showing error anymore!")
        }

        // 3. Check if clear button clears error.
        // 3.1. Act: Tap clear button.
        tap(.clear)
        // 3.2. Assert: Check if error message is cleared.
        XCTAssertNotEqual(displayLabel.label, errorMessage, "Still showing error!")
    }

    func test_ErrorMessage_OnOverflowError_BlocksAllOperationsUntilCleared() {
        // 1. Arrange
        // Get overflow error message to show and capture it.
        let usedButtonValues = numericButtonIdentifierValues.dropLast().reversed()
        usedButtonValues.forEach {
            tap($0)
        }
        tap(.multiply)
        usedButtonValues.forEach {
            tap($0)
        }
        tap(.equals)
        let errorMessage = displayLabel.label

        // 2. Try other operations
        Button.allCases.filter { $0 != .clear }.enumerated().forEach { offset, button in
            // 2.1.
            // Act: Tap number button.
            tap(UInt(offset))
            // Assert: Check if the error message is still there.
            XCTAssertEqual(displayLabel.label, errorMessage, "Not showing error anymore!")

            // 2.2.
            // Act: Tap action button.
            tap(button)
            // Assert: Check if the error message is still there.
            XCTAssertEqual(displayLabel.label, errorMessage, "Not showing error anymore!")
        }

        // 3. Check if clear button clears error.
        // 3.1. Act: Tap clear button.
        tap(.clear)
        // 3.2. Assert: Check if error message is cleared.
        XCTAssertNotEqual(displayLabel.label, errorMessage, "Still showing error!")
    }

    // MARK: - Private Helper Methods

    private func tap(_ button: Button) {
        app.buttons.element(matching: .button, identifier: button.rawValue).tap()
    }

    private func tap(_ buttonNumber: UInt) {
        app.buttons.element(matching: .button, identifier: "\(buttonNumber)").tap()
    }

    // MARK: - Private Helper Types

    private enum Button: String, CaseIterable {
        case clear
        case changeSign = "+/-"
        case percent = "%"
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case equals = "="
        case decimalSign
    }
}
