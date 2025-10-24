# Go Project Memory

## Build & Development Commands

- **Format**: `go fmt ./...` or `gofmt -w .`
- **Test**: `go test ./...` or `go test -v ./...`
- **Vet**: `go vet ./...`
- **Lint**: `golangci-lint run`
- **Build**: `go build` or `go build -o app`
- **Run**: `go run main.go`

## Code Style Guidelines

### General
- Use **tabs** for indentation (Go standard)
- Use **gofmt** for formatting (automatic)
- Follow **Effective Go** guidelines
- Keep packages focused and small

### Go Specifics
- Error handling: always check errors
- Use meaningful variable names
- Keep functions small
- Use interfaces for abstraction
- Prefer composition over inheritance

### Naming Conventions
- **camelCase**: Unexported names
- **PascalCase**: Exported names
- **ALL_CAPS**: Never use (not idiomatic Go)
- Short names for short scopes: `i`, `err`, `ok`

### Error Handling
```go
result, err := operation()
if err != nil {
    return fmt.Errorf("operation failed: %w", err)
}
```

## Project Architecture

- **cmd/**: Main applications
- **pkg/**: Library code
- **internal/**: Private code
- **api/**: API definitions

## Modern CLI Tools

@../../core/steering.md
