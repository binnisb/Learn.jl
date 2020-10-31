"""
This module is for exploration of Julia, Documenter and other interesting concepts.
"""
module Learn
export add, ∑

include("DateUtils/DayCountConvention.jl")

"""
    add(x::Int64, y::Int64)

Returns x + y

# Examples

```jldoctest
julia> x, y = 1, 3; add(x, y)
4

julia> @assert "add(x::Int64, y::Int64)" == which_sig(add, x, y)
```
"""
add(x::Int64, y::Int64) = x + y


"""
    add(x::T, y::T) where {T<:Number}

Returns x + y

# Examples

```jldoctest
julia> x, y = 1+3im, 3+5im; add(x, y)
4 + 8im

julia> @assert "add(x::T, y::T) where T<:Number" == which_sig(add, x, y)
```
"""
add(x::T, y::T) where {T<:Number} = x + y

"""
    add(x::T, y::T) where {T<:AbstractString}

Returns x*y

# Examples

```jldoctest
julia> x, y = "my", "string"; add(x, y)
"mystring"

julia> @assert "add(x::T, y::T) where T<:AbstractString" == which_sig(add, x, y)
```
"""
add(x::T, y::T) where {T<:AbstractString} = x*y

"""
    add(x, y)

Returns x + y

# Examples

```jldoctest
julia> x, y = Vector([1,2,3]), Vector([4,5,6]); add(x, y)
3-element Array{Int64,1}:
 5
 7
 9

julia> @assert "add(x, y)" == which_sig(add, x, y)
```
"""
add(x,y) = x + y


@doc raw"""
    ∑(x::Int64...)
Adds all parameters:

```math
\sum_i^n x_1, x_2, \dots x_n \forall x_k \in \mathbb{N}
```
# Examples

```jldoctest
julia> x1, x2, x3, x4, x5 = 1:5; ∑(x1,x2,x3,x4,x5)
15

julia> @assert "∑(x::Int64...)" == which_sig(∑, x1, x2, x3, x4, x5)
```
"""
∑(x::Int64...) = sum(x)

@doc raw"""
    ∑(x::Int64[])
Adds all parameters:

# Examples

```jldoctest
julia> x = Vector(1:5); ∑(x)
15

julia> @assert "∑(x::AbstractArray{Int64,1})" == which_sig(∑, x)

```
"""
∑(x::AbstractArray{Int64,1}) = ∑(x...)


end
