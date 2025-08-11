## Branch Guidelines

### Branching in a repository

For each task, a branch is created using the pattern:

```
<type>/<task-name>
```

Examples:

- `feat/implement-UI-login-screen`
- `fix/wrong-socket-text`
- `chore/update-dependencies`
- `docs/update-readme`
- `refactor/home-screen`

Accepted types include:

- `feat/` – for new features
- `fix/` – for bug fixes
- `chore/` – for maintenance or infrastructure work
- `docs/` – for documentation updates
- `refactor/` – for code restructuring without changing behavior

Even without a formal task, use this structure with a meaningful name describing the task.

---

### Commits

The [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification is used.

Pattern:

```
<type>(<Tool-management-tasks>-<task_number>): <description>
```

Examples:

- `feat(QWE-1): init project`
- `fix(XYZ-2): fix error state`
- `chore(ABC-3): update CHANGELOG.md`

Without a task:

- `no-task-doc: update README.md`

Commits should be atomic to ensure clean history and better PR titles.

---

### Pull requests

Use the template auto-added in the PR description.

Follow this format:

```
<type>(<Tool-management-tasks>-<task_number>): <Description>
```

Examples:

- `feat(#1): Init`
- `fix(#2): Incorrect text for SocketException`
- `docs(#3): Readme update`

If fixing a bug, also describe:

```
Root cause: Describe the cause of the bug
Solution: Describe the fix algorithm or logic
```

Example:

```
fix(#4): Buttons are not blocked when loading

Root cause: No UI reaction to load time
Solution: Wrap the screen widget tree in the AbsorbPointer widget. And change the state of this widget based on the loading state.
```

For work-in-progress PRs, prefix with `wip` and remove it when complete.

---