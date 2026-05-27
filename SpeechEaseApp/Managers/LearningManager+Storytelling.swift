//
//  LearningManager+Storytelling.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var storytellingLessons: [Lesson] {
        return [
            Lesson(
                id: "story-1",
                title: "Hero's Journey",
                icon: "shield.fill",
                content: [
                    "Storytelling is the ultimate tool for memorability. People forget statistics, but they remember stories.",
                    "The simplified Hero's Journey has three steps: the Status Quo (normal life), the Conflict (a sudden challenge), and the Resolution (lessons learned)."
                ],
                quizQuestion: "What are the three core steps of a simplified storytelling arc?",
                quizOptions: ["Introduction, Body, Conclusion", "Status Quo, Conflict, Resolution", "Question, Outline, Answer", "Hook, Data, Agenda"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-2",
                title: "Hook Story",
                icon: "sparkles",
                content: [
                    "A short personal story at the start of a speech is the most powerful way to hook your audience.",
                    "Make it brief—under 60 seconds—and ensure it directly leads to your speech's main topic."
                ],
                quizQuestion: "What is a key requirement of a Hook Story?",
                quizOptions: ["It should contain complex calculations", "It should last at least ten minutes", "It must be brief and directly link to the main topic", "It should be about someone else"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "story-3",
                title: "The STAR Technique",
                icon: "star.fill",
                content: [
                    "Use the STAR technique to answer interview questions or tell professional stories.",
                    "Define: Situation (background), Task (what was needed), Action (what YOU did), and Result (the quantitative outcome)."
                ],
                quizQuestion: "What does the STAR technique stand for?",
                quizOptions: ["Structure, Tone, Articulation, Resonance", "Situation, Task, Action, Result", "Story, Theme, Activity, Resource", "Start, Transition, Answer, Review"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-4",
                title: "Sensory Details",
                icon: "ear",
                content: [
                    "Flat stories ('I was in a meeting') bore people. Sensory details bring them to life.",
                    "Describe how things felt, sounded, or looked (e.g., 'the humming fluorescent lights of the boardroom')."
                ],
                quizQuestion: "What is the purpose of adding sensory details to a story?",
                quizOptions: ["To make the story longer", "To create a vivid, immersive mental image for the audience", "To show off vocabulary", "To delay the conclusion"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-5",
                title: "The Climax Moment",
                icon: "exclamationmark.3",
                content: [
                    "The climax is the peak of tension in your story where everything changes.",
                    "Build up the challenge so that the turning point feels dramatic and satisfying when resolved."
                ],
                quizQuestion: "What is the Climax in a story narrative?",
                quizOptions: ["The introduction of the main character", "The moment of highest tension or the turning point of the conflict", "The final slide of the presentation", "The bibliography list"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-6",
                title: "Vulnerable Sharing",
                icon: "heart.text.square.fill",
                content: [
                    "If you only share your successes, you sound arrogant. Sharing failures builds trust.",
                    "Be open about a mistake you made or a time you failed, focusing on the lesson it taught you."
                ],
                quizQuestion: "Why is sharing vulnerability effective in professional storytelling?",
                quizOptions: ["It makes you look incompetent", "It builds authentic human connection and trust", "It passes the blame to others", "It shortens the speech"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-7",
                title: "Character Anchors",
                icon: "person.crop.circle.fill",
                content: [
                    "If people in your story are faceless names, the audience won't care about them.",
                    "Anchor them: describe a small, specific detail ('My mentor John, who always wore mismatched socks...')."
                ],
                quizQuestion: "How do you make characters in a story more memorable?",
                quizOptions: ["By listing their job descriptions", "By giving them a specific, memorable Trait or Detail", "By spelling their names aloud", "By calling them 'Person A'"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-8",
                title: "The Spark",
                icon: "bolt.heart.fill",
                content: [
                    "Every transition needs a catalyst: the moment of sudden realization or decision.",
                    "Highlight 'The Spark'—the exact moment you decided to change course or solve the problem."
                ],
                quizQuestion: "What does 'The Spark' represent in a story?",
                quizOptions: ["A technical glitch", "The exact moment of realization or decision that prompted change", "A slide transition animation", "An applause break"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-9",
                title: "The Resolution",
                icon: "checkmark.shield",
                content: [
                    "A story without a clear ending leaves listeners feeling unsatisfied.",
                    "Close the narrative loop: describe the final state, the lessons learned, and the permanent positive change."
                ],
                quizQuestion: "What is the primary focus of a story's Resolution?",
                quizOptions: ["Introducing a new problem", "Showing the final outcome, lessons learned, and positive change", "Repeating the hook story", "Asking for questions"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-10",
                title: "Analogy & Metaphor",
                icon: "arrow.up.left.and.arrow.down.right.circle.fill",
                content: [
                    "Analogies compare complex concepts to everyday occurrences.",
                    "Instead of explaining cloud computing architecture, say: 'It's like renting a storage locker instead of building a shed.'"
                ],
                quizQuestion: "What is the function of an analogy in speech?",
                quizOptions: ["To confuse the listeners", "To compare a complex concept to a familiar one for easy understanding", "To make a joke", "To replace a statistic"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-11",
                title: "Show, Don't Tell",
                icon: "eye.trianglebadge.exclamationmark.fill",
                content: [
                    "Instead of telling the audience how you felt ('I was nervous'), show it ('My hands were sweating, and my throat was dry').",
                    "This allows the audience to feel the emotion rather than just hearing about it."
                ],
                quizQuestion: "Which statement is an example of 'Show, Don't Tell'?",
                quizOptions: ["I felt extremely nervous.", "My knees shook, and I gripped the podium tight.", "I was very excited.", "It was a difficult situation."],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "story-12",
                title: "Tying to the Lesson",
                icon: "link.circle.fill",
                content: [
                    "A story in a speech is not for entertainment; it is to prove a point.",
                    "Always close the story by linking it back to the core lesson: 'And that is why we must automate our processes...'"
                ],
                quizQuestion: "How should you wrap up a story in a speech?",
                quizOptions: ["By walking off the stage", "By explicitly connecting its takeaway to your main speech lesson", "By asking if the audience liked it", "By starting another story"],
                correctOptionIndex: 1
            )
        ]
    }
}
