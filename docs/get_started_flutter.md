# 🚀 Get Started with Flutter Project

Welcome to the project! Follow these steps to set up your development environment.

---

## 📦 Required Dependencies

Before running the app, make sure you install the following dependencies globally:

- [Flutter SDK](https://docs.flutter.dev/)
- [Melos](https://melos.invertase.dev/) – for managing monorepos
- TBD

To install Melos globally:

```bash
dart pub global activate melos
```

---

## 🔑 Clone the Repository via SSH

```bash
clone git@github.com:kietpham-agilityio/e-commerce.git
```

> If `sshkey` is not setup, see [setup_ssh_key](setup_ssh_key.md)

---

## 🖥️ Using SourceTree (optional)

If you prefer using a GUI like **SourceTree**:

1. Open SourceTree
2. Click "Clone from URL"
3. Paste your SSH URL: `git@github.com:kietpham-agilityio/e-commerce.git`
4. Select destination folder and click "Clone"
5. Make sure SourceTree is using SSH, not HTTPS

---

## 🧑‍💻 Recommended Editor Setup (VS Code)

1. Install [VS Code](https://code.visualstudio.com/)
2. Install the following extensions:
   - Flutter
   - Dart
   - Error Lens (optional)
   - GitLens (optional)

---

## Flutter Version Management (Using Puro)

### Flutter and Dart versions of the project

Flutter: **_3.29.2_** / Dart SDK: **_3.7.2_**

### Puro

[Puro](https://puro.dev/) is a powerful tool for installing and upgrading Flutter versions

1. The command line corresponding to the operating system.

   - Mac:
     ```
     curl -o- https://puro.dev/install.sh | PURO_VERSION="1.4.6" bash
     ```
   - Linux:
     ```
     curl -o- https://puro.dev/install.sh | PURO_VERSION="1.4.6" bash
     ```
   - Windows:
     ```
     Invoke-WebRequest -Uri "https://puro.dev/builds/1.4.6/windows-x64/puro.exe" -OutFile "$env:temp\puro.exe"; &"$env:temp\puro.exe" install-puro --promote
     ```

2. Install the package Puro
   ```
   dart pub global activate puro 1.4.6
   puro create e_commerce 3.29.2
   puro use e_commerce
   ```

You need to use `puro flutter ...` everywhere instead of just `flutter ...` when working with the project.

---

## 🧪 Running the Project

In the project root, run:

```bash
puro flutter pub get
melos bootstrap
puro flutter run
```

> If `melos` is not setup, see [Melos Setup](melos_guide.md)

---

## 📚 Related Docs

- 👉 [Melos Setup Guide](melos_guide.md)
- 👉 [Setup SSH Key](setup_ssh_key.md)

---

Happy coding! 💻✨