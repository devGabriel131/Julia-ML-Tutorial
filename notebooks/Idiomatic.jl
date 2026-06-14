### A Pluto.jl notebook ###
# v1.0.1

using Markdown
using InteractiveUtils

# ╔═╡ 175b1224-6757-11f1-84d0-0bf82915498e
md" # Questions 1.1

```
1. Which key enters package mode and what command makes the current folder its own enviroment? 

The answer would be ']' and we use 'activate' to create a new enviroment.
```

```
2. Write a string that interpolates the expression inline.

$(3^2 + 1) -> 10 when in between quotes.
```
"


# ╔═╡ 9b96ff8a-b984-4710-b2ce-efac2ab05cfd
md" # Question 1.2

```
1. Is Int64 <: AbstractFloat? Why or why not?

This would be false, the abstract float is part of the interior node of the float tree, integers would spilt up at the Real node with its own branch.
```

```
2. What does eltype([1, 2, 3]) return, and what would eltype([1, 2.0]) return?

eltype means element type, it returns the type of a value or the type of values in an array. Yet it doesn't return the most pervailing type, but the most consequencial type in an array. Hence in the first example it would return Int64, but in the second it would return Float64 instead of Any or Int64
```
"

# ╔═╡ 1d467ac1-1d25-4bce-84c5-305b809570fa
Int64 <: AbstractFloat

# ╔═╡ 0a2d97e8-9a0a-4d3e-b047-ac69d442de62
Int64 <: Real

# ╔═╡ 93cba52d-d36a-4029-af73-05b8e1cdb9f5
eltype([1 2 3])

# ╔═╡ e147e759-6da2-451c-81cc-ebd6df699d9d
eltype([1 2.0])

# ╔═╡ a7730285-3a28-478d-9bf5-e1b7e79a9af4
md" # Question 1.3

```
1. Add a Triangle with a base and height. How many of the existing area methods must you change?

Just the create one new method, the code explains it.
```

```
2. Why can single-dispatch OOP only 'fake' a two-type operation like collide(a, b)?

By single dispatch this mean each particular type has its own methods and require the use of interfaces (Go) or intricate metamorphosing in OOP languages (Python).

Julia handles these methods in a type by type basis choosing the correct one if its made.
```
"

# ╔═╡ 868218dc-43af-4329-9372-a62aecbf05d2
begin
	struct Circle; r::Float64; end
	struct Rect;   w::Float64; h::Float64; end

	area(c::Circle) = π * c.r^2
	area(r::Rect)   = r.w * r.h

	area(Circle(2.0))   
end

# ╔═╡ eff12400-ce5b-4308-b04b-850ff410a031
begin # creating a triangle struct and its area function
	struct Triangle
		h::Float64
		b::Float64
	end

	area(t::Triangle) = (t.b * t.h)/2

	area(Triangle(10,5)) # multiple dispatch handles the methods for multiple types
end

# ╔═╡ 37affea7-8ab1-4ab4-b721-81c56d9fa10c
md" # Question 1.4

```
1. What does sort(v) do to v? What does sort!(v) do?

sort(v) returns a copy of the sorted v, while sort!(v) sorts v in place.

```
```
2. Rewrite bounds(a) = (minimum(a), maximum(a)) and destructure its result.

bounds(a) = (minimum!(a), maximum!(a)) -> easy but this is wrong. further clarification needed.
```
"

# ╔═╡ eb39dc78-ca77-4314-ba14-0e7f67d5d002
v = [3,6,8,95,3]

# ╔═╡ e37ef719-3102-476a-9f4c-75cde035e343
sort(v)

# ╔═╡ f80b3e43-831a-468c-ba63-fce1500c0a17
v

# ╔═╡ 9d42335c-eabf-4e38-9c89-4b03192544d9
md" As we can see, sort does not change the value of v

until we run the cell below and then the value of v will mutate.
"

# ╔═╡ 6fefa0f7-38dc-4fee-a446-e2e7cef95f72
sort!(v) # this mutates v

# ╔═╡ e1480f39-d9e9-4e92-aeab-2b8cf02b159d
minimum(v)

# ╔═╡ d14b9b72-95fe-4309-a061-dd1ed14c43f0
md" # Question 1.5
```
1. For a hot double loop over a matrix, which index belongs in the inner loop in Julia, and why?

The inner loop should be the row because Julia is column mayor and to be efficient with the cache the outer loop must be the columns.
```

```
2. What does [i^2 for i in 1:5] evaluate to?

This is list comprehension and it evaluates to [1,4,9,16,25]
```
"

# ╔═╡ 2aa76b76-cbb1-476d-8dd1-082f8f118d90
A = [1 2 3; 4 5 6] # m = 2, n = 3 | m*n = 2*3

# ╔═╡ d092c6af-febe-415b-ad04-15c976da5b0a
A[1,2] # this index of a matrix says first row, second column

# ╔═╡ 0a35964f-8ac7-4e32-97be-b3abc4af04b4
A[:, 1] # this says slice the first column

# ╔═╡ f1696741-c0b8-45cc-bc47-f20a406c494e
A[1,:] # slicing a row returns an array of the row as well

# ╔═╡ 8584dd4e-79aa-4377-93fd-71db3bcbb186
md" ## Important information about Julia

Julia stores matrices in what is called a column mayor order, meaning that the above matrix in memory would look like [1 4 2 5 3 6]. 

You can calculate the offset with the following formula.

```
offset(i,j) = (i - 1) + (j - 1)m
```

Meaning that if you want to iterate through contiguos memory, you the columns, not rows.
"

# ╔═╡ 1ae26e78-25de-4dd3-b630-f8ca2298711b
[i^2 for i in 1:5]

# ╔═╡ baba7e12-ea3e-4921-b79a-867d444b6544
md" # Question 1.6
```
1. What does the @. macro do to every operator in an expression?

It allows every operation to be broadcasted accross a fucntion. It also is just faster and uses less memory.
```

```
2. Why is the fused version faster than computing it as two separate steps?

It allocates less memory and fuses all operations inside just one loop.
```
"

# ╔═╡ d2f01d46-f66e-419d-9504-fa5ef338f545
md" # Question 1.7
```
1. After w = v[2:4]; w[1] = 0, is v changed? What about with @view?

v is not changed, w would just be a copy of the slice. What @view does is share the the memory of the slice taken with the original value, so a change in w with @view would change v.
```
```
2. When is @view the right call rather than a copy?

When you don't need a copy being allocated. example you are in a loop with a large array and you only want to work on one specific section.
```

"

# ╔═╡ e4dc5cd2-d5ab-415d-a6d0-c6adb1fdcfc7
md" ---
sidenote earlier i did this"

# ╔═╡ b82b6f17-2cce-41e4-bfa7-000e1777b1a4
[i for i in 1:5] # to create a list from a range

# ╔═╡ 3e0a263f-729d-4801-80fc-16da03970e46
collect(1:5) # I can also use the collect function

# ╔═╡ b61a6500-d43b-4447-93bb-45c26f0f8c56
md"---"

# ╔═╡ bba77337-9c1e-418a-9232-2de16cc682d2


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─175b1224-6757-11f1-84d0-0bf82915498e
# ╟─9b96ff8a-b984-4710-b2ce-efac2ab05cfd
# ╠═1d467ac1-1d25-4bce-84c5-305b809570fa
# ╠═0a2d97e8-9a0a-4d3e-b047-ac69d442de62
# ╠═93cba52d-d36a-4029-af73-05b8e1cdb9f5
# ╠═e147e759-6da2-451c-81cc-ebd6df699d9d
# ╟─a7730285-3a28-478d-9bf5-e1b7e79a9af4
# ╠═868218dc-43af-4329-9372-a62aecbf05d2
# ╠═eff12400-ce5b-4308-b04b-850ff410a031
# ╟─37affea7-8ab1-4ab4-b721-81c56d9fa10c
# ╠═eb39dc78-ca77-4314-ba14-0e7f67d5d002
# ╠═e37ef719-3102-476a-9f4c-75cde035e343
# ╠═f80b3e43-831a-468c-ba63-fce1500c0a17
# ╟─9d42335c-eabf-4e38-9c89-4b03192544d9
# ╠═6fefa0f7-38dc-4fee-a446-e2e7cef95f72
# ╠═e1480f39-d9e9-4e92-aeab-2b8cf02b159d
# ╟─d14b9b72-95fe-4309-a061-dd1ed14c43f0
# ╠═2aa76b76-cbb1-476d-8dd1-082f8f118d90
# ╠═d092c6af-febe-415b-ad04-15c976da5b0a
# ╠═0a35964f-8ac7-4e32-97be-b3abc4af04b4
# ╠═f1696741-c0b8-45cc-bc47-f20a406c494e
# ╟─8584dd4e-79aa-4377-93fd-71db3bcbb186
# ╠═1ae26e78-25de-4dd3-b630-f8ca2298711b
# ╟─baba7e12-ea3e-4921-b79a-867d444b6544
# ╟─d2f01d46-f66e-419d-9504-fa5ef338f545
# ╟─e4dc5cd2-d5ab-415d-a6d0-c6adb1fdcfc7
# ╠═b82b6f17-2cce-41e4-bfa7-000e1777b1a4
# ╠═3e0a263f-729d-4801-80fc-16da03970e46
# ╟─b61a6500-d43b-4447-93bb-45c26f0f8c56
# ╠═bba77337-9c1e-418a-9232-2de16cc682d2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
