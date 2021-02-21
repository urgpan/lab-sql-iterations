use sakila;

-- 1 Write a query to find what is the total business done by each store.
select sr.store_id, sum(py.amount) from store as sr
left join staff as sf
on sr.store_id = sf.store_id
left join payment as py
on sf.staff_id = py.staff_id
group by sr.store_id;


-- 2 Convert the previous query into a stored procedure.
drop procedure if exists question_two;

delimiter //
create procedure question_two ()
begin

	select sr.store_id, sum(py.amount) from store as sr
	left join staff as sf
	on sr.store_id = sf.store_id
	left join payment as py
	on sf.staff_id = py.staff_id
	group by sr.store_id;
  
end;
//
delimiter ;

call question_two();

-- 3 Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
drop procedure if exists question_two;

delimiter //
create procedure question_two (in inp1 int)
begin
	select sr.store_id, sum(py.amount) from store as sr
	left join staff as sf
	on sr.store_id = sf.store_id
	left join payment as py
	on sf.staff_id = py.staff_id
    where sr.store_id = inp1
	group by sr.store_id;
end;
//
delimiter ;
call question_two(2);

-- 4 Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.
drop procedure if exists question_two;

delimiter //
create procedure question_two (in inp1 int)
begin
	declare total_sales_value float default 0.0;

	select sr.store_id, sum(py.amount) as sumtot from store as sr
	left join staff as sf
	on sr.store_id = sf.store_id
	left join payment as py
	on sf.staff_id = py.staff_id
    where sr.store_id = inp1
	group by sr.store_id;
    
    set total_sales_value = sumtot;
end;
//
delimiter ;

call question_two(2);

-- 5 ...
drop procedure if exists question_five;

delimiter //
create procedure question_five (in inp1 int, out param1 float, out param2 varchar(20))
begin
	declare total_sales_value float default 0.0;
	declare flag varchar(20) default false;

	select sum(py.amount) into total_sales_value from store as sr
	left join staff as sf
	on sr.store_id = sf.store_id
	left join payment as py
	on sf.staff_id = py.staff_id
    where sr.store_id = inp1
	group by sr.store_id;

    
    if total_sales_value > 30000 then
		set flag = 'green_flag';
	else
		set flag = 'red_flag';
	end if;
    
    select total_sales_value into param1;
    select flag into param2;
    
end;
//
delimiter ;

call question_five(2, @oo, @uu);
select @oo,  @uu;