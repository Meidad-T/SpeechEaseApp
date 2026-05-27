//
//  LearningManager+Structure.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var structureLessons: [Lesson] {
        return [
            Lesson(
                id: "struct-1",
                title: "The Power Hook",
                icon: "anchor",
                content: [
                    "A speech's first 15 seconds are critical. This is when your audience decides whether to listen or tune out.",
                    "A 'Hook' is a device used to grab attention immediately. Never start with 'Hi, my name is...' instead, start with a story, question, or shocking statistic."
                ],
                quizQuestion: "What is the primary goal of a speech's opening Hook?",
                quizOptions: ["To introduce your name and job", "To grab the audience's attention immediately", "To outline your budget", "To thank the organizers"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-2",
                title: "Introducing the Core",
                icon: "target",
                content: [
                    "Once you have their attention with a hook, you must bridge them to your core message.",
                    "This bridge is your thesis statement: a single, clear sentence summarizing the main point of your speech."
                ],
                quizQuestion: "What is a thesis statement in a speech?",
                quizOptions: ["A list of references", "A funny joke to break the ice", "A single sentence summarizing your core message", "An invitation to ask questions"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "struct-3",
                title: "Rule of Three",
                icon: "3.circle.fill",
                content: [
                    "The human brain is wired to recognize patterns of three. Information presented in triads is more satisfying and memorable.",
                    "Organize your speech body into exactly three core points. Any more, and your listeners will start to forget them."
                ],
                quizQuestion: "Why should you structure the body of your speech into three main points?",
                quizOptions: ["It is the only allowed format", "It is easier to memorize and highly engaging", "It saves printing paper", "It guarantees you finish early"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-4",
                title: "Logical Chronology",
                icon: "calendar",
                content: [
                    "Chronological structure organizes your points in order of time: Past, Present, and Future.",
                    "This is ideal for explaining historical timelines, project progress, or personal development stories."
                ],
                quizQuestion: "In which situation is a chronological structure most effective?",
                quizOptions: ["Explaining a project timeline or history", "Comparing two unrelated products", "Answering a random Q&A question", "Delivering a quick joke"],
                correctOptionIndex: 0
            ),
            Lesson(
                id: "struct-5",
                title: "Problem & Solution",
                icon: "exclamationmark.bubble",
                content: [
                    "This structure starts by identifying a painful problem, then introduces your idea as the solution.",
                    "To build tension, make the problem feel urgent and relatable before revealing your solution."
                ],
                quizQuestion: "What should you do before proposing a solution in a speech?",
                quizOptions: ["Ask for a raise", "Make the problem feel urgent and relatable", "End the speech", "Apologize for the issue"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-6",
                title: "Compare & Contrast",
                icon: "arrow.2.squarepath",
                content: [
                    "Compare & Contrast structures help an audience choose between alternatives.",
                    "Discuss the advantages and disadvantages of Option A, then Option B, and finally explain why your recommendation is superior."
                ],
                quizQuestion: "What is the primary benefit of Compare & Contrast structure?",
                quizOptions: ["It makes the speech twice as long", "It helps the audience weigh alternatives logically", "It avoids having to make a decision", "It hides the disadvantages of your choice"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-7",
                title: "Topic Transitions",
                icon: "arrow.right.circle",
                content: [
                    "Transitions are the bridges that connect your points. Without them, your speech feels disjointed.",
                    "Use signpost words like 'Furthermore', 'Conversely', or 'Now that we've covered...' to signal a shift."
                ],
                quizQuestion: "What is the purpose of signpost transition words?",
                quizOptions: ["To sound overly academic", "To signal a shift between points clearly", "To replace the hook", "To conclude the speech"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-8",
                title: "The Summary Bridge",
                icon: "sum",
                content: [
                    "Before moving to your conclusion, briefly recap your three main points.",
                    "This reinforces your message and ensures that the core takeaways stick in the audience's mind."
                ],
                quizQuestion: "When should you deliver a summary recap of your points?",
                quizOptions: ["During the hook", "Just before your final conclusion", "After the speech is finished", "Only if someone asks"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-9",
                title: "Call to Action",
                icon: "bell.badge",
                content: [
                    "Every persuasive speech must end with a Call to Action (CTA).",
                    "A CTA is a direct, specific request telling the audience exactly what they should do next (e.g., 'Sign the petition', 'Start today')."
                ],
                quizQuestion: "What is a Call to Action (CTA)?",
                quizOptions: ["An emergency alert", "A specific request for the audience to take action", "A summary of the introduction", "A request for feedback"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-10",
                title: "The Full Circle",
                icon: "arrow.3.trianglepath",
                content: [
                    "A powerful conclusion ties back to the introduction. This is called a Full-Circle ending.",
                    "If you opened with a story, resolve the story. If you asked a question, provide the final answer."
                ],
                quizQuestion: "How do you achieve a Full-Circle conclusion?",
                quizOptions: ["By repeating the introduction word-for-word", "By referencing your opening hook or story at the very end", "By walking in a circle on stage", "By starting a new topic"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-11",
                title: "Outlining Basics",
                icon: "list.bullet.indent",
                content: [
                    "Never write a speech word-for-word first. Start with a skeleton outline.",
                    "Focus on the hierarchy: Title, Hook, Thesis, Main Points, and CTA. This prevents rambling."
                ],
                quizQuestion: "What should you focus on when creating an initial speech outline?",
                quizOptions: ["Writing out every word you will say", "Logical structure and hierarchy", "Selecting the stage outfits", "Designing the slides"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "struct-12",
                title: "Pacing Your Agenda",
                icon: "list.clipboard",
                content: [
                    "An agenda slide or verbal road map prepares your listeners' brains.",
                    "Briefly state: 'Today we will look at X, Y, and Z.' It establishes you as an organized speaker."
                ],
                quizQuestion: "Why should you outline an agenda at the start of your speech?",
                quizOptions: ["To consume speaking time", "To set clear expectations for the listener's journey", "To show you have finished planning", "To skip the hook entirely"],
                correctOptionIndex: 1
            )
        ]
    }
}
