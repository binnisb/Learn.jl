module Learn

export add

"""
    add(x::Int64, y::Int64) -> Int64

Returns x + y
"""
add(x::Int64, y::Int64) = x + y


"""
    add(x::T, y::T) -> T

Returns x + y

# Examples

```jldoctest
julia> add(1+3im,3+5im)
5 + 8im
```
"""
add(x::T, y::T) where {T<:Number} = x + y


"""
    add(x, y)

Returns x + y
"""
add(x,y) = x + y
end
