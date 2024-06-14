/* СКРИПТ ДЛЯ БЫСТРОГО СОЗДАНИЯ ТАБЛИЧНЫХ ПЕРЕМЕННЫХ ИЗ ВРЕМЕННЫХ ТАБЛИЦ С ПРЕФИКСАМИ "#" И "##" */
--1. Загрузить результаты запроса в табличную переменную #t, добавив в работающем запросе "into #t" перед оператором from 
--2. Выбрать и прописать имя желаемой табличной переменной @tablename: по умолчанию "@tVariable"
--3. Запустить данный скрипт и вставить его результаты перед запросом, результаты которого надо по выполнении загрузить в табличную переменную


/* --ОБРАЗЕЦ ИСПОЛЬЗОВАНИЯ ДЛЯ СОЗДАНИЯ ТАБЛИЧНОЙ ПЕРЕМЕННОЙ

drop table if exists #t  --удаление существующей временной таблицы #t, если она уже существует
select top 1000 * --запись первых 100 строк во временную таблицу #t из таблицы tCard
into #t from Orders

*/ --ОБРАЗЕЦ ИСПОЛЬЗОВАНИЯ ДЛЯ СОЗДАНИЯ ТАБЛИЧНОЙ ПЕРЕМЕННОЙ

--use Northwind

	declare @tablename as nvarchar(100)
	select @tablename = '@tVariable'

	

				drop table if exists #temp
				select SQL_Query as declare1, SQL_Query2 as insert1 into #temp from (
				select SQL_Q + case when LEAD (Comma, 1, 0) OVER (order by column_1) = '0' then '' else LEAD (Comma, 1, 0) OVER (order by column_1) end as SQL_Query
				,name + case when LEAD (Comma, 1, 0) OVER (order by column_1) = '0' then '' else LEAD (Comma, 1, 0) OVER (order by column_1) end as SQL_Query2
				, * 
				from (
					  SELECT '0' as column_1, name, system_type_name, is_nullable, name + ' ' + system_type_name as SQL_Q, ',' as Comma
					  FROM sys.dm_exec_describe_first_result_set(N'SELECT * FROM #t;',NULL,1)
					  ) ALLDATA
					  ) ALLDATA2
				
				
				select 'declare ' + @tablename + ' table' as SQL_Query
				union all
				select '('
				union all
				select declare1 from #temp
				union all
				select ')'
				union all
				select ''
				union all
				select 'insert into ' + @tablename
				union all
				select '('
				union all
				select insert1 from #temp
				union all
				select ')'



/* ОБРАЗЕЦ ИСПОЛЬЗОВАНИЯ РЕЗУЛЬТАТОВ */
/*
declare @tVariable table
(
    OrderID int,
    CustomerID nchar(5),
    EmployeeID int,
    OrderDate datetime,
    RequiredDate datetime,
    ShippedDate datetime,
    ShipVia int,
    Freight money,
    ShipName nvarchar(40),
    ShipAddress nvarchar(60),
    ShipCity nvarchar(15),
    ShipRegion nvarchar(15),
    ShipPostalCode nvarchar(10),
    ShipCountry nvarchar(15)
)

insert into @tVariable
(
    OrderID,
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShippedDate,
    ShipVia,
    Freight,
    ShipName,
    ShipAddress,
    ShipCity,
    ShipRegion,
    ShipPostalCode,
    ShipCountry
) --вставляем результаты приведенного выше запроса перед запросом, результаты которого хотим загрузить в табличную переменную
select * from Orders 


select * from @tVariable t
left join [Order Details] OD
on t.OrderID = OD.OrderID --используем созданную переменную в запросах
*/
/* ОБРАЗЕЦ ИСПОЛЬЗОВАНИЯ РЕЗУЛЬТАТОВ */
