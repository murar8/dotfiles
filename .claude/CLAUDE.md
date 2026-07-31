# Code style

- Destructure at the assignment site, not in the parameter list:
  `function f(arg) { const { a, b } = arg }`, not `function f({ a, b })`.
- For either/or logic, use explicit `if`/`else` even when the `else` isn't
  strictly needed (e.g. the `if` branch returns).
