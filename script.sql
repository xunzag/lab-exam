USE [master]
GO
/****** Object:  Database [test]    Script Date: 2/7/2023 3:35:43 AM ******/
CREATE DATABASE [test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [test] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [test] SET ARITHABORT OFF 
GO
ALTER DATABASE [test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [test] SET RECOVERY FULL 
GO
ALTER DATABASE [test] SET  MULTI_USER 
GO
ALTER DATABASE [test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [test] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'test', N'ON'
GO
ALTER DATABASE [test] SET QUERY_STORE = OFF
GO
USE [test]
GO
/****** Object:  Table [dbo].[tbl_Room]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Room](
	[RId] [int] IDENTITY(1,1) NOT NULL,
	[RName] [varchar](50) NOT NULL,
	[RDescription] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_TimeSlot]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TimeSlot](
	[TSId] [int] IDENTITY(1,1) NOT NULL,
	[TSCode] [varchar](50) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTIme] [time](7) NOT NULL,
	[RId] [int] NULL,
	[Status] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_Room] ON 

INSERT [dbo].[tbl_Room] ([RId], [RName], [RDescription]) VALUES (1, N'R-204', N'Very Cool Room')
INSERT [dbo].[tbl_Room] ([RId], [RName], [RDescription]) VALUES (2, N'R205', N'Very hot room ngl')
INSERT [dbo].[tbl_Room] ([RId], [RName], [RDescription]) VALUES (3, N'R206', N'Very hot room ngl')
INSERT [dbo].[tbl_Room] ([RId], [RName], [RDescription]) VALUES (4, N'R206', N'Very cool room ngl')
SET IDENTITY_INSERT [dbo].[tbl_Room] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_TimeSlot] ON 

INSERT [dbo].[tbl_TimeSlot] ([TSId], [TSCode], [StartTime], [EndTIme], [RId], [Status]) VALUES (3, N'CS123', CAST(N'02:30:00' AS Time), CAST(N'05:30:00' AS Time), 1, 1)
INSERT [dbo].[tbl_TimeSlot] ([TSId], [TSCode], [StartTime], [EndTIme], [RId], [Status]) VALUES (2, N'CS6969', CAST(N'04:30:00' AS Time), CAST(N'06:30:00' AS Time), 3, 1)
SET IDENTITY_INSERT [dbo].[tbl_TimeSlot] OFF
GO
/****** Object:  StoredProcedure [dbo].[r_getRooms]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[r_getRooms]
as
Begin
select * from tbl_Room
end
GO
/****** Object:  StoredProcedure [dbo].[s_getTimeSlots]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[s_getTimeSlots]
as
begin
 select * from tbl_TimeSlot t inner join tbl_Room r on t.RId = r.RId
end
GO
/****** Object:  StoredProcedure [dbo].[t_delTimeSlot]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[t_delTimeSlot]
@TSId int

as
begin
delete from tbl_TimeSlot where TSId=@TSId
end
GO
/****** Object:  StoredProcedure [dbo].[t_save]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[t_save]
@TSCode varchar(50),
@StartTime time,
@EndTime time,
@RId int
as
begin
insert into tbl_TimeSlot values(@TSCode,@StartTime,@EndTime,@RId,1)
end
GO
/****** Object:  StoredProcedure [dbo].[t_update]    Script Date: 2/7/2023 3:35:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[t_update]
@TSId int,
@TSCode varchar(50),
@StartTime time,
@EndTime time,
@RId int
as
begin
update tbl_TimeSlot set TSCode=@TSCode, StartTime=@StartTime, EndTime=@EndTime, RId=@RId where TSId=@TSId
end

GO
USE [master]
GO
ALTER DATABASE [test] SET  READ_WRITE 
GO
