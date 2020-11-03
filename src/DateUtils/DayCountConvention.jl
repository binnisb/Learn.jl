module DayCountConvention
using Dates
export Date

export days, yearfraction

export AbstractDayCountConvention

export DayCount30_360, DayCountAct,  DayCountAct_Act

export DayCount30A_360, DayCount30E_360, DayCount30E_360ISDA
export DayCountAct_360, DayCountAct_364, DayCountAct_365Fixed, DayCountAct_365Actual, DayCountAct_365Long, DayCountAct_365_25
export DayCountAct_ActISDA


abstract type AbstractDayCountConvention end

abstract type DayCount30_360 <: AbstractDayCountConvention end
abstract type DayCountAct <: AbstractDayCountConvention end
abstract type DayCountAct_Act <: AbstractDayCountConvention end

abstract type DayCount30A_360 <: DayCount30_360 end
abstract type DayCount30E_360 <: DayCount30_360 end
abstract type DayCount30E_360ISDA <: DayCount30_360 end

abstract type DayCountAct_360 <: DayCountAct end
abstract type DayCountAct_364 <: DayCountAct end
abstract type DayCountAct_365Fixed <: DayCountAct end
abstract type DayCountAct_365_25 <: DayCountAct end
abstract type DayCountAct_365Actual <: DayCountAct end
abstract type DayCountAct_365Long <: DayCountAct end

abstract type DayCountAct_ActISDA <: DayCountAct_Act end


@inline daysFormula(y1::Int, y2::Int, m1::Int, m2::Int, d1::Int, d2::Int)::Int = 360(y2-y1) + 30(m2-m1) + (d2-d1)
function days(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCount30A_360
    d1 = min(day(startDate), 30)
    de = day(endDate)
    d2 = if d1 == 30
        min(de, 30)
    else
        de
    end
    daysFormula(year(startDate), year(endDate), month(startDate), month(endDate), d1, d2)
end
function days(startDate::Date, endDate::Date, ::Type{T})::Int where T <: DayCount30E_360 
    daysFormula(
        year(startDate), year(endDate), month(startDate), month(endDate),
        min(day(startDate), 30), min(day(endDate), 30)
        )
end
function days(startDate::Date, endDate::Date, terminationDate::Date, ::Type{T})::Int where T <: DayCount30E_360ISDA
    d1 = if startDate == Dates.lastdayofmonth(startDate)
        30
    else
        day(startDate)
    end

    d2 = if endDate == Dates.lastdayofmonth(endDate) && !(month(endDate) == 2 && endDate == terminationDate)
        30
    else
        day(endDate)
    end
    daysFormula(year(startDate), year(endDate), month(startDate), month(endDate), d1, d2)
end
yearfraction(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCount30_360 = 
    days(startDate, endDate, T) / 360.0
yearfraction(startDate::Date, endDate::Date, terminationDate::Date, ::Type{T}) where T <: DayCount30_360 = 
    days(startDate, endDate, terminationDate, T) / 360.0

days(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCountAct = 
    (endDate - startDate).value
yearfraction(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCountAct_360 = 
    days(startDate, endDate, T) / 360.0
yearfraction(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCountAct_364 = 
    days(startDate, endDate, T) / 364.0
yearfraction(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCountAct_365Fixed = 
    days(startDate, endDate, T) / 365.0
function yearfraction(startDate::Date, endDate::Date, ::Type{T}) where T <: DayCountAct_365Actual
    d = days(startDate, endDate, T)
    for y ∈ year(startDate):year(endDate)
        if Dates.isleapyear(y) && startDate < Date(y,2,29) ≤ endDate
            return d / 366.0
        end
    end
    d / 365.0
end

end