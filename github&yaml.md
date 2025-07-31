---
# YAML & GitHub Actions Workshop Notes

*Date: 2025-07-25*  
*Tags: `devops`, `ust`, `github`, `cicd`*

---

# Part 1: YAML Refresher

> **YAML** stands for *YAML Ain’t Markup Language*. It’s a human-friendly data-serialization format, perfect for configs.

## 1.1 Core Syntax Rules

- **Indent with spaces only** (no tabs). Standard is **2 spaces**.
- **Key: Value** pairs:  
  ```yaml
  name: "Anubhav Khandelwal"
  env: production
  ```
- **Lists**:
  ```yaml
  # Multiline
  services:
    - web
    - api
  # Inline
  services: [web, api]
  ```
- **Nested Structures**:
  ```yaml
  databases:
    - name: users
      engine: postgres
    - name: cache
      engine: redis
  ```
- **Long strings**:
  - `|` preserves line breaks
  - `>` folds lines into spaces
- **Comments** start with `#`.
- Supported types: **strings**, **numbers**, **booleans**, **null**, **dates**.

---

# Part 2: GitHub Actions Crash Course

GitHub Actions lets you define **automated workflows** for building, testing, and deploying—right in your repo.

## 2.1 Vocabulary

| Term       | Meaning                                                                 |
|------------|-------------------------------------------------------------------------|
| **Workflow** | A `.yml` file under `.github/workflows/`—your CI/CD script.            |
| **Event**    | What triggers the workflow (`push`, `pull_request`, `schedule`, etc.). |
| **Job**      | A set of sequential `steps` on the same runner.                        |
| **Step**     | A single action or command.                                            |
| **Action**   | Pre-built, reusable step (e.g., `actions/checkout`).                   |
| **Runner**   | The VM (GitHub-hosted or self-hosted) where your jobs run.             |

## 2.2 Basic Workflow Structure

```yaml
name: Example Workflow          # optional display name
on: [push, pull_request]       # events to listen for

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v4

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

## 2.3 Triggers Explained

### Push Events

```yaml
on:
  push:
    branches: [main, develop]
    paths:
      - 'src/**'
      - '*.js'
    branches-ignore: ["feature-*"]
```

- **branches**: run only on specified branches.
- **paths**: only run when these files change.
- **branches-ignore / paths-ignore**: exclude patterns.

### Pull Request Events

```yaml
on:
  pull_request:
    types: [opened, synchronize, reopened]
    branches: [main]
```
## Understanding `pull_request` Types in GitHub Actions

In GitHub Actions, you can specify which types of pull request events should trigger your workflow using the `types` field under the `pull_request` event.

### 🔹 `opened`
- Triggered when a **new pull request is created**.
- **Example:** A developer creates a PR to merge their `feature` branch into `main`.
- **Use Case:** Run CI checks or code review bots when a new PR is submitted.

---

### 🔹 `synchronize`
- Triggered when the **PR branch is updated**.
- Happens when:
  - New commits are pushed to the PR source branch
  - The branch is rebased or force-pushed
- **Use Case:** Automatically re-run tests when the contributor makes changes.

---

### 🔹 `reopened`
- Triggered when a previously **closed PR is reopened**.
- Works whether the PR was merged or simply closed.
- **Use Case:** Re-validate or re-t
Workflow runs when a PR to `main` is opened, updated, or reopened.

### Scheduled (Cron) Jobs

```yaml
on:
  schedule:
    - cron: '30 2 * * *'   # every day at 02:30 UTC
    - cron: '0 9 * * 1'    # every Monday at 09:00 UTC
```

### Manual Dispatch

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Where to deploy'
        required: true
        type: choice
        options: [staging, production]
```
You can trigger this via the **Actions** tab in GitHub UI.

### Multiple Triggers

```yaml
on:
  push: {}
  pull_request: {}
  schedule:
    - cron: '0 0 * * *'
  workflow_dispatch: {}
```

### Release Events

```yaml
on:
  release:
    types: [published, created]
```
This fires when you draft or publish a GitHub Release.

---

# Part 3: Pro Tips & Best Practices

1. **Pin Action versions** (e.g., `actions/checkout@v4`) for stability.
2. **Use secrets** for tokens and credentials.
3. **Cache dependencies** (`actions/cache`) to speed up builds.
4. **Matrix builds** to test multiple versions in parallel.
5. **Conditional jobs** using `if:` and `paths-filter` action.
6. **Reuse workflows** with `workflow_call`.
7. **Add badges** to your README to show build status.

Happy automating! 🚀
