//
//  GFError.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import Foundation

enum GFError: String, Error {
    case badURL = "URL is invalid."
    case badUsername = "User not found. Check username and try again."
    case badConnection = "Unable to complete your request. Please check your internet connection."
    case badRequest = "Server responded with an error. Please try again later."
    case badData = "The data received from the server was invalid. Please try again later."
    case badDecode = "Unable to decode the data received from the server. Please try again later."
}
