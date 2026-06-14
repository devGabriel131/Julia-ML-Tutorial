# Gradebook — Julia ML Competitor

Student: Gabriel
Started: June 4, 2026
Credential: Julia ML Competitor — Certified Practitioner (earned at M10)

---

## Status
- Current module: **M1 — Idiomatic Julia**
- Modules passed: none yet
- Capstone: not started

---

## Module log

### M1 — Idiomatic Julia
- Deck: built · Lesson: built · Exam: built
- Status: **in progress** — first-half RQs (1.1–1.5) done in notebooks/Idiomatic.jl, ~85% on practice; not yet sat exams/M1_exam.jl
- Exam score: — (practice only so far)
- Weak spots: single-dispatch "fake" mechanism (must state: resolves on one type only → needs both runtime types → double-dispatch/visitor); `bounds` tuple destructuring (used nonexistent `minimum!/maximum!`); matrix-vs-vector literal `[1 2 3]` (spaces→Matrix) vs `[1,2,3]` (commas→Vector); type promotion wording (it's promotion, not "most consequential type")
- Notes: 2026-06-13 — graded first half of M1 from pushed Idiomatic.jl. Strong on REPL/pkg, subtyping, sort vs sort!, column-major + offset. Drill the two concept gaps before the exam.

### M2 — Linear Algebra I, in Julia
- Status: not built
- Exam score: —  · Weak spots: —

### M3 — DataFrames.jl
- Status: not built
- Exam score: —  · Weak spots: —

### M4 — EDA & Visualization
- Status: not built
- Exam score: —  · Weak spots: —

### M5 — Linear Algebra II + Least Squares
- Status: not built
- Exam score: —  · Weak spots: —

### M6 — MLJ.jl I
- Status: not built
- Exam score: —  · Weak spots: —

### M7 — Linear & Regularized Models
- Status: not built
- Exam score: —  · Weak spots: —

### M8 — Trees & Gradient Boosting
- Status: not built
- Exam score: —  · Weak spots: —

### M9 — Pipelines, Validation & Ensembling
- Status: not built
- Exam score: —  · Weak spots: —

### M10 — Capstone (live competition)
- Status: not built
- Final submission: —  · Standing: —  · Writeup: —

---

## Running weak-spot list (drill these first each session)
- Single-dispatch "fake": say the mechanism — one type resolved (the receiver), so a two-type op needs both runtime types → manual isa ladder or double-dispatch/visitor.
- `bounds(a) = (minimum(a), maximum(a))` then `lo, hi = bounds(v)` — no `minimum!/maximum!`.
- Literal syntax: `[1 2 3]` (spaces) = Matrix; `[1, 2, 3]` (commas) = Vector. Don't conflate.
- `[1, 2.0]` is Float64 by **promotion** to a common element type, not "most consequential type".

## Pace
- Sessions completed: 0
- Avg minutes/session: —
- Target: ~14 four-hour sessions over ~4 weeks
