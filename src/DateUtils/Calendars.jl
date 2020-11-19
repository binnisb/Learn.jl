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

    # Fixed dates for specific years
    if dt == Date(yy, May, 1) && yy ≥ 1939 return true end  # Första maj
    if dt == Date(yy, June, 6) && yy ≥ 2005 return true end  # Sveriges nationaldag
    if dt == Date(yy, March, 25) && yy ≤ 1953 return true end  # Jungfru Marie bebådelsedag
    if dt == Date(yy, June, 24) && yy < 1953 return true end  # Midsommardagen

    # Variable dates
    easter_sunday = BusinessDays.easter_date(Year(yy))
    good_friday = easter_sunday - Day(2)
    easter_monday = easter_sunday + Day(1)
    ascension_day = easter_sunday + Day(39)
    pentecost = easter_sunday + Day(49)
    pentecost_day_two = easter_sunday + Day(50)

    midsummer_eve = Dates.tonext(Date(yy, June, 19), Friday; same=true)
    midsummer_day = midsummer_eve + Day(1)
    all_saints_day = Dates.tonext(Date(yy, October, 31), Saturday; same=true)

    if dt == good_friday return true end  # Långfredagen
    if dt == easter_sunday return true end  # Påskdagen
    if dt == easter_monday return true end  # Annandag påsk
    if dt == ascension_day return true end  # Kristi himmelsfärdsdag
    if dt == pentecost return true end  # Pingstdagen
    if dt == midsummer_eve return true end  # Midsommarafton
    if dt == all_saints_day return true end  # Alla helgons dag

    # Variable dates for years
    if dt == pentecost_day_two && yy ≤ 2004 return true end  # Annandag pingst
    if dt == midsummer_day && yy ≥ 1953 return true end  # Midsommardagen

    
    return false
end
