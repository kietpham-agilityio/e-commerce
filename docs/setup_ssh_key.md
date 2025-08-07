# 🔐 Setup SSH Key for Git (GitHub)

This guide walks you through generating an SSH key, adding it to your SSH agent, and connecting it to GitHub.

---

## 🛠 1. Generate a new SSH key

Run the following command to create a new SSH key pair:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/e_commerce
```

When prompted:

- Press **Enter** to save to the default location (`~/.ssh/e_commerce`)
- (Optional) Enter a passphrase for extra security

---

## 📋 2. Add SSH key to your GitHub account

Copy your public key to clipboard:

- **macOS**:
  ```bash
  pbcopy < ~/.ssh/e_commerce.pub
  ```

- **Linux**:
  ```bash
  xclip -sel clip < ~/.ssh/e_commerce.pub
  ```

- **Windows (Git Bash)**:
  ```bash
  clip < ~/.ssh/e_commerce.pub
  ```

### Then:

- **GitHub**:
  - Go to: [SSH and GPG keys](https://github.com/settings/keys)
  - Click `New SSH key`
  - Paste your key and save

---

## ✅ 3. Test your SSH connection

Run:

```bash
ssh -T git@github.com
```

You should see:

```
Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🧪 Optional: Manage multiple SSH keys

If you're using multiple Git accounts (e.g. work + personal), you can configure different keys using `~/.ssh/config`:

```bash
touch ~/.ssh/config
nano ~/.ssh/config
```

Example content:

```ini
# Personal
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/your_ssh_key

# Work
Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/e_commerce
```

Then, clone using:

```bash
git git@github.com:kietpham-agilityio/e-commerce.git
```

---

## 📎 References

- [GitHub Docs - Connecting via SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)