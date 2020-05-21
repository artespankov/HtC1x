fun is_older(d1: (int * int * int), d2: (int * int * int)) =
let 
    val year1 = #1 d1;
    val year2 = #1 d2;
    val month1 = #2 d1;
    val month2 = #2 d2;
    val day1 = #3 d1;
    val day2 = #3 d2;
in 
    if year1 < year2
    then true
    else
	if year1 = year2
	then
	    if month1 < month2
	    then true
	    else
		if month1 = month2
		then
		    if day1 < day2
		    then true
		    else false
		else false
	else false
end;


fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else
	if #2(hd dates) = month
	then 1 + number_in_month(tl dates, month)
	else number_in_month(tl dates, month);


fun number_in_months(dates: (int * int * int) list, months:int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months);


fun dates_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else
	if #2(hd dates) = month
	then hd dates::dates_in_month(tl dates, month)
	else dates_in_month(tl dates, month);


fun dates_in_months(dt: (int * int * int) list, months:int list) = 
    if null months
    then []
    else dates_in_month(dt, hd months) @ dates_in_months(dt, tl months);


fun get_nth(strings: string list, index: int) =
    if index < 1 orelse null strings
    then ""
    else
	if index = 1
	then hd strings
	else get_nth(tl strings, index - 1);


fun date_to_string(date: (int * int * int)) =
    let
	val months = [ "January", "February", "March", "April",
		       "May", "June", "July", "August", "September",
		       "October", "November", "December"]
    in
	get_nth(months, #2 date) ^ " " ^
	Int.toString(#3 date) ^ ", " ^
	Int.toString(#1 date)
    end; 


fun number_before_reaching_sum(sum: int, numbers: int list) =
    if sum - hd numbers > 0
    then
	if sum - hd numbers > hd (tl numbers)
	then 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)
	else 1
    else 0;


fun what_month(doy: int) =
    let
	val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(doy, days_in_months)+1
    end;


fun month_range(fd: int, sd: int) =
    if fd > sd
    then []
    else what_month(fd):: month_range(fd+1, sd);


fun oldest(dates: (int * int * int) list) =
    if null dates
    then NONE
    else
	if null (tl dates)
	then SOME(hd dates)
	else
	    if is_older(hd dates, hd(tl dates))
	    then oldest(hd dates::tl(tl dates))
	    else oldest(tl dates);
