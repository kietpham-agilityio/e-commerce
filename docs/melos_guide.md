# 🧪 Using Melos in a Flutter Monorepo

[Melos](https://melos.invertase.dev/) is a CLI tool used to manage Flutter and Dart monorepos. It helps with dependency management, bootstrapping packages, and running scripts across packages.

---

## 📦 1. Installation

Install Melos globally using Dart:

```bash
dart pub global activate melos
```

Make sure the global `pub` bin path is in your system PATH.

---

## 🛠 2. Create `melos.yaml`

Place this file in the root of your repository:

```yaml
name: e_commerce
packages:
  - ./e_commerce_app
  - ../packages/**
```

You can also define custom scripts and versioning rules here.

---

## 🚀 3. Bootstrap the Workspace

To install all dependencies for all packages:

```bash
melos bootstrap
```

This runs `flutter pub get` or `dart pub get` in each package.

---

## 🧪 4. Run Scripts

You can define reusable scripts in `melos.yaml`:

```yaml
scripts:
  analyze:
    run: dart analyze .
  format:
    run: dart format .
  test:
    run: flutter test
```

Then run:

```bash
melos run analyze
melos run format
melos run test
```

---

## 🔍 5. Filter Packages (Scopes)

You can run commands only in certain packages:

```bash
melos exec --scope="ec_notification" -- flutter pub get
melos exec --depends-on="core" -- flutter analyze
```

---

## 🧹 6. Clean Workspace

To clean all `.dart_tool`, `build`, or `pubspec.lock` files:

```bash
melos clean
```

---

## 📎 References

- Melos Docs: [https://melos.invertase.dev](https://melos.invertase.dev)
- Invertase Blog: [https://invertase.io/blog/melos](https://invertase.io/blog/melos)

---
