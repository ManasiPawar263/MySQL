# DML

# Insert query
insert into personal_info(id,emp_name,age)
values(1,'sam',21),
(2,'om',23),
(3,'daisy',22),
(4,'lily',20);

# Update query
update personal_info set emp_name='john'
where id=1;

# Delete query
delete from personal_info
where id = 1;

