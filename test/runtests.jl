using Learn
using Test

@testset "Learn.jl" begin
    # Write your tests here.
    @testset "Add" begin
        @test true
        @test Learn.add(3,5) == 8
        @test Learn.add(1.1, 3.0) == 4.1
        @test Learn.add(1+5im, 4-2im) == 5+3im
        @test Learn.add(Vector([1,2,3]), Vector([4,5,6])) == Vector([5,7,9])
        @test Learn.add("asdf ", "fdsa") == "asdf fdsa"
    end
    @testset "Sum" begin
        @test Learn.∑(1,2,3,4,5) == 15
        @test Learn.∑([1,2,3,4,5]) == 15
    end

    include("testDayCounts.jl")
    include("testHolidays.jl")
end
