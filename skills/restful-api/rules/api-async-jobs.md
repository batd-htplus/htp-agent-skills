---
title: Long-Running Operations as Jobs
impact: HIGH
impactDescription: Prevents timeouts and creates a predictable model for async work.
tags: rest, api, http, async, jobs, long-running, 202
---

## Long-Running Operations as Jobs

**Impact: HIGH (reliability and UX)**

If an operation may take longer than a typical HTTP request window (or involves background processing),
model it as a Job resource.

- Return `202 Accepted` for the trigger call
- Include a `Location` header pointing to the job resource
- Provide `GET /v1/jobs/{id}` for status and progress
- Optionally provide a link to the resulting resource once complete

**Incorrect (blocks request until completion):**

```
POST /v1/reports    ❌ request may take minutes; likely timeouts/retries duplicate work
200 OK
{ "data": { "report_id": "r_123" } }
```

**Correct (job resource + polling):**

```
POST /v1/reports
202 Accepted
Location: /v1/jobs/j_123    ✅ async job created
{ "data": { "job_id": "j_123", "status": "queued" } }
```

```
GET /v1/jobs/j_123
200 OK
{
  "data": {
    "id": "j_123",
    "status": "running",
    "progress": { "pct": 40 },
    "result": null
  }
}    ✅ predictable polling payload
```

Reference: [MDN — 202 Accepted](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/202)
