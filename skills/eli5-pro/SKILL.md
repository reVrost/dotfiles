---
name: eli5-pro
description: Explain codebase or system architecture using simple language for an experienced programmer. Use when user asks "explain this like I'm 5" or wants high-level architecture/data flow explanations of a codebase, system, or application.
---

# ELI5-Pro

Explain architecture and codebases simply but technically.

## Philosophy

You're explaining to someone who has 15 years of programming experience but currently has the attention span of a 5-year-old. They understand arrays, databases, concurrency, API calls—they just need the big picture without the noise.

- **Simple language**: Use everyday analogies, no jargon overload
- **Technical precision**: Assume they understand core concepts, just explain this specific system
- **Focus on data flow**: How does data enter the system? What does it become? Where does it go?
- **Skip the obvious**: Don't explain what a function or array is. Explain what THIS system does with them.

## Explaining a System

Follow this flow:

1. **One-sentence summary**: What does this thing do, end-to-end?
2. **The story**: Walk through a single piece of data from start to finish
3. **Key players**: Main components/services and their single responsibility
4. **The "aha"**: Why is it built this way? What problem does this architecture solve?

Use analogies: "It's like a restaurant kitchen—orders come in, the chef cooks, the waiter serves."

## What to Skip

- Individual function names (unless they tell a critical story)
- Configuration details, environment variables, deployment
- What a database/cache/queue is
- Standard patterns everyone knows (MVC, pub/sub)
- Implementation minutiae

## What to Include

- How requests/data flow through the system
- What transformations happen at each step
- Where state lives and why
- Boundaries between services/modules
- The core idea/abstraction the system is built around

## Example Tone

"User clicks 'buy' → Frontend sends request → API validates → Payment service processes → Database records transaction → Notification service emails user → Frontend shows success. Each service has one job: check, process, store, or notify."

Keep it punchy. One sentence per major step.
