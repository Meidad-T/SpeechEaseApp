//
//  LearningManager+Conciseness.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var concisenessLessons: [Lesson] {
        return [
            Lesson(
                id: "concise-1",
                title: "The Fluff Finder",
                icon: "scissors",
                content: [
                    "Filler words like 'basically', 'actually', and 'literally' add zero value to your message.",
                    "They are verbal placeholders that dilute your authority. Become aware of your defaults and replace them with silent pauses."
                ],
                quizQuestion: "Which of the following words is considered 'fluff' that dilutes a speech?",
                quizOptions: ["Consequently", "Basically", "Because", "Illustrate"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-2",
                title: "Brevity is Strength",
                icon: "bolt.fill",
                content: [
                    "More words do not equal more intelligence. In fact, the most powerful messages are often the shortest.",
                    "If you can cut a word without changing the meaning of a sentence, cut it."
                ],
                quizQuestion: "What is the primary benefit of concise speech?",
                quizOptions: ["It makes the speech longer", "It increases impact and keeps audience attention", "It avoids having to do research", "It allows you to speak slower"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-3",
                title: "Active Voice Power",
                icon: "arrow.forward.circle.fill",
                content: [
                    "Passive voice ('The project was led by me') makes you sound passive and wordy.",
                    "Active voice ('I led the project') is direct, energetic, and uses fewer words."
                ],
                quizQuestion: "Which sentence is written in the active voice?",
                quizOptions: ["The speech was delivered by the speaker.", "The speaker delivered the speech.", "Delivered by the speaker was the speech.", "The speech has been delivered."],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-4",
                title: "Avoiding Double Speak",
                icon: "exclamationmark.triangle",
                content: [
                    "Double speak and corporate jargon ('synergize standard frameworks') hide a lack of substance.",
                    "Speak in plain, direct terms. If a child cannot understand the essence of your point, it is too complex."
                ],
                quizQuestion: "Why should corporate jargon be avoided in speeches?",
                quizOptions: ["It sounds too friendly", "It obscures your actual message and alienates listeners", "It is grammatically incorrect", "It is too short"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-5",
                title: "The Sentence Trim",
                icon: "trim",
                content: [
                    "Redundancy is a silent killer. Saying things like 'collaborate together' or 'advance forward' repeats the same concept.",
                    "Edit your sentences to eliminate redundant pairings."
                ],
                quizQuestion: "Which of the following phrases contains a redundancy?",
                quizOptions: ["Plan ahead", "Collaborate together", "New innovation", "All of the above"],
                correctOptionIndex: 3
            ),
            Lesson(
                id: "concise-6",
                title: "Precise Verb Selection",
                icon: "sparkle",
                content: [
                    "Instead of using a weak verb and an adverb ('run quickly'), use a single strong verb ('sprint').",
                    "Strong verbs paint clear mental pictures and trim unnecessary words."
                ],
                quizQuestion: "Which is a stronger, more concise replacement for 'look closely at'?",
                quizOptions: ["Scrutinize", "Stare at", "See", "Glance"],
                correctOptionIndex: 0
            ),
            Lesson(
                id: "concise-7",
                title: "One Key Idea",
                icon: "1.circle",
                content: [
                    "Do not pack multiple unrelated ideas into a single paragraph or slide.",
                    "Focus on one single thought, explain it, and move on. This prevents overwhelming your listener."
                ],
                quizQuestion: "How many central ideas should a single slide or speech section cover?",
                quizOptions: ["As many as possible", "Exactly one", "Three to five", "None, keep it general"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-8",
                title: "The Elevator Summary",
                icon: "timer",
                content: [
                    "An 'Elevator Pitch' is the ultimate exercise in conciseness: explaining a complex concept in 30 seconds.",
                    "Identify only the problem, the solution, and the unique value. Ignore the operational details."
                ],
                quizQuestion: "What is the main goal of an elevator summary?",
                quizOptions: ["To secure a full contract immediately", "To explain the core value of an idea in under 30 seconds", "To fill time in an elevator ride", "To present full financial statements"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-9",
                title: "Data Conciseness",
                icon: "chart.bar.fill",
                content: [
                    "Audience members cannot process a wall of numbers.",
                    "Highlight only the single most impactful statistic. If you have a spreadsheet, extract the main trend instead."
                ],
                quizQuestion: "How should you present data concisely?",
                quizOptions: ["Read out the entire data sheet", "Highlight the single most impactful trend or statistic", "Skip data completely", "Display a highly detailed spreadsheet"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-10",
                title: "The Edit Phase",
                icon: "pencil.and.outline",
                content: [
                    "First drafts are for getting ideas down. The edit phase is for cutting fluff.",
                    "A good rule of thumb is to challenge yourself to cut at least 20% of your draft's word count."
                ],
                quizQuestion: "What is a recommended target for cutting words from a first draft?",
                quizOptions: ["0% - keep it original", "At least 20%", "Exactly 90%", "Only cut the introduction"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-11",
                title: "Direct Answers",
                icon: "arrow.turn.down.right",
                content: [
                    "When asked a question during Q&A, use the BLUF method: Bottom Line Up Front.",
                    "Answer with a direct 'Yes', 'No', or statement immediately, then provide your 1-2 sentences of context."
                ],
                quizQuestion: "What does the BLUF method stand for?",
                quizOptions: ["Body Language Under Focus", "Bottom Line Up Front", "Briefing Logic and Utility Format", "Bold Line Ultimate Focus"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "concise-12",
                title: "Respecting the Clock",
                icon: "clock.fill",
                content: [
                    "Going over time is a sign of poor preparation and disrespects your listeners' schedule.",
                    "Always aim to finish 1-2 minutes under your allotted time. It leaves a professional, lasting impression."
                ],
                quizQuestion: "What is the best way to respect the clock?",
                quizOptions: ["Speak faster to fit everything in", "Plan and practice to finish slightly under your allotted time", "Keep speaking until someone stops you", "Skip your conclusion"],
                correctOptionIndex: 1
            )
        ]
    }
}
