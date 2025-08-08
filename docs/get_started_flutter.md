# 🚀 Get Started with Flutter Project

Welcome to the project! This guide will walk you through setting up your development environment step-by-step.

---

## 📦 Step 1: Install Required Software

Before running the app, please install the following tools on your computer.

| Tool                 | Version                  | What it does                         |
| -------------------- | ------------------------ | ------------------------------------ |
| Flutter SDK          | 3.29.2                   | Main framework for building the app  |
| Dart                 | 3.7.2                    | Programming language used by Flutter |
| Xcode (Mac only)     | 16.2                     | Required to build iOS apps           |
| Android Studio       | Meerkat 2024.3.1 Patch 1 | Used to build Android apps           |
| Melos                | 6.3.2                    | Manages multi-package Flutter apps   |
| Java                 | 17.0.12                  | Required for Android builds          |
| Cocoapods (Mac only) | 1.16.2                   | Manages iOS dependencies             |

> 💡 If you're not sure how to install these, follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install).

---

## 🔧 Step 2: Install Flutter with Puro (Flutter Version Manager)

We use [Puro](https://puro.dev) to manage the Flutter version.

### 🔹 2.1 Install Puro

Choose your operating system below:

- **Mac or Linux**:
  ```bash
  curl -o- https://puro.dev/install.sh | PURO_VERSION="1.4.11" bash
  ```

- **Windows** (open PowerShell as Administrator):
  ```powershell
  Invoke-WebRequest -Uri "https://puro.dev/builds/1.4.11/windows-x64/puro.exe" -OutFile "$env:temp\\puro.exe"; &"$env:temp\\puro.exe" install-puro --promote
  ```

### 🔹 2.2 Create and Use Flutter Version

```bash
dart pub global activate puro 1.4.11
puro create e_commerce 3.29.2
puro use e_commerce
```

> 💡 You must run commands starting with `puro flutter` instead of just `flutter` when working on this project.

---

## 🔑 Step 3: Clone the Project from GitHub

### 3.1 Make sure SSH is set up

If not, follow this guide: [Setup SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

### 3.2 Clone the project

```bash
git clone git@github.com:kietpham-agilityio/e-commerce.git
```

> 📝 This will download the project files to your computer.

---

## 🛠 Step 4: Set Up Code Editor

### ✅ Option 1: Visual Studio Code (Recommended)

1. [Download VS Code](https://code.visualstudio.com/) and install.
2. Open VS Code.
3. Go to Extensions (click square icon on the left).
4. Search and install:
   - `Flutter`
   - `Dart`
   - `Error Lens` *(optional)*
   - `GitLens` *(optional)*

#### Enable Auto Formatting

- Open Settings (`Ctrl + ,`)
- Search: **Format on Save** → check ✅
- Search: **Organize Imports** → check ✅

#### Recommended Project Settings

Create `.vscode/settings.json` in the project root:

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  },
  "dart.lineLength": 100,
  "dart.analysisExcludedFolders": [
    "**/build/**",
    "**/.dart_tool/**"
  ]
}
```

### 🛠 Option 2: Android Studio

1. [Download Android Studio](https://developer.android.com/studio) and install.
2. Open Android Studio.
3. Go to Preferences → Plugins:
   - Install `Flutter Plugin`
   - Install `Dart Plugin`
4. Restart Android Studio.

#### Setup Android SDK

- Go to: Preferences → Appearance & Behavior → System Settings → Android SDK
- Install SDK Version **34+**
- Also install: **Android SDK Command-line Tools**

#### Optional: Use Android Emulator

1. Open "Device Manager"
2. Create a new Virtual Device (choose Pixel + API 34+ image)

#### Set Flutter SDK Path

- Go to Preferences → Languages & Frameworks → Flutter
- Set the path to:
  ```
  ~/.puro/versions/e_commerce
  ```

---

## 🧪 Step 5: Run the Project

Open Terminal in the project folder and run these commands:

```bash
puro flutter pub get
melos bootstrap
puro flutter run
```

If you see the app on your simulator/emulator – you're all set! 🎉

---

## 📚 Extra Resources

- [Setup SSH Key](setup_ssh_key.md)
- [Melos Setup Guide](melos_guide.md)
- [Flutter Install Guide](https://docs.flutter.dev/get-started/install)

---

🙌 You're ready to code – good luck!
