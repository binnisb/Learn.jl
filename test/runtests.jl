using Learn
using Test

@testset "Learn.jl" begin
    # Write your tests here.
    @test true
    @test add(3,5) == 8
    @test add(1.1, 3.0) == 4.1
    @test add(1+5im, 4-2im) == 5+3im
    @test add(Vector([1,2,3]), Vector([4,5,6])) == Vector([5,7,9])
    @test add("asdf ", "fdsa") == "asdf fdsa"
    @test ∑(1,2,3,4,5) == 15
    @test ∑([1,2,3,4,5]) == 15

end
