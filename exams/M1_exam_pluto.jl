### A Pluto.jl notebook ###
# v1.0.1

using Markdown
using InteractiveUtils

# ╔═╡ a0000000-0000-4000-8000-000000000008
using Test

# ╔═╡ a0000000-0000-4000-8000-000000000000
md"""
# Module 01 EXAM — Idiomatic Julia · *Pluto edition*

**How to take it (in Pluto, no VSCode needed):**
1. Each Part A cell holds your answer. Edit the cell, press **Shift+Enter** to run.
2. The **Part B** cell (the `@testset`) re-runs automatically every time you fix an answer — green summary = passing, a red error lists what still fails.
3. Run the **Part C** cell, read the printed `@time` / allocation numbers.
4. Paste your **Part C numbers + Part D answers** into chat. I grade Part C/D and log the score. Pass = **80%**.

> Your current answers are pre-filled. From the last review, **three cells still need fixing: E1, E2, E3.** E4/E5/E6 already pass.

*Pluto note:* the three `mash` methods live together in **one** `begin…end` cell — Pluto won't let the same name be defined in two cells.
"""

# ╔═╡ a0000000-0000-4000-8000-00000000000a
md"""### PART A — your answers"""

# ╔═╡ a0000000-0000-4000-8000-000000000001
# E1 · Broadcasting. Min-max scale a vector to [0, 1] with NO loop.
#      FIX: the denominator must be the whole range, parenthesized:
#      (maximum(v) - minimum(v)).
rescale(v) = (v .- minimum(v)) ./ (maximum(v) .- minimum(v))

# ╔═╡ a0000000-0000-4000-8000-000000000002
# E2 · Multiple dispatch — three methods of `mash`, all in ONE begin/end cell.
#      FIX: mash(Int, String) should repeat the STRING n times → b^a (not a^b).
begin
    mash(a::Int, b::Int)       = a + b
    mash(a::String, b::String) = a * b
    mash(a::Int, b::String)    = b^a
end

# ╔═╡ a0000000-0000-4000-8000-000000000003
# E3 · The ! convention + mutation. Set negatives to 0 IN PLACE, return same v.
#      FIX: iterate INDICES, not values → `for i in eachindex(v)`.
function clamp_neg!(v)
    for i in eachindex(v)
        if v[i] < 0
            v[i] = zero(eltype(v))
        end
    end
    return
end

# ╔═╡ a0000000-0000-4000-8000-000000000004
# E4 · Type stability. ✅ already correct.
function total(v)
    s = zero(eltype(v))
    for x in v
        s += x
    end
    return s
end

# ╔═╡ a0000000-0000-4000-8000-000000000005
# E5 · n×n identity via 2-D comprehension. ✅ passes (==​ is value-equal across
#      numeric types). To match the Float64 spec exactly you could write
#      `Float64(i == j)` instead of `1 : 0`.
identity_like(n) = [isequal(i, j) ? 1 : 0 for i in 1:n, j in 1:n]

# ╔═╡ a0000000-0000-4000-8000-000000000006
# E6 · BOSS — provided slow version (do not edit).
function normalize_slow(v)
    m = sum(v) / length(v)
    centered = [x - m for x in v]
    s = sqrt(sum([c^2 for c in centered]) / length(v))
    return [c / s for c in centered]
end

# ╔═╡ a0000000-0000-4000-8000-000000000007
function normalize_fast(v)
    n = length(v)
    μ = sum(v) / n
    σ = sqrt(sum(x -> abs2(x - μ), v) / n)
    return (v .- μ) ./ σ
end

# ╔═╡ a0000000-0000-4000-8000-00000000000b
md"""### PART B — autograder *(re-runs reactively; don't edit)*"""

# ╔═╡ a0000000-0000-4000-8000-000000000009
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
        @test (@inferred total([1.0, 2.0, 3.0])) ≈ 6.0         # stability
        @test (@inferred total([1, 2, 3])) == 6               # stable for Ints too
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

# ╔═╡ a0000000-0000-4000-8000-00000000000c
md"""### PART C — boss benchmark *(run, then report the printed numbers in chat)*"""

# ╔═╡ a0000000-0000-4000-8000-00000000000d
let x = randn(100_000)
    normalize_slow(x); normalize_fast(x)            # warm up (compile)
    println("\n--- BOSS BENCHMARK ---")
    print("slow:  "); @time normalize_slow(x)
    print("fast:  "); @time normalize_fast(x)
    println("slow allocations (bytes): ", @allocated normalize_slow(x))
    println("fast allocations (bytes): ", @allocated normalize_fast(x))
end

# ╔═╡ a0000000-0000-4000-8000-00000000000e
md"""
### PART D — concept questions *(answer in chat — I grade these)*

**C1.** What is multiple dispatch, in your own words, and how does it differ from Python's `obj.method()`? Give a one-line example where dispatching on **two** argument types matters (E2 is fine).

**C2.** Why does `s = 0` make the accumulator in E4 type-unstable for float input — and why does `@inferred` catch it? *(Hint: what is the return type if the collection is empty?)*

**C3.** `a[2:4]` vs `@view a[2:4]` — what's the difference, and describe a situation where reaching for a copy instead of a view is a silent performance bug.

**C4.** What do `Project.toml` and `Manifest.toml` each record, and why commit both?

**C5.** Why are explicit `for` loops not a performance problem in Julia the way they are in pure Python / numpy?
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "fd2f23712efe5b56b1141f9429379feae2744d8d"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╟─a0000000-0000-4000-8000-000000000000
# ╟─a0000000-0000-4000-8000-00000000000a
# ╠═a0000000-0000-4000-8000-000000000001
# ╠═a0000000-0000-4000-8000-000000000002
# ╠═a0000000-0000-4000-8000-000000000003
# ╠═a0000000-0000-4000-8000-000000000004
# ╠═a0000000-0000-4000-8000-000000000005
# ╠═a0000000-0000-4000-8000-000000000006
# ╠═a0000000-0000-4000-8000-000000000007
# ╟─a0000000-0000-4000-8000-00000000000b
# ╠═a0000000-0000-4000-8000-000000000008
# ╠═a0000000-0000-4000-8000-000000000009
# ╟─a0000000-0000-4000-8000-00000000000c
# ╠═a0000000-0000-4000-8000-00000000000d
# ╟─a0000000-0000-4000-8000-00000000000e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
