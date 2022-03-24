USE InstrumentDatabase
GO

create table VersionDB(vers int)
insert into VersionDB (vers) values (0);

GO

create procedure do_proc_1
as
begin
alter table Manager
alter column bonus money;
end

go

create procedure undo_proc_1
as
begin
alter table Manager
alter column bonus int;
end

go

create procedure do_proc_2
as
begin
alter table Manager
add constraint defaultYearsService default '0' for 
yearsOfService;
end

go

create procedure undo_proc_2
as
begin
alter table Manager
drop constraint defaultYearsService
end

go

create procedure do_proc_3
as
begin
create table BonusAngajat(
idBonus int primary key identity,
bonus int,
idEmployee int
);
end

go

create procedure undo_proc_3
as
begin
drop table BonusAngajat
end

go

create procedure do_proc_4
as
begin
alter table BonusAngajat
add dataIssued date
end

go

create procedure undo_proc_4
as
begin
alter table BonusAngajat
drop column dataIssued
end

go

create procedure do_proc_5
as
begin
alter table BonusAngajat
add constraint fk_Bonus foreign key (idEmployee) references Employee(idEmployee)
end

go

create procedure undo_proc_5
as
begin
alter table BonusAngajat
drop constraint fk_Bonus
end


GO
CREATE PROCEDURE change_version
(@version INT)
AS
BEGIN
DECLARE @curr_version INT = (SELECT TOP 1 vers FROM VersionDB)
IF @version > 5 OR @version < 0
    THROW 50001, 'Exista versiuni doar intre 0 si 5', 1
ELSE
BEGIN
    WHILE @version != @curr_version
    BEGIN
        IF @version < @curr_version
        BEGIN
            IF @curr_version = 1
            BEGIN
                EXEC undo_proc_1
            END
            IF @curr_version = 2
            BEGIN
                EXEC undo_proc_2
            END
            IF @curr_version = 3
            BEGIN
                EXEC undo_proc_3
            END
            IF @curr_version = 4
            BEGIN
                EXEC undo_proc_4
            END
            IF @curr_version = 5
            BEGIN
                EXEC undo_proc_5
            END

            SET @curr_version = @curr_version - 1
        END
        ELSE IF @version > @curr_version
        BEGIN
            SET @curr_version = @curr_version + 1

            IF @curr_version = 1
            BEGIN
                EXEC do_proc_1
            END
            IF @curr_version = 2
            BEGIN
                EXEC do_proc_2
            END
            IF @curr_version = 3
            BEGIN
                EXEC do_proc_3
            END
            IF @curr_version = 4
            BEGIN
                EXEC do_proc_4
            END
            IF @curr_version = 5
            BEGIN
                EXEC do_proc_5
            END
        END
    END
    UPDATE VersionDB
    SET vers = @version
    print 'Tabelul a ajuns la versiunea ceruta!'
END
END;



go

drop procedure do_proc_5
drop procedure do_proc_4
drop procedure do_proc_3
drop procedure do_proc_2
drop procedure do_proc_1

drop procedure undo_proc_5
drop procedure undo_proc_4
drop procedure undo_proc_3
drop procedure undo_proc_2
drop procedure undo_proc_1

drop procedure change_version

go


USE InstrumentDatabase
GO

EXEC change_version 5