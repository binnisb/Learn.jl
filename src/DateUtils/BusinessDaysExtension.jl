using BusinessDays

struct SwedenCalendar <: HolidayCalendar end

BusinessDays.isholiday(::SwedenCalendar, dt::Dates.Date) = begin
    yy = Dates.year(dt)
    mm = Dates.month(dt)
    dd = Dates.day(dt)

    
end