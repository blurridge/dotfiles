---
name: magic
description: Manual invocation only. Use when explicitly invoked as $magic to turn a rough prompt into a stronger XML prompt, show it, then immediately execute it.
---

# Prompt Enhancement

When `$magic <rough prompt>` is invoked:

1. Analyze the rough prompt to identify the core task, explicit requirements, implied requirements, domain context, missing constraints, and expected output.
2. Rewrite it as a clear XML-formatted prompt.
3. Show the enhanced prompt in a collapsible details section.
4. Immediately execute the enhanced prompt and deliver the completed result in the same response.

Never stop after showing the enhanced prompt. Do not ask for confirmation before execution unless the task is impossible or would be unsafe.

## Enhancement Principles

- Use semantic XML tags such as `<task>`, `<objective>`, `<requirements>`, `<constraints>`, `<context>`, `<examples>`, and `<output_format>`.
- Nest related concepts logically, with no more than 3-4 levels.
- Replace vague terms with specific, testable criteria.
- Add missing context, constraints, examples, and output structure when helpful.
- Preserve the user's core intent and avoid adding unwanted features.
- Scale the prompt complexity to the task complexity.

## Output Format

````markdown
I'll tighten the prompt and then execute it.

<details>
<summary>Enhanced Prompt</summary>

```xml
[Enhanced XML prompt]
```

**Key Enhancements:**
- [3-5 concise improvements]
</details>

[Completed execution result]
````

## Example

Rough prompt:

```text
$magic write tests for payment service
```

Enhanced prompt shape:

```xml
<task>
  <objective>Create focused unit tests for the payment service</objective>
  <requirements>
    <requirement>Cover successful payment flows</requirement>
    <requirement>Cover invalid input and external payment provider failures</requirement>
    <requirement>Use the repository's existing test framework and style</requirement>
  </requirements>
  <output_format>Implement the tests and summarize verification results</output_format>
</task>
```
