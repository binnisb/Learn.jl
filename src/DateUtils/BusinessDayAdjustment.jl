using Dates
using BusinessDays

export BusinessDayAdjustment, NoAdjustment, Following, Preceding
export ModifiedFollowing, ModifiedPreceding
export EOMNoAdjustment, EOMPreceding,EOMFollowing

abstract type BusinessDayAdjustment end
abstract type NoAdjustment <: BusinessDayAdjustment end
abstract type Following <: BusinessDayAdjustment end
abstract type ModifiedFollowing <: BusinessDayAdjustment end
abstract type Preceding <: BusinessDayAdjustment end
abstract type ModifiedPreceding <: BusinessDayAdjustment end
abstract type EOMNoAdjustment <: BusinessDayAdjustment end
abstract type EOMPreceding <: BusinessDayAdjustment end
abstract type EOMFollowing <: BusinessDayAdjustment end

BusinessDays.tobday(hc::HolidayCalendar, dt::Date, ::Type{NoAdjustment}) = dt
BusinessDays.tobday(hc::HolidayCalendar, dt::Date, ::Type{Following}) = tobday(hc, dt; forward=true)
BusinessDays.tobday(hc::HolidayCalendar, dt::Date, ::Type{Preceding}) = tobday(hc, dt; forward=false)
BusinessDays.tobday(hc::HolidayCalendar, df::Date, ::Type{EOMNoAdjustment}) = Dates.lastdayofmonth(dt)
BusinessDays.tobday(hc::HolidayCalendar, df::Date, ::Type{EOMPreceding}) = tobday(hc, Dates.lastdayofmonth(dt), Preceding)
BusinessDays.tobday(hc::HolidayCalendar, df::Date, ::Type{EOMFollowing}) = tobday(hc, Dates.lastdayofmonth(dt), Following)

BusinessDays.tobday(hc::HolidayCalendar, dt::Date, ::Type{ModifiedFollowing}) = begin
    day_adj = tobday(hc, dt, Following)
    if month(day_adj) ≠ month(dt)
        day_adj = tobday(hc, dt, Preceding)
    end
    day_adj
end
BusinessDays.tobday(hc::HolidayCalendar, dt::Date, ::Type{ModifiedPreceding}) = begin 
    day_adj = tobday(hc, dt, Preceding)
    if month(day_adj) ≠ month(dt)
        day_adj = tobday(hc, dt, Following)
    end
    day_adj

end