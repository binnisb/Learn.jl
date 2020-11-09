using BusinessDays
export SwedenCalendar

struct SwedenCalendar <: HolidayCalendar end

BusinessDays.isholiday(::SwedenCalendar, dt::Date)::Bool = begin
    yy = year(dt)
    if dt == Date(yy, January, 1) return true end  # Nyårsdagen
    if dt == Date(yy, January, 6) return true end  # Trettondedag jul
    if dt == Date(yy, December, 24) return true end  # Julafton
    if dt == Date(yy, December, 25) return true end  # Juldagen
    if dt == Date(yy, December, 26) return true end  # Annandag jul
    if dt == Date(yy, December, 31) return true end  # Nyårsafton

    if yy ≥ 1939 && dt == Date(yy, May, 1) return true end  # Första maj
    if yy ≥ 2005 && dt == Date(yy, June, 6) return true end  # Sveriges nationaldag

    easter_sunday = BusinessDays.easter_date(Year(yy))
    good_friday = easter_sunday - Day(2)
    easter_monday = easter_sunday + Day(1)
    ascension_day = easter_sunday + Day(39)
    pentecost = easter_sunday + Day(49)
    pentecost_day_two = easter_sunday + Day(50)

    @assert Dates.isfriday(good_friday)
    @assert Dates.issunday(easter_sunday)
    @assert Dates.ismonday(easter_monday)
    @assert Dates.isthursday(ascension_day)
    @assert Dates.issunday(pentecost)
    @assert Dates.ismonday(pentecost_day_two)

    midsummer_eve = Dates.tonext(Date(yy, June, 19), Friday)
    midsummer_day = midsummer_eve + Day(1)
    all_saints_day = Dates.tonext(Date(yy, October, 31), Saturday)

    @assert Dates.isfriday(midsummer_eve)
    @assert Dates.issaturday(midsummer_day)
    @assert Dates.issaturday(all_saints_day)

    if dt == good_friday return true end  # Långfredagen
    if dt == easter_sunday return true end  # Påskdagen
    if dt == easter_monday return true end  # Annandag påsk
    if dt == ascension_day return true end  # Kristi himmelsfärdsdag
    if dt == pentecost return true end  # Pingstdagen
    if yy ≤ 2004 && dt == pentecost_day_two return true end  # Annandag pingst
    if dt == midsummer_eve return true end  # Midsommarafton
    if yy ≥ 1953 && dt == midsummer_day return true end  # Midsommardagen
    if yy < 1953 && dt == Date(yy, June, 24) return true end  # Midsommardagen
    if dt == all_saints_day return true end  # Alla helgons dag
    if yy ≤ 1953 && dt == Date(yy, March, 25) return true end  # Jungfru Marie bebådelsedag
    return false
end
