### ============================================================
###  Julia ML Competitor — Module 01 EXAM: Idiomatic Julia
###
###  FORMAT
###    PART A  Your answers   — edit the stub functions.
###    PART B  Grading        — run it; the @testset prints pass/fail. DON'T edit.
###    PART C  Boss benchmark — run it, report the result in chat.
###    PART D  Concept Qs     — answer in chat; I grade them.
###
###  SCORING            Pass = 80%
###    PART B autograded   E1–E5  ........ 50%   (10% each)
###    PART C boss          E6 correct 15% + benchmark report 5% .... 20%
###    PART D concept       C1–C5 ........ 30%   (6% each)
###
###  HOW TO TAKE IT
###    1. Implement every stub in PART A.
###    2. Run the whole file (julia M1_exam.jl, or in Pluto). Make PART B green.
###    3. Run PART C, note the numbers.
###    4. Paste your PART C report + PART D answers into chat. I grade + log it.
###
###  Held-out note: the tests below include cases beyond the obvious one.
###  Hard-coding a single return value WILL fail them. Solve it for real.
### ============================================================


### ============================================================
### PART A — YOUR ANSWERS  (edit these stubs)
### ============================================================

# E1 · Broadcasting. Min-max scale a vector to [0, 1] with NO loop.
#      (use broadcasting; assume the vector is not constant)
rescale(v) = (v .- minimum(v)) ./ maximum(v) .- minimum(v)

# E2 · Multiple dispatch. Define THREE methods of `mash` so that:
#        mash(Int, Int)        -> their sum
#        mash(String, String)  -> the two strings concatenated
#        mash(Int, String)     -> the string repeated Int times
#      (define the three typed methods below; delete this generic stub)
mash(a::Int, b::Int) = a + b
mash(a::String, b::String) = a * b
mash(a::Int, b::String) = a^b
# E3 · The ! convention + mutation. Set every negative entry of v to 0
#      IN PLACE, and return v itself (the same object).
function clamp_neg!(v)
    for i in v
        if i < 0
            v[i] = 0
        end
    end
    return v
end

# E4 · Type stability. This returns the right number but is type-UNSTABLE.
#      Fix ONLY the marked line so the @inferred test passes.
function total(v)
    s = zero(eltype(v))                # <-- FIX THIS LINE (hint: zero(eltype(v)))
    for x in v
        s += x
    end
    return s
end

# E5 · Arrays + comprehension. Build the n×n identity matrix (Float64)
#      using a 2-D comprehension. (No `using LinearAlgebra`; build it yourself.)
identity_like(n) = [isequal(i,j) ? 1 : 0 for i in 1:n, j in 1:n]

# E6 · BOSS. `normalize_slow` (provided) standardizes a vector but allocates
#      several temporary arrays. Implement `normalize_fast` to do the same
#      with fused broadcasting and minimal allocation.
function normalize_slow(v)
    m = sum(v) / length(v)
    centered = [x - m for x in v]
    s = sqrt(sum([c^2 for c in centered]) / length(v))
    return [c / s for c in centered]
end

normalize_fast(v) = (v .- (sum(v) / length(v))) ./ sqrt(sum((v .- (sum(v) / length(v))) .^2 ) ./ length(v))


### ============================================================
### PART B — GRADING  (run; do not edit)
### ============================================================
using Test

@testset "M1 EXAM — autograded (E1–E5)" begin

    @testset "E1 rescale" begin
        @test rescale([0.0, 5.0, 10.0]) == [0.0, 0.5, 1.0]
        @test rescale([3.0, 1.0, 2.0]) == [1.0, 0.0, 0.5]      # held-out
        @test rescale([-2.0, 2.0]) == [0.0, 1.0]               # held-out (negatives)
    end

    @testset "E2 mash (multiple dispatch)" begin
        @test mash(2, 3) == 5
        @test mash("a", "b") == "ab"
        @test mash(3, "hi") == "hihihi"
        @test mash(0, "x") == ""                               # held-out
        @test mash(-1, -1) == -2                               # held-out
    end

    @testset "E3 clamp_neg! (in place)" begin
        v = [-1.0, 2.0, -3.0]
        @test clamp_neg!(v) == [0.0, 2.0, 0.0]
        @test v == [0.0, 2.0, 0.0]                             # original mutated
        w = [1.0, -1.0]
        @test clamp_neg!(w) === w                              # returns SAME object
    end

    @testset "E4 total (type stability)" begin
        @test total([1.0, 2.0, 3.0]) ≈ 6.0                     # correctness
        @test (@inferred total([1.0, 2.0, 3.0])) ≈ 6.0         # stability (fails until fixed)
        @test (@inferred total([1, 2, 3])) == 6                # stable for Ints too
    end

    @testset "E5 identity_like" begin
        @test identity_like(2) == [1.0 0.0; 0.0 1.0]
        @test size(identity_like(3)) == (3, 3)                 # held-out
        @test identity_like(3)[2, 2] == 1.0                    # held-out
        @test identity_like(3)[1, 3] == 0.0                    # held-out
    end

    @testset "E6 normalize_fast (correctness)" begin
        x = randn(1000)
        @test normalize_fast(x) ≈ normalize_slow(x)
    end
end


### ============================================================
### PART C — BOSS BENCHMARK  (run; report the numbers in chat)
### ============================================================
# Run this AFTER E6 passes. First call compiles, so we warm up, then measure.
let x = randn(100_000)
    normalize_slow(x); normalize_fast(x)            # warm up (compile)
    println("\n--- BOSS BENCHMARK ---")
    print("slow:  "); @time normalize_slow(x)
    print("fast:  "); @time normalize_fast(x)
    println("slow allocations (bytes): ", @allocated normalize_slow(x))
    println("fast allocations (bytes): ", @allocated normalize_fast(x))
    println("Report both lines in chat. fast should allocate far less and run faster.")
end


### ============================================================
### PART D — CONCEPT QUESTIONS  (answer in chat — I grade these)
### ============================================================
# C1. What is multiple dispatch, in your own words, and how does it differ
#     from Python's obj.method()? Give a one-line example where dispatching
#     on TWO argument types matters (E2 is a fine starting point).
#
# C2. Why does `s = 0` make the accumulator in E4 type-unstable when the
#     input is floats — and why does @inferred catch it? (Hint: what is the
#     return type if the collection is empty?)
#
# C3. `a[2:4]` vs `@view a[2:4]` — what's the difference, and describe a
#     situation where reaching for a copy instead of a view is a silent
#     performance bug.
#
# C4. What do Project.toml and Manifest.toml each record, and why commit both?
#
# C5. Why are explicit `for` loops not a performance problem in Julia the way
#     they are in pure Python / numpy?

println("\nM1 EXAM loaded. Make PART B green, run PART C, then bring PART C + PART D to chat.")
