//
//  PromptModel.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-02.
//

import Foundation

var PROMPTS: [String] = [
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?",
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?",
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?",
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?",
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?",
    "What does love mean to you? ",
    "What is your dream job? Describe a typical work day at this job.",
    "Would you want to be the president? Why or why not?",
    "What are the most important qualities in a friend? Are you a good friend? Why or why not?",
    "Is it ever okay to lie? Why do you think so?"
]
struct PromptModel: Codable, Identifiable{
    var id: UUID = UUID()
    var index: Int
    var date: Date
    var prompt: String
}
