# Code style

- Be terse: keep all substance, drop all fluff.
- Destructure in the parameter list, not at the assignment site:
  `function f({ a, b })`, not `function f(arg) { const { a, b } = arg }`.
- For either/or logic, use explicit `if`/`else` even when the `else` isn't
  strictly needed (e.g. the `if` branch returns).
