# Learning Lab

Living archive of my ongoing learning and technical growth. Each directory represents a focused track, course, or tool I've explored with complete code samples, personal projects.

- [Learning Lab](#learning-lab)
  - [Introducing Generative AI with AWS](#introducing-generative-ai-with-aws)
    - [Topics Covered](#topics-covered)
    - [What I learned](#what-i-learned)
    - [Python Environment Setup](#python-environment-setup)
  - [Jupyter Notebooks](#jupyter-notebooks)
  - [🧠 Terminal Quiz](#-terminal-quiz)

## Introducing Generative AI with AWS

This course offers an in-depth exploration of generative artificial intelligence (AI), emphasizing its foundational concepts and real-world applications. We'll cover foundational concepts in machine learning and generative AI and hands-on practice will connect your technical knowledge to thinking about the responsible and inclusive use of AI.

### Topics Covered

**Artificial Intelligence in Context** - The evolution of AI, tracing its milestones from inception to its modern-day ubiquity. Critically examine AI's integration across various industries, emphasizing its transformative societal impact.

**Foundations of Artificial Intelligence and Machine Learning** - Explore the relationship between AI and machine learning (ML). Participants will be introduced to the different ML methodologies, their practical applications, and the emergence of innovative AI models.

**Understanding Large Language Models (LLMs)** - A deep dive into the architectures of LLMs. Learn about transformer-based models, prompt engineering, and fine-tuning mechanisms.

**Real-world Applications of Generative AI** - Study the tangible societal effects of generative AI. Explore its potential for societal transformation and the imperative of its responsible deployment.

### What I learned

Holistically describe AI's historical and societal context.

Identify the clear distinction between primary ML types and between AI and ML.

Discuss Large Language Models, particularly transformer-based architectures.

Provide perspective on the ethical, societal, and economic implications of generative AI, emphasizing responsible and inclusive deployment.

[View Project](./udacity-introducing-generative-ai-with-aws/)

### Python Environment Setup

- Python version: 3.11.8
- Recommended version manager: [pyenv](https://github.com/pyenv/pyenv)

```bash
pyenv install 3.11.8
pyenv local 3.11.8
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Jupyter Notebooks

```bash
jupyter lab
```

## 🧠 Terminal Quiz

Each module in the Learning Lab includes a simple terminal-based quiz powered by a shared core quiz engine.

```bash
# Ex. python terminal-quiz/terminal_quiz/engine.py [./**/**/quiz.json]
python terminal-quiz/terminal_quiz/engine.py ./udacity-introducing-generative-ai-with-aws/quiz.json
```
