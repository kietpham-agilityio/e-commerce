# 📥 Pull Request Guidelines

## 1. Purpose
A Pull Request (PR) is a way to propose changes from one branch to another (e.g., from a feature branch to `develop` or `main`).  
PRs help to:
- Review code before merging
- Ensure quality and prevent bugs
- Include a clear result

---

## 2. Pull Request Workflow

1. **Complete your code** on your branch
   - Name your branch following the naming convention (see section 4)
   - Ensure your code passes lint and tests
2. **Push the branch** to the remote repository
3. **Create a Pull Request** on GitHub/GitLab
4. **Fill in the PR details**:
   - Title
   - Description
   - Link to related ticket (Jira/Trello/GitHub Issue)
5. **Request review** from the assigned reviewer(s)
6. **Address review comments** if there are any
7. **Merge the PR** only when:
   - Approved
   - All tests and CI/CD pipelines pass

---

## 3. Pull Request Title Format

```plaintext
[type] Short description

Example:
feat: add user login feature
fix: resolve crash when loading product list
chore: update dependencies
docs: add pull request guideline
```

**Common types:**
- `feat` → New feature
- `fix` → Bug fix
- `refactor` → Code structure/logic improvement
- `chore` → Maintenance (update libs, configs, etc.)
- `docs` → Documentation updates
- `test` → Adding/updating tests

---

## 4. Branch Naming Convention

[Branch Guidelines](branch_guidelines.md)

---

## 5. PR Description Template

### 📌 Description
Briefly describe what this PR does and why.

### 🔗 Related Links
- GitHub Issue: [link]()

### 🧪 How to Test
1. Step 1
2. Step 2
3. Expected result

### ✅ Checklist
- [ ] Code has been linted
- [ ] Unit tests have been written/updated
- [ ] Tested locally
- [ ] Documentation updated if necessary

---

## 6. Best Practices for PRs

- **Small and focused**: Each PR should address only one issue/feature → easier to review
- **Clear and concise**: Make the title and description specific
- **Test coverage**: Include unit/widget tests if applicable
- **No extra files**: Remove logs, temporary files, and debug code
- **Standard commit messages**: Follow commit guidelines

---

## 7. Things to Avoid
- Large PRs (hard to review, more conflicts)
- Missing description or related ticket link
- Merging without review
- Pushing directly to main/develop branch

---

## 8. Review & Merge Process
1. Reviewer reads the code and leaves comments
2. PR author responds and makes changes if necessary
3. Reviewer approves the PR
4. Merge using one of the following:
   - **Squash and merge** (clean history)
   - **Rebase and merge** (keep individual commits)
5. Delete the branch after merging

---

**📚 References**:
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)