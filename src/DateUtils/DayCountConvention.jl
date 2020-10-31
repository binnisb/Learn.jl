module DayCountConvention
using Dates
export AbstractDayCountConvention
export Date
export DayCount30_360, DayCount30A_360, DayCount30E_360, DayCount30E_360ISDA

export DayCount

abstract type AbstractDayCountConvention end

abstract type DayCount30_360 <: AbstractDayCountConvention end
abstract type  DayCount30A_360 <: DayCount30_360 end
abstract type  DayCount30E_360 <: DayCount30_360 end
abstract type  DayCount30E_360ISDA <: DayCount30_360 end

struct DayCount{T <: AbstractDayCountConvention}
    startDate::Date
    endDate::Date
    terminationDate::Date
    days::Int
    daysFraction::Float64
end

function DayCount{T}(startDate::Date, endDate::Date,terminationDate::Date) where T <: DayCount30_360
    dayCount = daysCount(startDate, endDate, terminationDate, T)
    daysFraction = dayCount / 360.0
    DayCount{T}(startDate, endDate, terminationDate, dayCount, daysFraction)
end

function daysCount(startDate::Date, endDate:: Date, terminationDate::Date, ::Type{T}) where T <: DayCount30A_360
    d1 = day(startDate) ≤ 30 ? day(startDate) : 30
    d2 = d1 ≠ 30 ? day(endDate) : min(day(endDate),30)
    daysFormula(year(startDate), year(endDate), month(startDate), month(endDate), d1, d2)
end

function daysCount(startDate::Date, endDate:: Date, terminationDate::Date, ::Type{T}) where T <: DayCount30E_360
    d1 = day(startDate) ≤ 30 ? day(startDate) : 30
    d2 = day(endDate) ≤ 30 ? day(endDate) : 30
    daysFormula(year(startDate), year(endDate), month(startDate), month(endDate), d1, d2)
end

function daysCount(startDate::Date, endDate:: Date, terminationDate::Date, ::Type{T}) where T <: DayCount30E_360ISDA
    d1 = startDate == Dates.lastdayofmonth(startDate) ? 30 : day(startDate)
    d2 = if endDate == Dates.lastdayofmonth(endDate) && !(month(endDate) == 2 && endDate == terminationDate)
        30
    else
        day(endDate)
    end
    daysFormula(year(startDate), year(endDate), month(startDate), month(endDate), d1, d2)
end

function daysFormula(y1::Int, y2::Int, m1::Int, m2::Int, d1::Int, d2::Int)::Int
    360(y2-y1) + 30(m2-m1) + (d2-d1)
end
end