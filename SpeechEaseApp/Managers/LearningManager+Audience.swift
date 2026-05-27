//
//  LearningManager+Audience.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var audienceLessons: [Lesson] {
        return [
            Lesson(
                id: "aud-1",
                title: "Empathy Mapping",
                icon: "map.fill",
                content: [
                    "A speech is not about the speaker; it is about the audience.",
                    "Before writing, map out who is in the room: What are their pain points? What do they already know? What do they fear?"
                ],
                quizQuestion: "What is the primary goal of audience empathy mapping?",
                quizOptions: ["To find where they sit", "To understand their needs, fears, and expectations", "To count the number of attendees", "To calculate ticket prices"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-2",
                title: "The WIIFM Rule",
                icon: "questionmark.square.dashed",
                content: [
                    "Every listener is sub-consciously asking: 'What's In It For Me?' (WIIFM).",
                    "If you fail to address this question early, they will stop paying attention. Structure every point around how it benefits them."
                ],
                quizQuestion: "What does the WIIFM acronym stand for in speaking?",
                quizOptions: ["Walk In Interest For Me", "What's In It For Me", "Watch Individuals In Full Motion", "Work Intensively For Market"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-3",
                title: "Active Q&A Listening",
                icon: "person.wave.2.fill",
                content: [
                    "During Q&A sessions, do not think about your answer while the person is still speaking.",
                    "Listen to their entire question, process it, and pause before responding. This shows immense respect and leads to better answers."
                ],
                quizQuestion: "What should you do while an audience member is asking you a question?",
                quizOptions: ["Think about your response", "Listen fully without interrupting or formulating your answer early", "Check your slides", "Look at your watch"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-4",
                title: "Friendly Face Anchor",
                icon: "face.smiling.fill",
                content: [
                    "Looking at blank or frowning faces can spike your anxiety.",
                    "Locate 2-3 supportive, smiling, or nodding people in the room. Use them as 'anchors' to regain your confidence when feeling nervous."
                ],
                quizQuestion: "What is a 'Friendly Face Anchor'?",
                quizOptions: ["A slide with a cartoon face", "A supportive, nodding listener you look at to restore calm", "A mirror on the back wall", "A prop you hold"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-5",
                title: "Tailoring Complexity",
                icon: "slider.horizontal.3",
                content: [
                    "Speaking over your audience's heads makes you look out of touch, not smart.",
                    "Adjust your vocabulary: simplify complex ideas for general audiences, and only use technical terms when speaking to experts."
                ],
                quizQuestion: "How should you adjust your language for a non-expert audience?",
                quizOptions: ["Use as much jargon as possible", "Speak in simple terms and explain any technical jargon clearly", "Avoid using examples", "Speak much louder"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-6",
                title: "Handling Glitches",
                icon: "exclamationmark.triangle.fill",
                content: [
                    "Technical issues, loud noises, or interruptions happen. Panicking ruins your credibility.",
                    "Acknowledge the issue calmly, make a light joke if appropriate, and adjust without losing your flow."
                ],
                quizQuestion: "What is the best way to handle a sudden technical glitch?",
                quizOptions: ["Pretend it isn't happening", "Acknowledge it calmly and adapt gracefully", "Blame the technician", "Stop the presentation immediately"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-7",
                title: "The Q&A Buffer",
                icon: "text.bubble.fill",
                content: [
                    "Do not rush to answer a question immediately. Use a 'buffer'.",
                    "Thank the questioner, rephrase their question for the room, and take a deep breath. This gives you time to think."
                ],
                quizQuestion: "Why should you use a buffer (like rephrasing) in Q&A?",
                quizOptions: ["To avoid answering", "To give yourself time to formulate a thoughtful answer and verify the room heard the question", "To argue with the questioner", "To show off"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-8",
                title: "Using You and We",
                icon: "person.3.sequence.fill",
                content: [
                    "Speeches dominated by 'I' and 'My' alienate listeners.",
                    "Replace them with inclusive pronouns like 'You' and 'We'. It pulls the audience into the narrative and builds a team dynamic."
                ],
                quizQuestion: "Why should you use inclusive pronouns like 'You' and 'We'?",
                quizOptions: ["Because 'I' is grammatically incorrect", "It makes the audience feel involved in your message", "It hides your identity", "It is shorter"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-9",
                title: "Interactive Polls",
                icon: "hand.raised.fill",
                content: [
                    "Keep your audience awake by asking quick, low-barrier questions.",
                    "Say: 'By a show of hands, how many of you have...?' It forces passive listeners to physically engage with your presentation."
                ],
                quizQuestion: "What is the benefit of asking for a quick show of hands?",
                quizOptions: ["It counts the audience", "It physically engages passive listeners and boosts interest", "It tests their physical abilities", "It takes up speaking time"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-10",
                title: "Reading the Room",
                icon: "eyes",
                content: [
                    "If people are slumping, looking at phones, or whispering, you are losing them.",
                    "Be dynamic: if the energy is low, speed up, use a story, ask a question, or project more vocal variety."
                ],
                quizQuestion: "What should you do if you notice the audience looks disengaged?",
                quizOptions: ["Speak louder without changing style", "Pivot your energy, tell a story, or ask a question to re-engage them", "Ignore them and finish faster", "Call out individuals"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-11",
                title: "Inclusive Language",
                icon: "person.fill.questionmark",
                content: [
                    "Avoid using phrases that make assumptions about age, gender, or cultural backgrounds.",
                    "Use inclusive examples that respect diversity. An excluded audience member is one who is no longer listening."
                ],
                quizQuestion: "What is inclusive language in public speaking?",
                quizOptions: ["Speaking only in your native tongue", "Language that avoids biased assumptions and respects diversity", "Using overly formal academic terms", "Avoiding pronouns completely"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "aud-12",
                title: "The Memorable Close",
                icon: "hand.thumbsup.fill",
                content: [
                    "Close your connection with a warm thank you and an invitation to stay connected.",
                    "Leave them with a final thought or contact info that makes them feel appreciated and valued."
                ],
                quizQuestion: "What should you include in your connection closeout?",
                quizOptions: ["A surprise exam", "A warm thank you and an invitation to stay connected", "A request for funding", "A complaints form"],
                correctOptionIndex: 1
            )
        ]
    }
}
