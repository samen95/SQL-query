/*Select everything from sales table*/

select * from sales;

/*Select just a few columns from sales table*/

select SaleDate, Amount, Boxes from sales;
select Amount, SaleDate, GeoID from sales;

/*Adding a calculated column & Naming a field with AS*/
select SaleDate, Amount, Boxes, Amount/Boxes as 'Amount per box' from sales;

/*WHERE Clause*/
select * from sales
where amount < 1000;

/*Sales data where amount is greater than 10,000 by descending order*/
select * from sales
where amount < 1000
order by amount desc;

/*sales data where geography is g1 by product ID & descending order of amounts*/

select * from sales
where geoid='g1'
order by PID, Amount desc;

/*Working with dates*/
select * from sales
where Amount > 10000 AND SaleDate >= '2022-01-01';

/*Using year() function to select all data in a specific year*/
select SaleDate, Amount from sales
where Amount > 10000 AND year(SaleDate) = 2022
order by Amount desc;

/*BETWEEN condition in SQL with < & > operators*/
select * from sales
where Boxes > 0 and Boxes <= 50;

/*Using the between operator*/
select * from sales
where Boxes between 0 and 50;

/*Using weekday() function*/
select SaleDate, Amount, Boxes, weekday(SaleDate) AS 'Day of week' from sales
where weekday(SaleDate) = 4 ;

/*Working with People table*/
select * from people;


/*OR operator*/
select * from people
where team= 'Delish' or team = 'Jucies';

/*IN operator*/
select * from people
where team in ('Delish','Jucies' );

/*Like operator*/
select * from people
where Salesperson like '%b%' ;

/*Using CASE to create branching logic*/
select SaleDate, Amount ,
case when amount< 1000 then 'Under 1k'
			 when amount< 5000 then 'Under 5k'
             when amount< 10000 then 'Under 10k'
             else '10k or more'
		end as 'Amount Catagry'
from sales;

select * from sales;
select * from people;

/*JOIN */
select s.SPID , p.SPID, s.SaleDate , p.Salesperson, s.Amount
from sales s
join people p on p.SPID = s.SPID;

select s.SaleDate, s.Amount, pr.Product 
from sales s
left join products pr on pr.PID= s.PID;

select  s.SaleDate , p.Salesperson, s.Amount, pr.Product ,p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID= s.PID;

/*Adding condition with JOIN */

select  s.SaleDate , p.Salesperson, s.Amount, pr.Product ,p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID= s.PID
where s.Amount< 1000
and p.team= 'Delish';

select  s.SaleDate , p.Salesperson, s.Amount, pr.Product ,p.Team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID= s.PID
where s.Amount< 1000
and p.team= '';

select  s.SaleDate , p.Salesperson, s.Amount, pr.Product ,p.Team ,g.Geo
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID= s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount< 1000
and p.team= ''
and geo in ('India' ,'New Zealand') 
order by SaleDate;

/* Group BY and Creating Report */

select GeoID , sum(Amount) ,avg(Amount), sum(Boxes)
from sales
group by GeoID;

select g.Geo , sum(Amount) ,avg(Amount), sum(Boxes)
from sales s
join geo g on g.GeoID = s.GeoID
group by g.Geo;

select pr.Category ,p.Team ,sum(Amount) , sum(Boxes)
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID= s.PID
where p.Team <> ''
group by pr.Category ,p.Team
order by pr.Category ,p.Team;

/* Total Amount Top 10 Products */

select pr.Product , sum(s.Amount) as 'total amount'
from sales s
join products pr on pr.PID= s.PID
group by pr.Product
order by 'total amount' desc
limit 10;