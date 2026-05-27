//
//  LearningManager+Nonverbal.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var nonverbalLessons: [Lesson] {
        return [
            Lesson(
                id: "nonverbal-1",
                title: "The Eye Anchor",
                icon: "eye.fill",
                content: [
                    "Looking randomly around the room makes you seem nervous or shifty.",
                    "Practice the 'Eye Anchor': deliver one complete thought or sentence to a single person. Then, move your gaze to someone else for the next sentence."
                ],
                quizQuestion: "What is the core of the 'Eye Anchor' technique?",
                quizOptions: ["Staring at the back wall", "Looking at a single person for a full sentence or thought", "Scanning the room as quickly as possible", "Closing your eyes during transitions"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-2",
                title: "Open vs Closed",
                icon: "arrow.left.and.right",
                content: [
                    "Your posture speaks before you do. Crossing your arms or legs is a 'closed' posture.",
                    "An open posture—shoulders back, chest open, hands at your sides—signals confidence, honesty, and warmth."
                ],
                quizQuestion: "What message does a closed posture (crossed arms) send?",
                quizOptions: ["Authority and power", "Defensiveness or closing off", "Enthusiasm", "Friendliness"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-3",
                title: "The Base Stance",
                icon: "figure.stand",
                content: [
                    "Swaying side to side or pacing back and forth is a common outlet for nervous energy.",
                    "Anchor yourself: plant your feet shoulder-width apart, knees soft (not locked). This is your neutral 'home' stance."
                ],
                quizQuestion: "What is the correct foot placement for a stable, neutral base stance?",
                quizOptions: ["Feet touching", "Feet crossed", "Feet shoulder-width apart", "Standing on one foot"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "nonverbal-4",
                title: "The Hand Horizon",
                icon: "hand.raised.fill",
                content: [
                    "Gesturing too high looks chaotic; gesturing too low is hard to see.",
                    "Keep your gestures in the 'strike zone': the horizontal band between your waist and your chest. This looks natural and active."
                ],
                quizQuestion: "Where is the ideal 'strike zone' for hand gestures?",
                quizOptions: ["Above your head", "Behind your back", "Between your waist and chest", "Only below your waist"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "nonverbal-5",
                title: "The Fig Leaf Trap",
                icon: "leaf.fill",
                content: [
                    "Clasping your hands together in front of your groin is called the 'Fig Leaf' posture.",
                    "It makes you look small, guarded, and weak. Let your hands hang loose or rest in a neutral position."
                ],
                quizQuestion: "Why should a speaker avoid the 'Fig Leaf' posture?",
                quizOptions: ["It looks too aggressive", "It signals vulnerability and lack of confidence", "It makes you look too tall", "It blocks the microphone"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-6",
                title: "Purposeful Walking",
                icon: "figure.walk",
                content: [
                    "Movement is great, but pacing is distracting.",
                    "Only walk when transitioning between main points. Walk 2-3 steps to a new spot, stop, plant your feet, and deliver the point."
                ],
                quizQuestion: "When is the best time to move to a new spot on stage?",
                quizOptions: ["Whenever you feel nervous", "Constantly, to keep the audience's heads moving", "When transitioning to a new point", "During a critical statistic to distract them"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "nonverbal-7",
                title: "Mirroring the Room",
                icon: "person.2.fill",
                content: [
                    "Mirroring is subtly matching the posture, energy, or stance of the person you are communicating with.",
                    "This builds sub-conscious trust and rapport, especially in one-on-one meetings or interviews."
                ],
                quizQuestion: "What is the primary benefit of mirroring?",
                quizOptions: ["It proves you are paying attention to yourself", "It builds subconscious trust and rapport", "It mocks the other person", "It forces them to agree with you"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-8",
                title: "Facial Agreement",
                icon: "face.smiling",
                content: [
                    "If you are sharing serious news but smiling nervously, your audience will feel confused or distrustful.",
                    "Ensure your facial expressions match the emotional tone of your words."
                ],
                quizQuestion: "What is 'Facial Agreement'?",
                quizOptions: ["Smiling all the time", "Matching your facial expressions with the emotional content of your words", "Nodding at everyone", "Keeping a blank, emotionless face"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-9",
                title: "The Head Nod",
                icon: "arrow.up.and.down.circle",
                content: [
                    "When listening to a question or another speaker, nodding slightly shows you are fully engaged.",
                    "It validates the speaker and builds mutual respect without interrupting them verbally."
                ],
                quizQuestion: "What does nodding while listening communicate?",
                quizOptions: ["That you want to speak next", "Engagement, empathy, and active listening", "That you are falling asleep", "Disagreement"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-10",
                title: "The Pause Look",
                icon: "timer.square",
                content: [
                    "Before speaking, stand in your base stance and silently look at the audience for 2-3 seconds.",
                    "This silence creates anticipation and signals that you are in total control of the room."
                ],
                quizQuestion: "Why should you pause and look at the audience before speaking?",
                quizOptions: ["To find where the exits are", "To establish presence and create anticipation", "To wait for late arrivals", "To remember your name"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-11",
                title: "Steeple Hands",
                icon: "hands.sparkles.fill",
                content: [
                    "Pressing the fingertips of both hands together (forming a steeple) is a universal sign of confidence and intellect.",
                    "Use this posture when making key points, but do not hold it the entire speech."
                ],
                quizQuestion: "What message does the 'steeple hands' gesture convey?",
                quizOptions: ["Confusion", "Authority, intellect, and confidence", "Apology", "Impatience"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "nonverbal-12",
                title: "Handling the Lectern",
                icon: "rectangle.portrait.fill",
                content: [
                    "Gripping the sides of a podium or lectern is a classic sign of stage fright.",
                    "Treat the lectern as a stand, not a shield. Stand 6 inches back, rest hands lightly, and gesture freely."
                ],
                quizQuestion: "How should you interact with a lectern or podium?",
                quizOptions: ["Grip it tightly to stay steady", "Lean over it completely", "Stand slightly back and gesture naturally", "Hide behind it so no one can see you"],
                correctOptionIndex: 2
            )
        ]
    }
}
