---
name: write-tickets
description: Write technical tickets with structured acceptance criteria and state transitions. Use when user asks to create a ticket, write a task, document a feature, or plan implementation work. Follows [service-name] title convention with detailed acceptance criteria.
---

# Write Tickets

Create well-structured technical tickets with clear acceptance criteria, state transitions, and implementation guidance.

## Before Writing

Ask clarifying questions when requirements are unclear. Do not assume or invent details.

**Always clarify:**
- Ticket type if ambiguous (Feature vs Bug vs Spike vs Chore)
- State lifecycle if any workflow is involved
- Error handling expectations (retry? fail fast? DLQ?)
- Event contracts if integrating with other services
- Dependencies and their current state (ready? mocked?)

**Example questions:**
- "What happens on a 5XX from the broker - retry or fail immediately?"
- "Is there a state machine here? What are the valid transitions?"
- "Does this emit events? What's the proto/schema?"
- "Is the banking service ready or should we mock it?"
- "What's explicitly out of scope to prevent creep?"

## Title Convention

Format: `[service-identifier] [TYPE] Task Description`

- **service-identifier**: Lowercase, hyphenated service/component name
- **TYPE**: FEATURE, BUG, SPIKE, CHORE, REFACTOR, DOCS
- **Task Description**: Clear, action-oriented description

Examples:
- `[fn-execute-order-cmd-sub] [FEATURE] Implement Submit Order Command`
- `[svc-user-auth] [BUG] JWT Token Refresh Fails on Expired Sessions`
- `[api-payments-webhook] [SPIKE] Evaluate Stripe vs Adyen Integration`
- `[db-migrations] [CHORE] Clean Up Orphaned Records`

## Ticket Types

Choose the appropriate type based on the work:

### Feature / Change (Full Template)

New functionality or significant changes. Uses complete template with all sections.

```markdown
## Overview
## Acceptance Criteria
## State Transitions
## API / Contract
## Dependencies
## Technical Notes
## Non-Goals
```

### Bugfix

Lighter template focused on reproduction and fix verification.

```markdown
## Overview

{What is broken}

## Reproduction Steps

1. {Step 1}
2. {Step 2}
3. {Step 3}

## Expected Behavior

{What should happen}

## Actual Behavior

{What happens instead}

## Acceptance Criteria

- [ ] Bug no longer reproducible via steps above
- [ ] {Regression test added}
- [ ] {Related edge cases covered}

## Root Cause (if known)

{Why this happened}
```

### Spike / Investigation

Time-boxed research with defined outputs.

```markdown
## Overview

{What we need to learn/decide}

## Time Box

{X hours/days}

## Questions to Answer

1. {Question 1}
2. {Question 2}

## Expected Outputs

- [ ] Options documented with pros/cons
- [ ] Recommendation with rationale
- [ ] Follow-up tickets created
- [ ] Decision recorded in ADR (if architectural)

## Constraints

- {Budget, timeline, team constraints}
```

### Chore / Tech Debt

Maintenance work requiring justification.

```markdown
## Overview

{What needs to be cleaned up/improved}

## Why Now

{Business trigger or risk that makes this urgent}

## Risk if Deferred

- {What breaks or degrades}
- {Cost of delay}

## Scope

- [ ] {Specific change 1}
- [ ] {Specific change 2}

## Validation

- [ ] {How we know it worked}
- [ ] {Metrics to track}

## Non-Goals

- {What this doesn't fix}
```

---

## Multi-Component Splitting

When work spans multiple components (API, UI, SDK, DB), create separate linked tickets instead of one large ticket.

### Why Split?

- Different developers can work in parallel
- Smaller PRs, easier to review
- Clear dependency tracking (API before UI)
- Better progress visibility

### Structure

Create separate tickets and link them with "blocks/blocked by" relationships:

```
[fn-provider-api] [FEATURE] Add aws_region field (API)
    └── blocks → [ui-aws-connection] [FEATURE] Add region dropdown (UI)

[ui-aws-connection] [FEATURE] Add region dropdown (UI)
    └── blocked by → [fn-provider-api] [FEATURE] Add aws_region field (API)
```

### Linked Ticket Template

Each ticket is standalone but references related work:

```markdown
## Overview

{What this component needs to do}

## Acceptance Criteria

- [ ] {Technical requirement}

## Related Tickets

- Blocks: `[ui-aws-connection] [FEATURE] Add region dropdown (UI)`
- Blocked by: (none, this is the API ticket)

## State Transitions
...
```

### Link Types

| Relationship | Use When |
|--------------|----------|
| **Blocks / Blocked by** | API must finish before UI can start |
| **Relates to** | Related work, no hard dependency |

### Component Suffixes

Add component suffix when multi-component:

| Component | Suffix |
|-----------|--------|
| Backend/API | `(API)` |
| Frontend | `(UI)` |
| SDK/Library | `(SDK)` |
| Database | `(DB)` |
| Infrastructure | `(Infra)` |

Example: `[fn-orders] [FEATURE] Add order cancellation (API)`

---

## Full Feature Template

```markdown
## Overview

{1-2 sentences explaining what needs to be built and why}

## Acceptance Criteria

### Technical Requirements

- [ ] {Idempotency requirement}
- [ ] {Error handling requirement}
- [ ] {Performance requirement}

## State Transitions

{REQUIRED if any state/lifecycle exists. If stateless, write: "No state transitions; stateless operation."}

### By Input Trigger

| Trigger | From State | To State |
|---------|------------|----------|
| {user action / API call} | {state} | {state} |

### By System Response

| Response | From State | To State | Action |
|----------|------------|----------|--------|
| Success | PENDING | COMPLETED | Emit Event.Completed |
| 4XX | PENDING | REJECTED | Emit Event.Rejected(reason) |
| 5XX | ANY | (NO-OP) | NACK, retry per policy |

## API / Contract

### Events

| Event | Version | Trigger |
|-------|---------|---------|
| Order.Submitted | v2 | On successful submission |

**Proto Definition**: `proto/events/order/v2/order_events.proto`

```proto
message OrderSubmitted {
  string order_id = 1;           // required
  google.protobuf.Timestamp submitted_at = 2;  // required
  optional string broker_order_id = 3;
}
```

**Example Payload** (JSON for readability):

```json
{
  "order_id": "ord_123",
  "submitted_at": "2024-01-15T10:30:00Z",
  "broker_order_id": "alp_456"
}
```

**Compatibility**: Backward compatible; new fields optional

### HTTP Endpoints (if applicable)

| Method | Endpoint | Auth |
|--------|----------|------|
| POST | /api/v1/orders | Bearer JWT |

**Success**: 201 Created
**Errors**:
- 400: Validation failed
- 409: Duplicate order_id
- 500: Internal error (include correlation_id)

## Dependencies

- {External service or component this depends on}
- {Mark as "Mocked in first iteration" if not ready}
- {Note: "Dependency on X clearly abstracted"}

## Technical Notes

- **Idempotency**: `order_id -> broker.client_order_id`
- **Error handling**: NACK on 5XX, transition on 4XX
- {Other implementation hints}

## Non-Goals

What this ticket explicitly does NOT cover (prevents scope creep):

- {Feature X - covered in TICKET-123}
- {Edge case Y - deferred to future iteration}
- {Integration Z - out of scope}
```

---

## Writing Acceptance Criteria

### Use Tables for State Transitions

Tables are clearer for state machines - scannable, compact, easy to verify completeness:

| Response | From State | To State | Action |
|----------|------------|----------|--------|
| Success | PENDING_SUBMISSION | SUBMITTED | Emit Order.Submitted |
| 4XX | PENDING_SUBMISSION | REJECTED | Emit Order.Rejected(reason) |

**Do NOT use Gherkin for state transitions** - it adds verbosity without clarity.

### When to Use Gherkin

Reserve for complex multi-step user flows with preconditions that don't fit a state table:

```gherkin
Given a user has 2FA enabled
And they are on a new device
When they attempt to login
Then they receive an SMS verification code
And login is blocked until code is entered
```

### When to Use Checkboxes

Use for technical requirements:

- [ ] Idempotent via `order_id -> alpaca.client_order_id`
- [ ] Outbox events published for all state transitions
- [ ] 5XX responses trigger NACK (not state change)

### Be Specific and Testable

Bad: "Handle errors properly"
Good: "On 4XX from broker, transition to REJECTED and emit Order.Rejected event with broker-provided reason"

---

## State Transitions

**REQUIRED** when any state/lifecycle exists. Split by trigger type to avoid confusion.

### By Input Trigger (user/system action initiates)

| Trigger | From State | To State |
|---------|------------|----------|
| User submits order | DRAFT | PENDING_SUBMISSION |
| Admin cancels | ANY | CANCELLED |

### By System Response (external system responds)

| Response | From State | To State | Action |
|----------|------------|----------|--------|
| Success | PENDING_SUBMISSION | SUBMITTED | Emit Order.Submitted |
| 4XX | PENDING_SUBMISSION | REJECTED | Emit Order.Rejected(reasons) |
| 5XX | ANY | (NO-OP) | NACK and DLQ after retry |
| INSUFFICIENT_FUNDS | PENDING_SUBMISSION | REJECTED_INTERNAL | Emit Order.InternallyRejected |

**If no state exists**: Explicitly state "No state transitions; stateless operation."

---

## API / Contract Section

### Events

Always specify:

| Field | Description |
|-------|-------------|
| Event name | `Order.Submitted` |
| Version | `v2` |
| Proto location | `proto/events/order/v2/order_events.proto` |
| Compatibility | Backward compatible (new consumers handle old events) |

Include proto definition:

```proto
message OrderSubmitted {
  string order_id = 1;                          // required
  google.protobuf.Timestamp submitted_at = 2;  // required
  optional string broker_order_id = 3;
}
```

Include JSON example for readability:

```json
{
  "order_id": "ord_123",
  "submitted_at": "2024-01-15T10:30:00Z",
  "broker_order_id": "alp_456"
}
```

### HTTP Endpoints

| Field | Description |
|-------|-------------|
| Endpoint | `POST /api/v1/orders` |
| Auth | Bearer JWT |
| Success codes | 201 Created |
| Error codes | 400, 401, 409, 500 |
| Error model | `{ "error": string, "code": string, "correlation_id": string }` |

---

## MCP Integration (Jira)

When creating tickets via MCP, use the Atlassian MCP tools. Always use Markdown format for descriptions.

### Create Issue

```
mcp__atlassian__createJiraIssue
```

Parameters:
```json
{
  "cloudId": "YOUR_CLOUD_ID",
  "projectKey": "YOUR_PROJECT",
  "issueTypeName": "Task",
  "summary": "[service-name] [TYPE] Task description",
  "description": "Full ticket content in Markdown format"
}
```

### Example: Create with Overview

```json
{
  "cloudId": "YOUR_CLOUD_ID",
  "projectKey": "ORDERS",
  "issueTypeName": "Task",
  "summary": "[fn-execute-order] [FEATURE] Implement Submit Order",
  "description": "## Overview\n\nImplement order submission flow.\n\n## Acceptance Criteria\n\n- [ ] Idempotent via order_id\n- [ ] NACK on 5XX\n- [ ] Outbox events for all transitions"
}
```

### Transition Issue

```
mcp__atlassian__transitionJiraIssue
```

Common transitions:
- Backlog → To Do
- To Do → In Progress
- In Progress → Done
- Any → Blocked

---

## Epic Assignment

After tickets are finalized and user approves, prompt for epic assignment.

### Workflow

1. **Ask user**: "Which epic should these tickets be assigned to?"
2. **Search existing epics** via MCP based on user's input (fuzzy match)
3. **Present options**: Show matching epics or offer to create new
4. **Assign tickets**: Link all tickets to chosen epic(s)

### Prompting Examples

**Single epic (common case):**
```
User: "assign to the orders epic"
→ Search for epics matching "orders"
→ Present matches: "Found: ORDERS-100 'Order Processing Platform'. Assign all tickets here?"
```

**Multiple epics:**
```
User: "API tickets to backend-infra epic, UI tickets to frontend-redesign"
→ Search for both epics
→ Assign accordingly
```

**No match:**
```
User: "assign to payments epic"
→ Search returns no results
→ "No epic found matching 'payments'. Create new epic 'Payments' or search again?"
```

### MCP Commands

**Search for epics:**

```
mcp__atlassian__searchJiraIssuesUsingJql
```

```json
{
  "cloudId": "YOUR_CLOUD_ID",
  "jql": "project = YOUR_PROJECT AND issuetype = Epic AND summary ~ 'orders' ORDER BY updated DESC",
  "maxResults": 5
}
```

**Assign ticket to epic:**

```
mcp__atlassian__editJiraIssue
```

```json
{
  "cloudId": "YOUR_CLOUD_ID",
  "issueIdOrKey": "ORDERS-124",
  "fields": {
    "parent": { "key": "ORDERS-100" }
  }
}
```

Note: Epic linking uses the `parent` field in next-gen projects, or `customfield_10014` (Epic Link) in classic projects. Check your Jira configuration.

**Create new epic (if needed):**

```
mcp__atlassian__createJiraIssue
```

```json
{
  "cloudId": "YOUR_CLOUD_ID",
  "projectKey": "YOUR_PROJECT",
  "issueTypeName": "Epic",
  "summary": "Payments Integration",
  "description": "Epic for payments-related work"
}
```

### After Ticket Creation

Always end with:
1. "Tickets created. Which epic should I assign them to?"
2. Wait for user input
3. Fuzzy search epics
4. Confirm and assign

---

## Checklist

Before finalizing a ticket:

1. Title follows `[service-name] [TYPE] Description` format
2. Correct ticket type selected (FEATURE/BUG/SPIKE/CHORE)
3. Overview explains the "what" and "why"
4. Acceptance criteria: checkboxes for technical, Gherkin only for complex multi-step flows
5. State transitions table included (or "stateless" stated explicitly)
6. API/Contract section for any events or endpoints
7. Dependencies identified with abstraction strategy
8. Non-Goals section prevents scope creep
9. For Bugs: repro steps + expected vs actual
10. For Spikes: time box + expected outputs
11. For Chores: "why now" + risk + validation
12. Multi-component? Split into linked tickets with blocks/blocked by
13. Component suffix added if multi-component: (API), (UI), (SDK), etc.
14. After creation: prompt for epic assignment (search existing or create new)
