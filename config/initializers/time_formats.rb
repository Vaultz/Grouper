
#call time.to_s(:school_year) to get the school year ( the previous year if before august of the current year )
Time::DATE_FORMATS[:school_year] = lambda { |time| time.strftime('%m').to_i < 8 ? time.strftime('%Y').to_i - 1 : '%Y' }
# < 8 ? "%Y".to_i - 1  : "%Y".to_i + 1
