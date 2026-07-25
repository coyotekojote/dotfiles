---
name: openapi-conventions
description: OpenAPI / Swagger の仕様ファイル（openapi.yaml, swagger.yaml, schemas/*.yaml）を書くときの落とし穴と書き方。$ref と nullable を併用する場合の allOf パターンなど。API定義YAMLを編集・レビューするときに使用。
---

# OpenAPI / Swagger

## `$ref` と他キーワードの併用（落とし穴）

OpenAPI 3.0では、`$ref` と他のキーワード（`nullable` など）を同じレベルに書くと、**`$ref` が他のキーワードを黙って無視する**。一見正しく見えるのに効かないので注意。

nullableな参照型は `allOf` で包む：

```yaml
field_name:
  type: object
  nullable: true
  allOf:
    - $ref: './path/to/schema.yaml#/components/schemas/SchemaName'
  description: 説明文
```

`nullable: true` を使うときは必ず `type` も定義する。
