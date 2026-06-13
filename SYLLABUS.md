# SYLLABUS — Julia ML Competitor

The canonical course map. **CHARTER.md** says *how* we operate (the lock, the loop, the gradebook); this file says *what* we teach, *in what order*, and *how long each piece takes*. The Cowork build-jobs read the per-module specs here.

---

## The pedagogical order (and the reasoning)

The organizing principle is **just-in-time mathematics**: each piece of linear algebra is taught immediately before the tool that consumes it, so the math is never abstract homework — it's the thing you're about to use.

- **Light linear algebra early (M2)** — vectors, dot products, matrices. This cements the array/vector mental model that makes DataFrames, broadcasting, and feature matrices click. It's concrete (you've touched it in numpy), so it's a gentle on-ramp, not a wall.
- **Heavy linear algebra late (M5), placed against linear models (M7)** — projections, the normal equations, the calculus↔linalg unification. It lands right before the module where it *becomes a fitted model you submit*. Maximum payoff, minimum "why am I learning this."
- **Data before models** — you're loading real data by M3 and visualizing it by M4, so motivation stays high before the heavier modeling work.
- **Validation discipline introduced the moment models appear (M6)** and hammered through M9 — because trustworthy cross-validation, not fancy models, is what actually separates competitors.

The rest of the order is forced by hard dependencies: MLJ (M6) needs DataFrames (M3); regularization (M7) needs norms (M5); ensembling (M9) needs models (M7, M8); the capstone (M10) needs all of it.

---

## At a glance

| # | Module | Hours | 4h Sessions | Math |
|---|--------|-------|-------------|------|
| M1 | Idiomatic Julia | 4–5 | 1 | — |
| M2 | Linear Algebra I, in Julia | 4–6 | 1.5 | vectors, dot, norms, matmul |
| M3 | DataFrames.jl | 5–7 | 1.5 | — |
| M4 | EDA & Visualization | 4 | 1 | descriptive stats |
| M5 | Linear Algebra II + Least Squares | 5–6 | 1.5 | projections, normal eqns |
| M6 | MLJ.jl I — the interface | 4–5 | 1 | CV logic, metrics |
| M7 | Linear & Regularized Models | 4 | 1 | regularization geometry |
| M8 | Trees & Gradient Boosting | 5–6 | 1.5 | gradient-of-loss (concept) |
| M9 | Pipelines, Validation & Ensembling | 5 | 1.5 | bias–variance |
| M10 | Capstone (live competition) | 8–12 | 2.5 | applied |

**Total ≈ 14 four-hour sessions · ~55–60 hours · ~4 weeks** at 4h/day with rest days. Modules marked 1.5 sessions are meant to span two sittings — don't cram them.

---

## Module specifications

Each spec is what a build-job needs to produce a deck, a Pluto lesson, and an exam consistent with the rest of the course.

### M1 · Idiomatic Julia  *(BUILT)*
- **Topics:** REPL modes; the type system (abstract/concrete, `<:`); multiple dispatch; functions (short-form, anonymous, the `!` convention, multiple return + destructuring); arrays (1-based, column-major, indexing, comprehensions); broadcasting & loop fusion (`@.`); mutation & views (`@view`, copy semantics); type stability & `@code_warntype`; `@time`; Pkg environments (`Project.toml`/`Manifest.toml`); Pluto reactivity.
- **Packages:** Base, LinearAlgebra (intro), Pkg, Pluto.
- **Idiomatic focus:** loops are fast; dispatch over `if`-on-type; `!`/`@view` conventions; type stability.
- **Exam competency:** write type-stable idiomatic Julia; use dispatch/broadcasting/`!`/`@view` correctly; stand up an environment; **boss:** vectorize a slow loop and beat a benchmark.

### M2 · Linear Algebra I, in Julia
- **Topics:** scalars & vectors; vector addition and scaling; linear combinations & span (intuition); the **dot product** (as weighted sum / similarity / projection); **norms** (L1, L2, geometry); matrices as data *and* as operators; **matrix–vector product** (a stack of dot products = a linear prediction); matrix–matrix product; transpose; identity; the `LinearAlgebra` stdlib (`dot`, `norm`, `*`, `'`, `I`).
- **Packages:** LinearAlgebra.
- **Math (from zero):** vectors, dot product, norms, matrix multiplication — with by-hand drills.
- **Idiomatic focus:** when to use `dot`/`norm`/`*` vs explicit loops; broadcasting vs matrix algebra; column-major and why matmul order matters.
- **Exam competency:** compute vector/matrix ops by hand *and* in Julia; explain a linear prediction as `Xβ`; implement `dot` and `norm` from scratch and match `LinearAlgebra`.

### M3 · DataFrames.jl
- **Topics:** constructing DataFrames; `CSV.read`/`CSV.write`; the column/row model; indexing (`df[!, :c]` no-copy vs `df[:, :c]` copy — callback to M1 view semantics); the `=>` transformation mini-language (`source => fun => dest`); `select`/`transform`/`combine`; `groupby` split-apply-combine; `filter`/`subset`; joins (inner/left/outer); reshaping (`stack`/`unstack`); missing data (`skipmissing`, `coalesce`, `dropmissing`); `CategoricalArrays`; `describe`.
- **Packages:** DataFrames, CSV, CategoricalArrays.
- **Idiomatic focus:** the `=>` DSL; `!` vs `:` indexing; replace row loops with `groupby`/vectorized transforms; sparing `eachrow`.
- **Exam competency:** load, clean, and reshape an unfamiliar dataset; a multi-step split-apply-combine; correct missing + categorical handling.

### M4 · EDA & Visualization
- **Topics:** descriptive stats (mean/median/std/quantiles); distributions & histograms; scatter/box/violin; correlation (note: a normalized dot product — callback to M2); grouped summaries; reading data like a competitor (target distribution, missingness patterns, leakage smells, outliers); StatsPlots for a fast start, then AlgebraOfGraphics + Makie (layered grammar-of-graphics); saving figures.
- **Packages:** Statistics, StatsBase, StatsPlots, AlgebraOfGraphics, CairoMakie.
- **Idiomatic focus:** AoG's `data(df) * mapping(...) * visual(...)` algebra; the Makie figure/axis model.
- **Exam competency:** produce a revealing EDA pass on a new dataset and defend what you'd engineer and what you'd worry about.

### M5 · Linear Algebra II + Least Squares  *(the boss fight)*
- **Topics:** linear independence & **rank** (→ multicollinearity); **column space** of the features; orthogonality & **projection**; the least-squares problem `min ‖y − Xβ‖²`; the **normal equations** `XᵀXβ = Xᵀy`; the geometric view (`ŷ` = projection of `y` onto `col(X)`, residual ⊥ columns); the **unification** — the calculus path (set the gradient to zero) and the linear-algebra path (projection) arriving at the same `β`; numerical solving (`X \ y` via QR vs forming `XᵀX`, and *why* `\` wins); condition number / why multicollinearity hurts; norms-as-regularization preview (L2 shrinks, L1 zeros).
- **Packages:** LinearAlgebra.
- **Math (the heart):** projections, the normal equations, the gradient-of-MSE derivation. This is where your from-scratch Python gradient descent finally gets its linear-algebra explanation.
- **Idiomatic focus:** the `\` operator; never invert a matrix explicitly (`inv` is the antipattern).
- **Exam competency:** derive the normal equations *both ways*; implement OLS and match `X \ y`; explain projection & multicollinearity; fit a tiny dataset by hand.

### M6 · MLJ.jl I — the unified interface
- **Topics:** the MLJ mental model (models vs **machines**); **scientific types** (`scitype`, `coerce`, `schema`; Continuous/Count/Multiclass/OrderedFactor — callback to M1's type system); `@load`; `machine(model, X, y)`, `fit!`, `predict`/`predict_mode`; `partition` for train/test; **resampling & cross-validation** (`evaluate`, `CV`, `StratifiedCV`); measures (accuracy, rmse, log_loss, auc); what data leakage is and how CV keeps you honest.
- **Packages:** MLJ (+ a backend, e.g. MLJLinearModels, for examples).
- **Idiomatic focus:** scitypes & `coerce` (the MLJ discipline); the machine lifecycle.
- **Exam competency:** drive any MLJ model through coerce → split → fit → CV → evaluate; pick the right metric; explain leakage. *(This module plants the single most important competitor skill — CV. Emphasize it.)*

### M7 · Linear & Regularized Models in Julia
- **Topics:** linear regression (MLJ / GLM); logistic regression for classification; the intercept; **Ridge (L2)**, **Lasso (L1)**, **ElasticNet** — tied straight to M5 norms (L2 shrinks coefficients, L1 induces sparsity = feature selection); why standardize features before regularizing; interpreting coefficients; choosing penalty strength λ by CV; GLM.jl (stats-style output) vs MLJLinearModels (pipeline-style).
- **Packages:** GLM, MLJLinearModels, MLJ (Standardizer).
- **Math:** regularization as constrained least squares (callback to M5); L1-vs-L2 geometry.
- **Idiomatic focus:** composing a Standardizer + model; tuning λ via CV.
- **Exam competency:** fit & regularize a linear/logistic model with proper standardization & CV; interpret it; choose a penalty deliberately; beat the unregularized baseline.

### M8 · Trees & Gradient Boosting
- **Topics:** decision trees (quick intuition); trees → ensembles (bagging/RF vs boosting); **gradient boosting** (fits the negative gradient of the loss — the "gradient" callback to M5/calculus); **EvoTrees.jl** (pure Julia, the starting point), then **XGBoost.jl** and **LightGBM.jl**; key hyperparameters (`max_depth`, `eta`/learning rate, `nrounds`, row/col subsample, min child weight); tuning with MLJ `TunedModel` (Grid / RandomSearch, `range`); early stopping; feature importance & gain; categoricals for trees.
- **Packages:** EvoTrees, XGBoost, LightGBM, MLJ (TunedModel, range).
- **Idiomatic focus:** MLJ ranges & `TunedModel`; swapping backends behind one MLJ interface.
- **Exam competency:** train + tune a boosting model with proper CV (≥2 hyperparameters); read feature importance; beat the linear baseline; **first real submission to the live competition.**

### M9 · Pipelines, Validation & Ensembling
- **Topics:** leakage-free **pipelines** (MLJ composition with `|>` / `Pipeline`; preprocessing fit on train folds only); **target transforms** inside the pipeline (`TransformedTargetModel` — e.g. log-transform a skewed target like House Prices); **validation strategy** (matching the CV scheme to the competition; why you trust CV over the public leaderboard — a small, noisy, overfittable sample; public vs private split); **ensembling** — averaging/blending and **stacking** (`Stack`); selecting your final submission by CV, not LB; the reproducible end-to-end `.jl` pipeline (raw files → submission).
- **Packages:** MLJ (Pipeline, TransformedTargetModel, Stack), the model packages.
- **Math:** bias–variance (concept); why averaging reduces variance.
- **Idiomatic focus:** pipeline composition; no-leakage discipline; reproducibility.
- **Exam competency:** ship a leakage-free, reproducible, ensembled pipeline; justify every validation choice; show that your CV tracks the leaderboard.

### M10 · Capstone — the live competition
- **Topics:** the live Kaggle competition end to end — EDA → feature engineering → CV harness → boosting + linear models → tuning → ensemble → CV-based submission selection → writeup → iterate. (Kaggle touched only to pull data and push submissions.)
- **Packages:** everything.
- **The exam *is* the capstone:** a CV-selected final submission on the board + a 1-page writeup (problem, validation strategy, features, models, what worked, final standing) + a reproducible pipeline. **This earns the certificate.**

---

## Cowork handoff — complete context

Drop these into one Cowork project folder so a fresh task has everything it needs.

### File manifest
```
julia-ml-competitor/
  CHARTER.md          <- operating manual (the lock, the loop, gradebook rules)
  SYLLABUS.md         <- this file (order, topics, time budgets, module specs)
  gradebook.md        <- progress + scores + weak-spot log
  decks/
    M1_idiomatic_julia.pptx     <- BUILT (quality + style reference for all later decks)
  lessons/
    M1_idiomatic_julia.jl       <- BUILT (structure reference for all later lessons)
  exams/              <- (M1 exam pending)
  labs/               <- working data + scratch
  kaggle/             <- ONLY: downloaded competition data + submission CSVs
```

### Current status
- **M1:** deck + lesson **built**. M1 exam **pending**.
- **M2–M10:** **pending** — build on demand via the jobs below.
- The M1 deck (clean technical "lab" style: dark editor-style code panes, monospace headings, the three-dot motif, red/green Python-vs-Julia contrasts) and the M1 lesson (runnable, `── SECTION ──` cells, a PRACTICE block of stubs + held-back checks) define the **quality bar and house style** every later module must match.

### The three jobs (create with `/schedule`; on-demand)
**Build Module Deck**
```
Build the lecture deck for Module {N} of the Julia ML Competitor program. Read its
spec in SYLLABUS.md and follow CHARTER.md. Match the style and quality of
decks/M1_idiomatic_julia.pptx exactly: clean technical "lab" look, dark editor-style
code panes with three-dot chrome, monospace (Consolas) headings + clean body, the
Julia three-dot motif, red for the Python habit / green for the Julia idiom. Cover
exactly that module's topics and end on the competency + exam slide. All Julia code
must be idiomatic and runnable. Save the .pptx to /decks.
```
**Build Module Exam**
```
Generate the computational exam for Module {N} per its SYLLABUS.md spec and CHARTER.md.
Match the structure of the M1 lesson's PRACTICE block: a Julia Test-based autograder
(visible teaching tests + held-out checks the student can't see), 3-5 concept questions
I grade in chat, and one "boss" challenge from the module's exam competency. Pass bar =
80%. Save to /exams.
```
**Stage Next Session**
```
Read gradebook.md and SYLLABUS.md. Tell me my current module, competencies passed, and
weakest logged spot. Using the module's hour/session budget, prepare today's ~4-hour
session: a warm-up re-drilling my weak spot, the day's new material, and the lab. If the
current module spans 1.5 sessions, tell me which half today covers. Output the plan and
warm-ups.
```

### One rule the jobs must honor (also in CHARTER.md)
Kaggle is used **only** to download the capstone/lab dataset and upload submissions. No external courses, videos, or books. Every concept is taught in-project, in Julia/Pluto.

---

*Next build targets: the M1 exam (to close Module 1), then M2 (Linear Algebra I).*
