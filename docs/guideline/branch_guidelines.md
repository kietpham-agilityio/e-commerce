# Branch Guidelines

## 1. Overview

To maintain consistency and clarity in our Git workflow, all branches must follow a strict naming convention.  
This ensures that everyone can quickly understand the purpose of a branch, track tasks easily, and avoid conflicts.

---

## 2. Branch naming pattern

```
<type>/<prefix>-<task_number>-<description>
```

### Components:

1. **`<type>`** – Category of the branch:
   - `feature/` – For new features
   - `bugfix/` – For bug fixes
   - `design/` – For UI/UX changes
   - `hotfix/` – For urgent production fixes
   - `release/` – For preparing release versions

2. **`<prefix>`** – Project or task prefix.  
   Example: `ec` for "E-Commerce" project.

3. **`<task_number>`** – The issue ID or task number from [Github](https://github.com/kietpham-agilityio/e-commerce/issues).

4. **`<description>`** – Short, kebab-case description of the task.  
   - Use only lowercase letters, numbers, and `-`
   - Avoid special characters or spaces
   - Be concise but descriptive

---

## 3. Examples

✅ **Correct**:
- `feature/ec-95-create-document-guide-branching`
- `bugfix/ec-96-fix-error-user-name`
- `design/ec-97-update-login-ui`
- `hotfix/ec-98-critical-db-error`
- `release/1.0.0`

❌ **Incorrect**:
- `feat/95-create-branch-doc` (wrong type, missing prefix)
- `feature/EC-95-create document` (uppercase, space in description)
- `fix/96` (missing prefix, unclear description)

---

## 4. Branch creation rules

- Always create a **new branch** from `develop` (or `main` for hotfixes).
- Never commit directly to `main` or `develop`.
- Ensure your branch name matches the **exact task number** in the tracker.
- Keep branch names **short but descriptive**.

---

## 5. Best practices

- **One branch = one task** → Avoid mixing unrelated changes.
- Keep branch descriptions under **6 words**.
- Use consistent prefixes for each project.
- For urgent production issues, use `hotfix/` type and base from `main`.

---

## 6. Workflow example

**Task:** Update login UI (task ID: 97, project: E-Commerce)  
**Branch name:**  
```
design/ec-97-update-login-ui
```

**Steps:**
1. Pull latest changes from `develop`  
   ```bash
   git checkout develop
   git pull origin develop
   ```
2. Create branch:  
   ```bash
   git checkout -b design/ec-97-update-login-ui
   ```
3. Work on the task and commit changes.
4. Push branch and create a PR.

---