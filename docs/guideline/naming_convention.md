# 📚 Naming Convention for Flutter Project

Consistent naming improves readability, maintainability, and team collaboration. This document defines naming rules for Flutter projects.

---

## 🧱 1. Files & Folders

| Type      | Rule         | Examples                               |
| --------- | ------------ | -------------------------------------- |
| File      | `snake_case` | `login_screen.dart`, `auth_cubit.dart` |
| Folder    | `snake_case` | `user_profile/`, `home_screen/`         |
| Test file | + `_test`    | `login_bloc_test.dart`                  |

---

## 🧑‍💻 2. Classes & Enums

| Type  | Rule         | Examples                        |
| ----- | ------------ | ------------------------------- |
| Class | `PascalCase` | `LoginScreen`, `AuthRepository` |
| Enum  | `PascalCase` | `UserStatus`, `MessageType`     |

---

## 🧠 3. Variables & Functions

| Type                 | Rule                       | Examples                        |
| -------------------- | -------------------------- | ------------------------------- |
| Variable             | `camelCase`                | `userName`, `isLoggedIn`        |
| Function             | `camelCase`                | `fetchUserData()`, `signOut()`  |
| Const (inside class) | `camelCase`                | `primaryColor`, `maxRetryCount` |
| Constant class       | `PascalCase` + `Constants` | `AppConstants`                  |

---

## 🧪 4. Cubit / Bloc

| Type             | Rule                        | Examples                    |
| ---------------- | --------------------------- | --------------------------- |
| Cubit/Bloc class | `PascalCase` + `Cubit/Bloc` | `LoginCubit`, `SignUpBloc`  |
| State class      | `PascalCase` + `State`      | `LoginState`, `SignUpState` |
| Event class      | `PascalCase` + `Event`      | `LoginSubmittedEvent`       |

> Suggested folders: `cubit/`, `bloc/`, `state/`, `event/`

---

## 🎨 5. Widgets

| Type          | Rule                | Examples                      |
| ------------- | ------------------- | ----------------------------- |
| Public Widget | `EC` + `PascalCase` | `ECScaffold`, `ECProductCard` |

---

## 💡 6. Constants & Keys

| Type            | Rule                      | Examples                        |
| --------------- | ------------------------- | ------------------------------- |
| JSON/String key | `camelCase`               | `userId`, `accessToken`         |
| Route name      | `snake_case` + `/` prefix | `/login_screen`, `/home_screen`  |

---

## 📁 7. Assets

| Type   | Rule         | Examples                             |
| ------ | ------------ | ------------------------------------ |
| Images | `snake_case` | `login_banner.png`, `icon_send.svg`  |
| JSON   | `snake_case` | `dummy_data.json`, `config_dev.json`  |

> Suggested folders: `assets/images/`, `assets/icons/`, `assets/data/`

---

## 🔧 8. Services, Repositories, Models

| Type             | Rule                        | Examples                    |
| ---------------- | --------------------------- | --------------------------- |
| Repository class | `PascalCase` + `Repository` | `UserRepository`            |
| Model class      | `PascalCase`                | `UserModel`, `ProductModel` |
| DTO class        | `PascalCase` + `Dto`        | `UserDto`, `ProductDto`     |

---

## 🧪 9. Testing

| Type               | Rule                        | Examples                                         |
| ------------------ | --------------------------- | ------------------------------------------------ |
| Test file           | `snake_case` + `_test.dart` | `login_screen_test.dart`, `auth_cubit_test.dart` |
| Test class         | `PascalCase` + `Test`       | `LoginScreenTest`, `AuthCubitTest`               |
| Test method        | `test_` + `description`     | `test_should_show_error_when_login_fails()`      |
| Group description  | `camelCase`                 | `group('LoginScreen', () { ... })`               |
| Mock class         | `Mock` + `PascalCase`       | `MockUserRepository`, `MockApiClient`            |
| Test data/fixtures  | `snake_case` + `_fixture`    | `user_fixture.dart`, `product_fixture.dart`        |
| Test helper        | `snake_case` + `_helper`    | `test_helper.dart`, `mock_helper.dart`           |

> Suggested folders: `test/`, `test/fixtures/`, `test/helpers/`, `test/mocks/`

---

## 🚫 10. Bad Practices to Avoid

| Don't                                | Do                                                         |
| ------------------------------------ | ---------------------------------------------------------- |
| `login_screen.dart` with `LoginPage` | Rename class to `LoginScreen` or file to `login_page.dart`  |
| `MyWidget`                           | Use specific name: `UserAvatar`, `ChatCard`                 |
| `Utils.dart`                         | Split into `date_utils.dart`, `string_utils.dart`          |
| `test.dart`                          | Use descriptive name: `login_screen_test.dart`             |
| `testLogin()`                        | Use descriptive name: `test_should_login_successfully()`   |

---

## 🌐 11. Localization (L10n) Keys

| Type                | Rule                             | Examples                                         |
| ------------------- | -------------------------------- | ------------------------------------------------ |
| Error messages      | `error` + `Description`          | `errorUnknown`, `errorUserNotFound`              |
| General UI elements | `general` + `ElementName`        | `generalEmailAddress`, `generalPassword`         |
| Semantic labels     | `semantic` + `Action`            | `semanticShowPassword`, `semanticGoBack`         |
| Screen titles       | `screenName` + `Title`           | `loginTitle`, `homeTitle`, `profileTitle`         |
| Screen subtitles    | `screenName` + `SubTitle`        | `createAccountSubTitle`, `homeSubTitle`          |
| Button labels       | `screenName` + `Btn`             | `loginBtn`, `createAccountBtn`                   |
| Input hints         | `screenName` + `Hint`            | `searchHint`, `chatMessageTextFieldHint`         |
| Dialog content      | `screenName` + `Dialog` + `Type` | `chatMessageDialogBlockUserTitle`                |
| Banner messages     | `screenName` + `Banner` + `Type` | `chatMessageBlockedByMeBannerTitle`              |
| Success messages    | `screenName` + `Success`         | `myAccountUpdateSuccess`                         |
| Action descriptions | `screenName` + `Action`          | `myAccountChoosePhoto`, `myAccountTakeAPhotoBtn` |

### L10n Key Structure Rules:

1. **Prefix Categories:**
   - `error*` - Error messages and exceptions
   - `general*` - Common UI elements used across screens
   - `semantic*` - Accessibility and semantic labels
   - `{screenName}*` - Screen-specific content

2. **Suffix Types:**
   - `Title` - Screen or section titles
   - `SubTitle` - Secondary titles or descriptions
   - `Btn` - Button labels
   - `Hint` - Input field hints and placeholders
   - `Dialog*` - Dialog box content
   - `Banner*` - Banner or notification messages
   - `Success` - Success messages
   - `Description` - Explanatory text

3. **Placeholder Variables:**
   - Use `{variableName}` for dynamic content
   - Add `@keyName` metadata for placeholder definitions
   - Example: `"chatWith": "Chat with {name}"`

4. **Naming Guidelines:**
   - Use `camelCase` for all keys
   - Be descriptive and specific
   - Group related keys with consistent prefixes
   - Avoid abbreviations unless commonly understood

### Example Structure:
```json
{
  "errorUserNotFound": "User not found. Please try again.",
  "generalEmailAddress": "Email Address",
  "semanticShowPassword": "Show Password",
  "loginTitle": "Welcome to App",
  "loginBtn": "Login",
  "settingsDialogLogOutTitle": "Log Out",
}
```

---

## ✅ 12. Summary

| Type                | Naming Style                                        |
| ------------------- | --------------------------------------------------- |
| Files/Folders       | `snake_case`                                        |
| Classes/Enums       | `PascalCase`                                        |
| Variables/Functions | `camelCase`                                         |
| Constants           | `camelCase` or `SCREAMING_SNAKE_CASE` (for globals) |
| L10n Keys           | `camelCase` with category prefixes                  |

---
