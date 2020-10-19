"""
This module is for exploration of Julia, Documenter and other interesting concepts.
"""
module Learn
export add, ∑

"""
    add(x::Int64, y::Int64)

Returns x + y

# Examples

```jldoctest
julia> x, y = 1, 3; add(x, y)
4

julia> which_sig(add, x, y)
"add(x::Int64, y::Int64)"
```
"""
add(x::Int64, y::Int64) = x + y


"""
    add(x::T, y::T) where {T<:Number}

Returns x + y

# Examples

```jldoctest base
julia> x, y = 1+3im, 3+5im; add(x, y)
4 + 8im

julia> which_sig(add, x, y)
"add(x::T, y::T) where T<:Number"
```
"""
add(x::T, y::T) where {T<:Number} = x + y

"""
    add(x::T, y::T) where {T<:AbstractString}

Returns x*y

# Examples

```jldoctest base
julia> x, y = "my", "string"; add(x, y)
"mystring"

julia> which_sig(add, x, y)
"add(x::T, y::T) where T<:AbstractString"
```
"""
add(x::T, y::T) where {T<:AbstractString} = x*y

"""
    add(x, y)

Returns x + y

# Examples

```jldoctest base
julia> x, y = Vector([1,2,3]), Vector([4,5,6]); add(x, y)
3-element Array{Int64,1}:
 5
 7
 9

julia> which_sig(add, x, y)
"add(x, y)"
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
julia> ∑(1,2,3,4,5)
15
```
"""
∑(x::Int64...) = sum(x)

end
