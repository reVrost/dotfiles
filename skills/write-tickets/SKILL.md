---
name: write-tickets
description: Write technical tickets with structured acceptance criteria and state transitions. Use when user asks to create a ticket, write a task, document a feature, or plan implementation work. Follows [service-name] title convention with detailed acceptance criteria.
---

# Write Tickets

Create well-structured technical tickets with clear acceptance criteria, state transitions, and implementation guidance.

## Title Convention

Format: `[service-identifier] Task Description`

- **service-identifier**: Lowercase, hyphenated service/component name
- **Task Description**: Clear, action-oriented description

Examples:
- `[fn-execute-order-cmd-sub] Implement Submit Order Command`
- `[svc-user-auth] Add JWT Token Refresh`
- `[api-payments-webhook] Handle Stripe Payment Events`

## Ticket Types

Choose the appropriate type based on the work:

### Feature / Change (Full Template)

New functionality or significant changes. Uses complete template with all sections.

```markdown
## Description
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
## Description

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
## Description

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
## Description

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

## Full Feature Template

```markdown
## Description

{1-2 sentences explaining what needs to be built and why}

## Acceptance Criteria

### Behavior (Gherkin for complex flows)

Given {precondition}
When {action}
Then {expected result}

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

**Schema**: `schemas/events/order-submitted-v2.json`

```json
{
  "order_id": "string (required)",
  "submitted_at": "ISO8601 (required)",
  "broker_order_id": "string (optional)"
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

### When to Use Gherkin

Use for user-facing behavior and complex flows:

```gherkin
Given a user has insufficient funds
When they submit a buy order
Then the order is rejected with reason "insufficient_funds"
And an Order.InternallyRejected event is emitted
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
| Required fields | `order_id`, `submitted_at` |
| Optional fields | `broker_order_id`, `metadata` |
| Compatibility | Backward compatible (new consumers handle old events) |
| Schema location | `schemas/events/order-submitted-v2.json` |

Include minimal example payload:

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

## Checklist

Before finalizing a ticket:

1. Title follows `[service-name] Description` format
2. Correct ticket type selected (Feature/Bug/Spike/Chore)
3. Description explains the "what" and "why"
4. Acceptance criteria: Gherkin for behavior, checkboxes for technical
5. State transitions table included (or "stateless" stated explicitly)
6. API/Contract section for any events or endpoints
7. Dependencies identified with abstraction strategy
8. Non-Goals section prevents scope creep
9. For Bugs: repro steps + expected vs actual
10. For Spikes: time box + expected outputs
11. For Chores: "why now" + risk + validation
