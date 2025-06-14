# CLAUDE.md - Global Configuration for Claude

This file contains common instructions and context for Claude to use across all repositories.

## General Guidelines

### NEVER（絶対禁止）
NEVER: パスワードやAPIキーをハードコーディングしない
NEVER: ユーザーの確認なしにデータを削除しない
NEVER: テストなしで本番環境にデプロイしない

### YOU MUST（必須事項）
YOU MUST: すべての公開APIにドキュメントを記載
YOU MUST: エラーハンドリングを実装
YOU MUST: 変更前に既存テストが通ることを確認
YOU MUST: 日本語で応答すること

### IMPORTANT（重要事項）：
IMPORTANT: パフォーマンスへの影響を考慮
IMPORTANT: 後方互換性を維持
IMPORTANT: セキュリティベストプラクティスに従う

### Code Style
- Follow existing code conventions in each project
- Use consistent indentation (check project's .editorconfig or existing code)
- Prefer clarity over cleverness
- Write self-documenting code without unnecessary comments

### Git Workflow
- Write clear, concise commit messages
- Follow conventional commit format when applicable
- Always check git status before committing
- Never commit sensitive information (API keys, passwords, etc.)

### Testing
- Run tests before making changes when possible
- Add tests for new functionality
- Ensure all tests pass before considering work complete

### Documentation
- Update documentation when changing functionality
- Keep README files current
- Document breaking changes clearly

## Language-Specific Guidelines

WIP

## Security Reminders
- Never expose API keys or secrets
- Use environment variables for sensitive configuration
- Review changes for security implications before committing
