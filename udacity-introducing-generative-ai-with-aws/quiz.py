from pathlib import Path

from terminal_quiz.engine import run_quiz

quiz_path = f"{Path(__file__).parent}/quiz.json"

if __name__ == "__main__":
    run_quiz(quiz_path)
