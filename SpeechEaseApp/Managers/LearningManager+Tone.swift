//
//  LearningManager+Tone.swift
//  SpeechEaseApp
//

import Foundation

extension LearningManager {
    var toneLessons: [Lesson] {
        return [
            Lesson(
                id: "tone-1",
                title: "Diaphragmatic Breath",
                icon: "lungs.fill",
                content: [
                    "Breath is the engine of your voice. Shallow chest breathing leads to a weak, shaky tone.",
                    "Practice diaphragmatic breathing: when you inhale, your abdomen should expand outward, while your shoulders remain perfectly still."
                ],
                quizQuestion: "Where should you feel the expansion when taking a deep breath for public speaking?",
                quizOptions: ["In your upper chest", "In your shoulders", "In your abdomen (diaphragm)", "In your throat"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "tone-2",
                title: "Finding Resonance",
                icon: "bell.fill",
                content: [
                    "Resonance is what gives a voice its richness, depth, and projection, making it sound warm and full.",
                    "Practice humming softly to feel vibrations in your chest and facial mask, rather than pushing sound solely through your nose."
                ],
                quizQuestion: "What is the primary way to find and improve your vocal resonance?",
                quizOptions: ["Whispering", "Humming softly to feel chest/mask vibrations", "Shouting as loud as possible", "Holding your breath"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-3",
                title: "Pitch Modulation",
                icon: "waveform",
                content: [
                    "A monotone voice acts like a lullaby to your audience's brains.",
                    "Modulate your pitch: raise it slightly to convey excitement or questions, and drop it lower to project authority and declare important points."
                ],
                quizQuestion: "When is it most effective to lower your vocal pitch?",
                quizOptions: ["When asking a direct question", "When projecting excitement", "When declaring key points or conclusions with authority", "At the start of every single sentence"],
                correctOptionIndex: 2
            ),
            Lesson(
                id: "tone-4",
                title: "Power of Volume",
                icon: "speaker.wave.3.fill",
                content: [
                    "Varying your volume commands attention. Do not keep the same decibel level throughout.",
                    "Raise your volume to emphasize a call to action. Lower your volume to a near-whisper to create intimacy and make the audience lean in."
                ],
                quizQuestion: "Why would a speaker drop their volume to a quiet, soft level?",
                quizOptions: ["Because they forgot their lines", "To create intimacy and make the audience lean in", "Because they are tired of speaking", "To end the speech immediately"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-5",
                title: "Eliminating Vocal Fry",
                icon: "waveform.path.ecg",
                content: [
                    "Vocal fry is the creaky, low-register sound that occurs when air slides past relaxed vocal cords.",
                    "It usually happens at the end of sentences when breath support drops. Push through the end of your sentence with consistent air flow."
                ],
                quizQuestion: "How can a speaker eliminate distracting vocal fry at the end of sentences?",
                quizOptions: ["By speaking faster", "By maintaining solid breath support all the way through the final word", "By whispering the last word", "By drinking soda"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-6",
                title: "Smiling for Warmth",
                icon: "face.smiling.fill",
                content: [
                    "Smiling physically alters the shape of your oral cavity, raising the pitch and softening your voice.",
                    "Even if you are delivering a speech virtually or on a call, smiling slightly will make your tone sound warm and trustworthy."
                ],
                quizQuestion: "What physical effect does smiling have on your voice?",
                quizOptions: ["It makes it louder", "It physically shapes the oral cavity to sound warmer and friendlier", "It makes it deeper", "It has no audible effect"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-7",
                title: "Consonant Articulation",
                icon: "mouth.fill",
                content: [
                    "Mumbling consonants (like T, P, D, B) makes you look unprepared and hard to understand.",
                    "Enounce each consonant clearly. Exaggerate the movement of your jaw and lips during practice to build muscle memory."
                ],
                quizQuestion: "What is the primary benefit of crisp consonant articulation?",
                quizOptions: ["It makes you speak faster", "It increases clarity and projects professional competence", "It makes your voice sound deeper", "It helps you breathe"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-8",
                title: "Speed Variations",
                icon: "speedometer",
                content: [
                    "Pacing affects how the audience processes emotion. A static pace is boring.",
                    "Accelerate slightly when describing action or excitement. Slow down significantly when presenting a complex argument or solemn concept."
                ],
                quizQuestion: "When should a speaker deliberately slow down their delivery?",
                quizOptions: ["When they are excited", "When explaining complex, important, or gravity-filled concepts", "When they run out of breath", "During the introduction hook"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-9",
                title: "The Question Inflexion",
                icon: "questionmark.circle.fill",
                content: [
                    "Raising your pitch at the end of a statement makes it sound like a question. This is called 'uptalk'.",
                    "It sub-consciously signals that you are seeking approval or lack confidence. End declarative statements with a neutral or falling pitch."
                ],
                quizQuestion: "What is 'uptalk' and why is it generally discouraged for declarations?",
                quizOptions: ["Speaking too loudly; it hurts ears", "Raising pitch at sentence ends, which signals lack of confidence or approval-seeking", "Speaking in a low croaking voice", "Using too many questions in a speech"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-10",
                title: "The Pause Punch",
                icon: "pause.circle.fill",
                content: [
                    "If you want a specific word to carry massive weight, pause immediately before saying it.",
                    "The brief silence highlights the word, making the audience listen with heightened interest."
                ],
                quizQuestion: "What is the function of the 'Pause Punch'?",
                quizOptions: ["To take a drink of water", "To highlight a specific word by placing a brief silence right before it", "To end the speech", "To remember the next point"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-11",
                title: "Larynx Relaxation",
                icon: "wind",
                content: [
                    "Tension in your neck and throat squeezes the larynx, making your voice sound thin, tight, or squeaky.",
                    "Do gentle head rolls and practice yawning to open the back of your throat and relax the larynx before you speak."
                ],
                quizQuestion: "What causes a thin, tight, or squeaky vocal tone?",
                quizOptions: ["Drinking warm water", "Larynx and neck muscle tension", "Standing up straight", "Speaking slowly"],
                correctOptionIndex: 1
            ),
            Lesson(
                id: "tone-12",
                title: "Vocal Hygiene",
                icon: "drop.circle.fill",
                content: [
                    "Your vocal cords are muscles covered in a delicate mucosal layer. They need care.",
                    "Drink plenty of room-temperature water. Avoid ice-cold beverages, caffeine, or screaming right before a major presentation."
                ],
                quizQuestion: "What is a key practice of good vocal hygiene?",
                quizOptions: ["Drinking ice water right before speaking", "Staying hydrated with room-temperature water", "Clearing your throat loudly and often", "Whispering for hours"],
                correctOptionIndex: 1
            )
        ]
    }
}
