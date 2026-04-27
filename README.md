# QA Automation Project – Robot Framework

## 📌 Description

This project contains automated UI tests for the TutorialsNinja demo website using Robot Framework and SeleniumLibrary.

It covers two main user stories:

* User registration and authentication
* Product search and filtering

---

## 🛠 Tech Stack

* Robot Framework
* SeleniumLibrary
* Python
* VS Code

---

## 📂 Project Structure

```
Suites/
  userStory1.robot   # Registration & Login tests
  userStory2.robot   # Search & Product display tests

Config/
  ImportRessources.robot
```

---

## ✅ Test Coverage

### User Story 1 – Authentication

* Register a new account
* Login with valid credentials
* Login with invalid credentials

### User Story 2 – Product Search

* Navigate to search page
* Search product with correct category
* Search with incorrect category
* Switch between Grid and List view

---

## ▶️ Run Tests

Run all tests:

```bash
robot Suites/
```

Run specific test by tag:

```bash
robot --include RBF007 Suites/
```

---

## 🚧 Future Improvements

* Refactor project using Page Object Model (POM)
* Separate locators, keywords, and test data
* Improve test reusability
