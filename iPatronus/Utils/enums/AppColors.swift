//
//  AppColors.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUICore

enum AppColors {
  
  static let colorBlack = Color(hex: "#0D0D0D")
  static let colorBlue = Color(hex: "#1C1F2B")
  static let colorSilver = Color(hex: "#AEB5C2")
  static let colorPurple = Color(hex: "#7A5CFA")
  static let colorGreen = Color(hex: "#3B945E")
  
  static let colorGryffindorRed = Color(hex: "#7F0909")
  static let colorGryffindorGold = Color(hex: "#FFC500")
  static let colorSlytherinGreen = Color(hex: "#1A472A")
  static let colorSlytherinSilver = Color(hex: "#C0C0C0")
  static let colorRavenclawBlue = Color(hex: "#0E1A40")
  static let colorRavenclawBronze = Color(hex: "#946B2D")
  static let colorHufflepuffYellow = Color(hex: "#FFDB00")
  static let colorHufflepuffBlack = Color(hex: "#000000")
  
  static let housePrimaryColorList: [Color] = [
    colorGryffindorRed,
    colorSlytherinGreen,
    colorRavenclawBlue,
    colorHufflepuffYellow
  ]
  
  static var randomHouseColor: Color {
    housePrimaryColorList.randomElement() ?? .clear
  }
}
