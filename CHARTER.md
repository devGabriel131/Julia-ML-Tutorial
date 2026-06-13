# Julia ML Competitor — Certification Charter & Cowork Operating Kit

A self-contained program. Every concept is taught **here, by Claude**, backed by a Pluto lesson and a deck. **Kaggle is locked** to two actions only: pull the competition dataset, and push a submission. Nothing else outside.

**Student:** Gabriel — has built ML from scratch in Python (knows training, loss, gradient descent, overfitting). **New to:** Julia's ML ecosystem, and linear algebra.
**Goal:** command Julia's ML toolchain like a competitor, understand the linear algebra underneath it, and finish a real Kaggle competition — earning the credential below.

---

## Part 1 — How this runs in Cowork (and without it)

A **Cowork project** is the home. It gives us four things we actually need:
- **Instructions** — the locked teaching contract (Part 6A), applied to every task automatically.
- **Memory** — the project remembers your progress across sessions, so adaptation is real, not re-explained each time.
- **Context** — a local folder holding all course files (decks, lessons, exams, gradebook).
- **Scheduled / saved tasks** — your "jobs." Run on demand (a button) or on a cadence.

**Your three jobs** map to three saved tasks (prompts in Part 6B):
1. **Build Module Deck** — generates the lecture slides for module N.
2. **Build Module Exam** — generates the computational exam for module N.
3. **Stage Next Session** — reads the gradebook and prepares today's lesson + warm-up. (Good candidate for a daily schedule, if you want it pre-baked each morning.)

**Honest limits:** Cowork is Desktop-only and needs a paid plan; scheduled tasks run only while your machine is awake and the app is open; and I can't create the project from mobile chat — you make it and run `/schedule`, I hand you everything to paste. **No Cowork plan? The program still works fully in chat** — same modules, same exams, same decks; you just trigger each build by asking instead of pressing a saved button.

**THE LOCK (non-negotiable):** Kaggle is used only to (1) download the capstone/lab dataset and (2) upload submissions. No Kaggle Learn, no Kaggle notebooks, no forums for instruction. No external courses, videos, or books. If you ask "where do I learn X," the answer is: I teach it, now.

---

## Part 2 — What you earn

A credential that behaves like a paid certification, because it gates on demonstrated skill, not attendance.

**Title:** *Julia ML Competitor — Certified Practitioner.*
**Earned by:** passing all 10 module exams (≥80% each) + the capstone (a real Kaggle submission + writeup).
**At the end I generate:** an actual certificate document listing the competencies you passed, your capstone competition and final standing, and the date — a real artifact you can keep. Each module you clear is a logged "badge" in the gradebook along the way.

This isn't a participation ribbon. If your exam score is 72%, you re-drill and retake. That's the point of it meaning something.

---

## Part 3 — The curriculum

Ten modules, five tracks, **competency-gated and self-paced**. You advance when you pass, not when a date arrives. Linear algebra is split across two modules and interleaved with the tooling so it lands where you'll use it.

### Track A — The Julia Machine
**M1 · Idiomatic Julia (for someone who knows Python).** Types and the type system, multiple dispatch, functions, arrays vs. your numpy mental model, broadcasting (`.`), the performance mindset (type stability, why loops are *fast* here), `Pkg` environments, and Pluto's reactivity. Every place a Python habit would be wrong, I flag it.
*Competency:* write idiomatic, type-stable Julia; manage a reproducible project; work fluently in Pluto.

**M2 · Linear Algebra I, in Julia.** Vectors, the dot product, norms (L1/L2), matrices, matrix–vector and matrix–matrix products, the `LinearAlgebra` stdlib, and Julia's array semantics (views, mutation, `@.`). Taught from zero but always anchored to running code — this is the algebra under the numpy shapes you've already wrangled.
*Competency:* reason about and compute vector/matrix operations by hand and in Julia; explain a linear prediction as a dot product.

### Track B — The Data Pipeline
**M3 · DataFrames.jl mastery.** IO (CSV/Arrow), indexing and selection, `transform`/`select`/`combine`, `groupby` split-apply-combine, joins, reshaping (stack/unstack), and disciplined handling of `missing` and `CategoricalArrays`.
*Competency:* load, clean, and reshape any tabular dataset idiomatically without reaching for Python reflexes.

**M4 · EDA & Visualization.** Statistical summaries with `Statistics`/`StatsBase`; plotting with `StatsPlots`, then `AlgebraOfGraphics` + `Makie` (grammar-of-graphics). Reading a dataset like a competitor: distributions, leakage smells, target relationships.
*Competency:* produce a fast, revealing EDA pass and defend what you'd engineer from it.

### Track C — The Math–Model Bridge
**M5 · Linear Algebra II + Least Squares.** Column space, rank and linear independence (→ multicollinearity), projections, and the **normal equations**. You implement OLS in Julia (`(X'X)\(X'y)` and the better `X \ y`, and *why* the latter is more stable). The unification: you already *coded* gradient descent in Python — here's the linear algebra (projection onto the column space) that arrives at the **same** `β`, and the calculus (set the gradient to zero) that meets it from the other side. Norms → Ridge/Lasso intuition.
*Competency:* derive and implement least squares; explain regularization as a norm constraint.

### Track D — Julia's ML Prowess (the core)
**M6 · MLJ.jl I — the unified interface.** The MLJ mental model: models vs. machines, `fit!`/`predict`, **scientific types** (`scitype`/`coerce` — very Julia, very MLJ), resampling, `evaluate`, and cross-validation done right.
*Competency:* drive any MLJ model through a clean fit/evaluate/CV loop.

**M7 · Linear & regularized models in Julia.** `GLM.jl` and `MLJLinearModels`: linear/logistic regression, Ridge, Lasso, ElasticNet — tied straight back to M5's norms.
*Competency:* fit, regularize, and interpret linear models; choose penalties deliberately.

**M8 · Trees & Gradient Boosting.** `EvoTrees.jl` (pure Julia, your starting point), then `XGBoost.jl` and `LightGBM.jl`. Hyperparameter tuning with MLJ's `TunedModel` (grid/random), feature importance, and the payoff: the "gradient" in gradient boosting is the calculus gradient you already know — this is the model family that carries tabular Kaggle.
*Competency:* train, tune, and interpret gradient-boosted models that beat your linear baseline.

**M9 · Pipelines, Validation & Ensembling.** Leakage-free pipelines via MLJ composition (transforms fit on train folds only), target/feature transforms inside the pipeline, validation strategy (and *trusting CV over the leaderboard*), and blending/stacking with MLJ's `Stack`. Build one reproducible `.jl` pipeline: raw files in → submission out.
*Competency:* ship a leak-free, reproducible, ensembled pipeline and justify every validation choice.

### Track E — The Arena
**M10 · Capstone.** The live Kaggle competition, end to end, in Julia/Pluto: EDA → features → CV → boosting → ensemble → submission → writeup. Pull the data, push submissions, everything else built here.
*Competency:* a finished, CV-selected submission on the board + a writeup of your validation strategy, features, models, and standing. **This earns the certificate.**

---

## Part 4 — How each module runs (the standard loop)

1. **Deck** — I build the lecture slides (the *Build Module Deck* job). Your reference for the module.
2. **Live class** — we run a **Pluto lesson notebook** together in chat: I explain, you execute, we poke at it. This is the actual teaching.
3. **Computational exam** — I administer it (the *Build Module Exam* job). It has three parts:
   - **Autograder** — a Julia `Test` notebook. You implement functions; visible `@test`s teach, **held-out tests** prevent gaming. Green = pass.
   - **Concept questions** — 3–5 short prompts you answer in your own words; I grade them. (Explaining it back is the real test.)
   - **Lab** — apply the module to real data with a **metric bar** to clear.
   - **Pass = ≥80% overall.** Below that, you re-drill the weak part and retake. I log it.
4. **Gradebook + adapt** — I record your score and error patterns and adjust the next session.

### What a computational exam looks like (sample excerpt, M2)
```julia
using Test

# Task 1 — dot product WITHOUT LinearAlgebra (loop or sum, your call)
function mydot(a, b)
    # your code here
end
@test mydot([1, 2, 3], [4, 5, 6]) == 32          # visible (teaches)
# held-out checks run after you submit:
@test mydot([2.0, -1.0], [3.0, 4.0]) ≈ 2.0
@test_throws DimensionMismatch mydot([1,2], [1,2,3])

# Task 2 — L2 norm built on your mydot
mynorm(v) = # your code here
@test mynorm([3.0, 4.0]) ≈ 5.0

# Task 3 — "boss" challenge: vectorize a slow loop and prove the speedup
#   I give you a naive function; you make it idiomatic and faster,
#   and we benchmark both. Pass = correct result AND measurable speedup.
```
"Interesting" means: implement, beat a threshold, refactor non-idiomatic Julia into idiomatic, debug a broken pipeline, or vectorize for speed — not multiple-choice trivia.

---

## Part 5 — The adaptation protocol

Adaptation is concrete, not magic. It's the project **Memory** plus a `gradebook.md` file I read at the **start of every session**. The protocol:
- **Re-drill first.** Before new material, a short warm-up targeting your single weakest logged competency.
- **Accelerate where strong.** If you're crushing a track, I compress the lectures and raise the lab bar.
- **Inject on failure.** A missed exam topic becomes targeted exercises until it's solid; only then do we advance.
- **Pace honestly.** If sessions are running long or scores dipping, I cut scope and tell you. If you're flying, we add stretch goals.
- **Advance rule:** new module only after the current exam is ≥80%.

---

## Part 6 — The setup kit (copy-paste)

### 6A · Cowork project Instructions (paste into the project's Instructions field)
```
ROLE: You are my instructor for the Julia ML Competitor certification. Teach
entirely within our conversations and the Pluto/Julia notebooks in this project.

LOCKED TOOLING (strict):
- Kaggle is used ONLY to (a) download the capstone/lab dataset and (b) upload my
  submissions. Never direct me to Kaggle Learn, Kaggle notebooks, or forums for
  instruction.
- Do NOT point me to ANY external course, video, book, or blog. All concepts are
  taught by you, here, plus the Pluto lessons and decks you build. If I ask
  "where can I learn X," teach it yourself instead.
- Stack: Julia + Pluto only, for all lessons, labs, and exams. Idiomatic Julia
  always; when a Python habit would be wrong in Julia, flag it explicitly.

MY LEVEL: I've built ML from scratch in Python (I know training/loss/gradient
descent/overfitting). I'm NEW to Julia's ecosystem and NEW to linear algebra.
Teach the Julia tools and the linear algebra rigorously. Don't re-explain basic
ML concepts I already have, but DO connect them to the linear algebra underneath.

HOW WE WORK:
- Follow CHARTER.md. Modules are competency-gated: I advance only after passing
  the module exam at >=80%.
- Each module: (1) build the deck, (2) run the Pluto lesson as a live class with
  me, (3) administer the computational exam, (4) update gradebook.md and adapt.
- At the START of every session, read gradebook.md, tell me where we are and what
  today targets, and re-drill my weakest logged competency before new material.
- Exams: Julia Test-based autograder (visible + held-out tests) + concept
  questions + a data lab with a metric bar. Grade honestly; log scores and error
  patterns.
- Keep me honest about validation: trust CV over the leaderboard.

TONE: direct, rigorous, a little competitive. Don't flatter. Push back when I'm
wrong.
```

### 6B · The three jobs (create with `/schedule`, set to on-demand unless noted)
**Build Module Deck**
```
Build the lecture deck for Module {N} of the Julia ML Competitor program, following
CHARTER.md. Cover exactly that module's competencies. All code samples must be
idiomatic, runnable Julia. Save the .pptx to /decks. Use the agreed deck style.
```
**Build Module Exam**
```
Generate the computational exam for Module {N} per CHARTER.md: a Julia Test-based
autograder notebook (visible + held-out tests, including one "boss" challenge),
3-5 concept questions, and one data lab with a clear pass metric. Pass bar = 80%.
Save to /exams.
```
**Stage Next Session** *(optional: schedule daily, e.g. each morning)*
```
Read gradebook.md. Summarize my current module, competencies passed, and weakest
logged spot. Prepare today's ~4-hour session: a warm-up re-drilling that weak spot,
the day's new material from CHARTER.md, and the lab. Output the plan and warm-ups.
```

### 6C · gradebook.md (seed file)
```
# Gradebook — Julia ML Competitor
Student: Gabriel | Started: {date}

## Status
Current module: M1
Modules passed: []
Capstone: not started

## Module log
### M1 — Idiomatic Julia
- Status: not started
- Exam score: --
- Weak spots: --
- Notes: --
(repeat a block per module M2..M10)

## Running weak-spot list (drill these first each session)
-

## Pace
- Sessions completed: 0
- Avg minutes/session: --
```

### 6D · Folder layout
```
julia-ml-competitor/
  CHARTER.md          <- this document
  gradebook.md
  decks/              <- module slide decks
  lessons/            <- Pluto .jl lesson notebooks
  exams/              <- autograder notebooks + lab specs
  labs/               <- working data + scratch
  kaggle/             <- ONLY: downloaded comp data + submission CSVs
```

---

## Part 7 — Start line

Module 1 (Idiomatic Julia) is ready to build on your word. One quick pick: deck look — **clean technical "lab" style** (my default for dev content), or reuse your **Masterminds house style** if you want the familiar deep-pine/gold? Say the word and I'll produce M1's deck, its Pluto lesson, and its exam.
