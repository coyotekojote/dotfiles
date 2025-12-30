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

#### ruby
- Ruby3.1以降のプロジェクトでは、ハッシュリテラルとキーワード引数が省略可能な場合には省略する
  - キーワード引数省略記法: 変数名とキーワード名が同じ場合は省略（例: `foo(param:)` は `foo(param: param)` と同じ）
  - ハッシュ値省略記法: キーと値の変数名が同じ場合は省略（例: `{ name: }` は `{ name: name }` と同じ）
- Serializerでは単純な属性の場合、ブロックではなく`attributes`メソッドを使用する（例: `attributes :id, :name`）

##### リファクタリング原則
- **サービスクラスの使用**: 原則として新規にサービスクラス（`app/services`）を作成しない。既存のモデル内でprivateメソッドによる責務分離を優先する
- **エラー処理の統一**:
  - 事前バリデーション + 早期returnパターンを使用
  - 例外を投げる前にバリデーションで弾けるものは弾く
  - サイレントな失敗（`return {}`等）を避け、明示的なエラー通知または早期returnを使用
- **重複コードの共通化**:
  - 同じパターンの処理（通知、API呼び出し等）は共通メソッドに抽出
  - 共通パラメータを持つメソッドは基底メソッドを作成して委譲
- **メソッド名の簡潔化**:
  - メソッドの役割が名詞のみで表現できる場合は動詞を省略（例: `generate_notice_message` → `notice_message`）
  - 意図が明確であれば短い名前を優先


### Git Workflow
- Write clear, concise commit messages
- Follow conventional commit format when applicable
- Always check git status before committing
- Never commit sensitive information (API keys, passwords, etc.)

### Testing
- Run tests before making changes when possible
- Add tests for new functionality
- Ensure all tests pass before considering work complete

#### テストコードの品質
- テストは必ず実際の機能を検証すること
- `expect(true).toBe(true)` のような意味のないアサーションは絶対に書かない
- 各テストケースは具体的な入力と期待される出力を検証すること
#### ハードコーディングの禁止
- テストを通すためだけのハードコードは絶対に禁止
- 本番コードに `if (testMode)` のような条件分岐を入れない
- テスト用の特別な値（マジックナンバー）を本番コードに埋め込まない
- 環境変数や設定ファイルを使用して、テスト環境と本番環境を適切に分離すること
#### テスト実装の原則
- テストが失敗する状態から始めること（Red-Green-Refactor）
- 境界値、異常系、エラーケースも必ずテストすること
- カバレッジだけでなく、実際の品質を重視すること
- テストケース名は何をテストしているか明確に記述すること
#### 実装前の確認
- 機能の仕様を正しく理解してからテストを書くこと
- 不明な点があれば、仮の実装ではなく、ユーザーに確認すること

### Documentation
- Update documentation when changing functionality
- Keep README files current
- Document breaking changes clearly

## Language-Specific Guidelines

### OpenAPI / Swagger
- OpenAPI 3.0では、`$ref`と他のキーワード（`nullable`など）を同じレベルに書くと、`$ref`が他のキーワードを無視する
- nullableな参照型を定義する場合は、以下のようにallOfを使用する：
  ```yaml
  field_name:
    type: object
    nullable: true
    allOf:
      - $ref: './path/to/schema.yaml#/components/schemas/SchemaName'
    description: 説明文
  ```
- `nullable: true`を使用する際は必ず`type`フィールドも定義すること

## Security Reminders
- Never expose API keys or secrets
- Use environment variables for sensitive configuration
- Review changes for security implications before committing
