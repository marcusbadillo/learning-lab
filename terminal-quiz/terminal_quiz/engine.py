import json
import random
import sys
from pathlib import Path


def run_quiz() -> None:
    if len(sys.argv) != 2:
        print("\n❗ Usage: python run.py path/to/quiz.json\n")
        return sys.exit(1)

    json_path = sys.argv[1]
    quiz_file = Path(json_path)
    if not quiz_file.exists():
        print(f"❌ Error: {json_path} not found.")
        return sys.exit(1)

    with open(quiz_file, "r", encoding="utf-8") as f:
        quiz = json.load(f)

    title = f"\n\U0001f9e0 Welcome to the {quiz.get('__title__', 'Vocabulary')} Quiz!"
    words = [k for k in quiz.keys() if k != "__title__"]
    score = 0
    questions = len(words)

    if questions < 1:
        print("⚠️ Not enough questions in this quiz.")
        return sys.exit(1)

    print(title)

    for i, word in enumerate(random.sample(words, questions), 1):
        correct_def = quiz[word]
        all_defs = [quiz[w] for w in words if w != word]
        choices = random.sample(all_defs, k=min(3, len(all_defs))) + [correct_def]
        random.shuffle(choices)

        print(f"{i}. {word}")
        for idx, choice in enumerate(choices, 1):
            print(f"  {idx}. {choice}")

        try:
            answer = int(input("Your choice (1-4): "))
            if choices[answer - 1] == correct_def:
                print("✅ Correct!\n")
                score += 1
            else:
                print(f"❌ Wrong. Correct answer: {correct_def}\n")
        except (ValueError, IndexError):
            print(f"⚠️ Invalid input. The correct answer was: {correct_def}\n")

    print(f"🏋️ Quiz complete! You scored {score} out of {questions}.\n")


if __name__ == "__main__":
    run_quiz()
