# Contributing to Fedora Cleaner

Thank you for considering contributing to Fedora Cleaner! We appreciate your time and effort in making this tool better for everyone.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
- [Commit Message Guidelines](#commit-message-guidelines)
- [License](#license)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Bugs are tracked as [GitHub issues](https://github.com/DevOpsTerminal/fedora-cleaner/issues). When creating a bug report, please include the following information:

1. **A clear, descriptive title**
2. **Steps to reproduce** the issue
3. **Expected behavior**
4. **Actual behavior**
5. **Screenshots** (if applicable)
6. **System information** (OS, distribution, version, etc.)
7. **Fedora Cleaner version**

### Suggesting Enhancements

Enhancement suggestions are also tracked as [GitHub issues](https://github.com/DevOpsTerminal/fedora-cleaner/issues). When suggesting an enhancement, please include:

1. **A clear, descriptive title**
2. **A detailed description** of the enhancement
3. **Why this enhancement would be useful** to most users
4. **Examples** of how it might be used

### Pull Requests

1. Fork the repository and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. Ensure the test suite passes.
4. Make sure your code lints.
5. Update the documentation as needed.
6. Issue that pull request!

## Development Setup

1. **Fork** the repository on GitHub
2. **Clone** your fork locally
   ```bash
   git clone https://github.com/your-username/fedora-cleaner.git
   cd fedora-cleaner
   ```
3. **Set up** the development environment:
   ```bash
   # Install development dependencies
   make dev-setup
   ```
4. **Make your changes**
5. **Test your changes**
   ```bash
   make test
   ```
6. **Commit your changes**
   ```bash
   git add .
   git commit -m "Your detailed description of your changes."
   ```
7. **Push** to your fork and submit a pull request

## Style Guidelines

- **Bash Scripting**: Follow the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- **Documentation**: Use Markdown for documentation
- **Code Formatting**: Use `shellcheck` for linting

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) for our commit messages:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types:
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools

## License

By contributing, you agree that your contributions will be licensed under its Apache License 2.0.
