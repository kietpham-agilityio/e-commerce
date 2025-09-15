# Pull Request Guidelines

## 1. General Principles

A Pull Request (PR) is not just a code merge — it’s a piece of documentation that will live in the repository’s history. The goal is to make it easy for reviewers to understand, test, and approve changes without confusion.

---

## 2. Writing Maintainable and Readable Code

- Strive for clarity over cleverness — avoid cryptic one-liners or overly complex logic.
- Follow the project’s coding style guide for consistency.
- Keep your code simple, readable, and maintainable for future contributors.
- Guidelines may include terms like:
  - **DO** – Always follow this practice.
  - **DON’T** – Avoid this unless there is a strong, justified reason.
  - **PREFER** – Recommended, but can be skipped in special cases.
  - **AVOID** – Not recommended unless absolutely necessary.
  - **CONSIDER** – Optional, based on context and preference.

---

## 3. Keep PRs Focused

- Aim for **small, focused PRs** — about 10 files changed or 200 lines of code.
- Work only on the task at hand. If you spot unrelated issues, create a separate ticket.
- Large features should be split into multiple, independent PRs.

---

## 4. PR Titles and Descriptions

- Treat PRs as searchable documentation — titles and descriptions should include:
  - Task context
  - Purpose of the change
  - Any relevant references (links, tickets)
- Keep the PR description updated as the code changes.
- Use the default PR checklist to ensure completeness.

---

## 5. Self-Review Before Submission

- Review your own PR as if you were the reviewer.
- Test your code before submitting.
- Add inline comments to explain tricky or non-obvious changes.
- Ensure your changes don’t break existing functionality.

---

## 6. Commit Practices

- Commit often, in **logical chunks**.
- Use clear and descriptive commit messages.
- Avoid vague commits like `"fix bugs"` — specify what and why.
- Don’t mix unrelated changes in the same commit.

---

## 7. Communication and Notifications

- Share your PR link in the team’s Slack channel once it’s ready.
- Keep others updated if the PR is paused, awaiting review, or needs rework.
- If you make major changes after approval, notify previous reviewers.

---

## 8. Handling Feedback

- **Stay objective** — feedback is about the code, not you.
- **Assume positive intent** — written comments can be misinterpreted.
- **Respond to all feedback**:
  - Use a simple acknowledgement (e.g., 👍, “Will do”).
  - Or explain why you disagree with a suggestion.
- Don’t leave comments unanswered or PRs stalled.

---

## 9. Review Etiquette

- Wait for all reviewers to confirm before merging.
- Never merge while there are unresolved comments.
- If reviewers take too long, send a polite reminder.

---

## 10. Clarifying Unclear Comments

- If you don’t understand feedback, ask for clarification via PR comments, Slack, or meetings.
- Summarize important discussion points in the PR so future readers have full context.

---

## 11. Final Check Before Merge

- All discussions are resolved.
- Automated checks (CI/CD) have passed.
- PR is up-to-date with the base branch.

---