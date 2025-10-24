# Security Policy

## Supported Versions

Security updates are provided for the latest version of Agent-SDD. We recommend keeping your framework updated to the latest release.

## Reporting Security Vulnerabilities

If you discover a security vulnerability in Agent-SDD, please report it. **Do not** create public issues for security vulnerabilities.

### How to Report

1. Email security concerns to [support@agent-sdd.com](mailto:support@agent-sdd.com)
2. Include detailed information about the vulnerability
3. Allow reasonable time for response and fixes
4. Do not disclose the vulnerability publicly until it's been addressed

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Affected versions
- Any suggested fixes

## Security Considerations

### File System Access
- Agent-SDD only accesses files within the project directory and framework directories
- No access to system files outside the workspace
- File operations are logged and auditable

### Command Execution
- Terminal commands are executed through platform-specific tools
- No arbitrary command execution capabilities
- Commands are validated and logged

### Network Operations
- MCP server connections require explicit configuration
- Network requests are made through platform tools only
- No automatic external connections

### Data Handling
- All data remains within the local workspace
- No data is transmitted to external servers
- Configuration files contain no sensitive information

### Platform Security
- Framework adapts to each platform's security model
- Claude: Uses Anthropic's secure environment
- Grok: Uses xAI's secure environment
- Codex: Uses GitHub Copilot's secure environment

## Security Best Practices

### For Users
1. Keep your AI platform updated to the latest version
2. Review generated code before execution
3. Use the framework only in trusted development environments
4. Regularly run `sdd-task --validate_system` to check framework integrity

## Known Security Measures

- File locking prevents concurrent critical operations
- Framework validation prevents corruption
- Command logging enables audit trails
- Error boundaries prevent system compromise
- Platform adaptation respects each platform's security model

## Security Updates

Security updates will be:
- Released as soon as possible
- Documented in the changelog
- Communicated through release notes
- Tagged with appropriate security advisories

## Contact

For security-related questions or concerns:
- Email: support@agent-sdd.com
- Response time: Within 48 hours for critical issues
