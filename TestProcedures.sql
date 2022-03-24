
create or alter procedure delete_purchase_history
(@noOfRows int)
as
begin
	delete from PurchaseHistory where idClient <= @noOfRows
end


go

create or alter procedure delete_client
(@noOfRows int)
as
begin
	delete from Client where idClient <= @noOfRows
end


go

create or alter procedure delete_client_adress
(@noOfRows int)
as
begin
	delete from ClientAddress where idClientAdress <= @noOfRows
end


go

create or alter procedure delete_table 
(@position int, 
 @noOfRows int)
as
begin
	if @position >= 3
	begin
		exec delete_purchase_history @noOfRows
	end
	if @position >= 2
	begin
		exec delete_client @noOfRows
	end
	if @position >= 1
	begin
		exec delete_client_adress @noOfRows
	end
end

go

create or alter procedure insert_client_adress
(@noOfRows int)
as
	begin

	dbcc checkident ('ClientAddress', reseed, 0);

	declare @n int
	set @n=1 

	while @n<=@NoOfRows
	begin
		insert into ClientAddress(country, county, street, number, storey) VALUES 
		('Country' + convert (varchar(5), @n),
		 'County' + convert (varchar(5), @n),
		 'Street' + convert (varchar(5), @n),
		 @n,
		 @n
		 )
		set @n=@n+1
	end
end


go

create or alter procedure insert_client
(@noOfRows int)
as
	begin

	dbcc checkident ('Client', reseed, 0);

	declare @fk int
	declare @n int
	set @n=1 

	while @n<=@NoOfRows
	begin
		select top 1 @fk = idClientAdress from ClientAddress order by NEWID()

		insert into Client(clientName, idAdress) VALUES 
		('Name' + convert (varchar(5), @n),
		 @fk
		 )
		set @n=@n+1
	end
end

go


create or alter procedure insert_purchase_history
(@noOfRows int)
as
begin

	--declare @fk1 int
	declare @fk2 int
	declare @n int
	set @n=1 

	while @n<=@NoOfRows
	begin
		--select top 1 @fk1 = idClient from Client order by NEWID()
		select top 1 @fk2 = idProduct from Product order by NEWID()

		insert into PurchaseHistory(idClient, idProduct, price, deliveryCost) VALUES 
		(@n,
		 @fk2,
		 @n,
		 @n
		 )
		set @n=@n+1
	end
end

go


create or alter procedure insert_table 
(@position int, 
 @noOfRows int)
as
	begin
	if @position >= 1
	begin
		exec insert_client_adress @noOfRows
	end
	if @position >= 2
	begin
		exec insert_client @noOfRows
	end
	if @position >= 3
	begin
		exec insert_purchase_history @noOfRows
	end
end

go


create or alter procedure select_view 
(@viewId int)
as
begin
	if @viewId = 1
	begin
		select * from vw_ClientAdress
	end
	if @viewId = 2
	begin
		select * from vw_ClientPurchaseHistory
	end
	if @viewId = 3
	begin
		select * from vw_ClientPurchaseHistoryGrouped
	end
end

----

exec insert_client_adress 100
exec insert_client 100
exec insert_purchase_history 100

exec select_view 1
exec select_view 2
exec select_view 3

exec delete_purchase_history 100
exec delete_client 100
exec delete_client_adress 100

exec insert_table 3, 100
exec delete_table 3, 100

----

go
create or alter procedure test
(@table_id int,
 @view_id int)
as
begin

	declare @ds datetime-- start time test
	declare @di datetime-- intermediate time test
	declare @de datetime-- end time test

	declare @noOfRowsDelete int
	select top 1 @noOfRowsDelete = NoOfRows from TestTables 
	where TableID = @table_id and TestID = 1

	declare @noOfRowsInsert int
	select top 1 @noOfRowsInsert = NoOfRows from TestTables 
	where TableID = @table_id and TestID = 2

	declare @position int
	select top 1 @position = Position from TestTables 
	where TableID = @table_id


	set @ds = GETDATE()
	exec delete_table @position, @noOfRowsDelete
	exec insert_table @position, @noOfRowsInsert
	set @di = GETDATE()
	exec select_view @view_id
	set @de = GETDATE()

	insert into TestRuns(Description, StartAt, EndAt) VALUES 
		('Table ' + convert (varchar(5), @table_id)
		 +' + View ' + convert (varchar(5), @view_id),
		 @ds,
		 @de
		 )
	
	declare @test_run_id int
	select top 1 @test_run_id = TestRunID from TestRuns 
	where StartAt = @ds

	insert into TestRunTables(TestRunID, TableID, StartAt, EndAt) values
	(@test_run_id, @table_id, @ds, @di)

	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt) values
	(@test_run_id, @view_id, @di, @de)

end

go


create or alter procedure run_tests
as
begin
	set nocount on
	delete from TestRuns
	delete from TestRunTables
	delete from TestRunViews
	dbcc checkident ('TestRuns', reseed, 0);
	exec delete_table 3, 10000 -- stergem continuturile din tabele, petru a putea sterge
							   -- din tabelul fara foreign key, sau din cel cu un fk, fara probleme

	exec test 1, 1				-- un test suplimentar pentru 1 1, 2 1, 3 1, pt ca prima oara
	exec test 1, 1				-- se sterg mai putine chestii
	exec test 1, 2
	exec test 1, 3
	exec test 2, 1
	exec test 2, 1
	exec test 2, 2
	exec test 2, 3
	exec test 3, 1
	exec test 3, 1
	exec test 3, 2
	exec test 3, 3

	set nocount off
end

exec run_tests