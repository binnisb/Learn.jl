using Learn.DayCountConvention
using Dates: Year

toDate(dstr::String)::Date = Date(dstr, "mm/dd/yy") + Year(2000)

@testset "DayCounts" begin
    # Same dates for all test cases. Function for same processing of all 30/360 conventions
    function test30360(daysResults, daysFracResults, dayCountType::Type{T}) where T <: DayCount30_360
        # Test dates and values from https://www.isda.org/2008/12/22/30-360-day-count-conventions/ , https://www.isda.org/a/mIJEE/30-360-2006ISDADefs.xls
        startDates = map(toDate, ["01/15/07", "01/15/07", "01/15/07", "09/30/07", "09/30/07", "09/30/07", "01/15/07", "01/31/07", "02/28/07", "08/31/06", "02/28/07", "02/14/07", "02/26/07", "02/29/08", "02/29/08", "02/29/08", "02/28/07", "10/31/07", "08/31/07", "02/29/08", "08/31/08", "02/28/09"])
        endDates   = map(toDate, ["01/30/07", "02/15/07", "07/15/07", "03/31/08", "10/31/07", "09/30/08", "01/31/07", "02/28/07", "03/31/07", "02/28/07", "08/31/07", "02/28/07", "02/29/08", "02/28/09", "03/30/08", "03/31/08", "03/05/07", "11/28/07", "02/29/08", "08/31/08", "02/28/09", "08/31/09"])
        terminationDate = toDate("02/28/09")

        for (sDate, eDate, days, dayFrac) in zip(startDates, endDates, daysResults, daysFracResults)
            dc = DayCount{T}(sDate, eDate, terminationDate)
            @test dc.daysFraction ≈ dayFrac atol=0.0001
            @test dc.days == days
        
        end
    end

    @testset "30/360 Bond Basis, 30A/360" begin
        # Test cases from https://www.isda.org/a/mIJEE/30-360-2006ISDADefs.xls
        testType = DayCount30A_360
        daysResults = [15,30,180,180,30,360,16,28,33,178,183,14,363,359,31,32,7,28,179,182,178,183]
        daysFracResults = [0.0417,0.0833,0.5000,0.5000,0.0833,1.0000,0.0444,0.0778,0.0917,0.4944,0.5083,0.0389,1.0083,0.9972,0.0861,0.0889,0.0194,0.0778,0.4972,0.5056,0.4944,0.5083]
        test30360(daysResults, daysFracResults, testType)
    end

    @testset "30E/360, 30/360 ICMA, 30/360 ISMA, 30S/360, Eurobond basis (ISDA 2006), Special German" begin
        # Test cases from https://www.isda.org/a/mIJEE/30-360-2006ISDADefs.xls
        testType = DayCount30E_360
        daysResults = [15, 30, 180, 180, 30, 360, 15, 28, 32, 178, 182, 14, 363, 359, 31, 31, 7, 28, 179, 181, 178, 182]
        daysFracResults = [0.0417, 0.0833, 0.5000, 0.5000, 0.0833, 1.0000, 0.0417, 0.0778, 0.0889, 0.4944, 0.5056, 0.0389, 1.0083, 0.9972, 0.0861, 0.0861, 0.0194, 0.0778, 0.4972, 0.5028, 0.4944, 0.5056]
        test30360(daysResults, daysFracResults, testType)
    end

    @testset "30E/360ISDA, Eurobond basis (ISDA 2000), German" begin
        # Test cases from https://www.isda.org/a/mIJEE/30-360-2006ISDADefs.xls
        testType = DayCount30E_360ISDA
        daysResults = [15, 30, 180, 180, 30, 360, 15, 30, 30, 180, 180, 16, 364, 358, 30, 30, 5, 28, 180, 180, 178, 180]
        daysFracResults = [0.0417, 0.0833, 0.5000, 0.5000, 0.0833, 1.0000, 0.0417, 0.0833, 0.0833, 0.5000, 0.5000, 0.0444, 1.0111, 0.9944, 0.0833, 0.0833, 0.0139, 0.0778, 0.5000, 0.5000, 0.4944, 0.5000]
        test30360(daysResults, daysFracResults, testType)
    end
end