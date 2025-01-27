USE [master]
GO
/****** Object:  Database [BuilderDatabase]    Script Date: 29.11.2024 9:40:32 ******/
CREATE DATABASE [BuilderDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BuilderDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BuilderDatabase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BuilderDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BuilderDatabase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BuilderDatabase] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BuilderDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BuilderDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BuilderDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BuilderDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BuilderDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BuilderDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [BuilderDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BuilderDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BuilderDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BuilderDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BuilderDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BuilderDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BuilderDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BuilderDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BuilderDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BuilderDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BuilderDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BuilderDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BuilderDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BuilderDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BuilderDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BuilderDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BuilderDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BuilderDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BuilderDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [BuilderDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BuilderDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BuilderDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BuilderDatabase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BuilderDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BuilderDatabase] SET QUERY_STORE = OFF
GO
USE [BuilderDatabase]
GO
/****** Object:  Table [dbo].[ConstructionMachinery]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConstructionMachinery](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[TypeId] [int] NOT NULL,
	[quantity] [int] NULL,
	[cost] [int] NULL,
	[currentProjectId] [int] NOT NULL,
 CONSTRAINT [PK_ConstructionMachinery] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Birthday] [date] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[PositionId] [int] NULL,
	[DateOfBirth] [date] NOT NULL,
	[WorkHours] [int] NULL,
	[CurrentProjectId] [int] NULL,
	[PerHourPayment] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[equipment]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[cost] [int] NULL,
 CONSTRAINT [PK_equipment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineryType]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineryType](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_MachineryType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materials]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[cost] [int] NULL,
 CONSTRAINT [PK_Materials] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[CustomerId] [int] NOT NULL,
	[TypeId] [int] NOT NULL,
	[EndDate] [date] NULL,
	[ProjectStateId] [int] NULL,
	[Budget] [int] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectEstimate]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectEstimate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[MaterialId] [int] NULL,
	[MaterialQuantity] [int] NULL,
	[EquipmentId] [int] NULL,
	[EquipmentQuantity] [int] NULL,
 CONSTRAINT [PK_ProjectEstimate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectState]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectState](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProjectState] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectTask]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTask](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Name] [nvarchar](max) NULL,
	[Descrition] [nvarchar](max) NULL,
	[ProjectId] [int] NOT NULL,
 CONSTRAINT [PK_ProjectTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectType]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectType](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProjectType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salary]    Script Date: 29.11.2024 9:40:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salary](
	[id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[PerHour] [int] NOT NULL,
	[Hours] [int] NOT NULL,
	[Total] [int] NOT NULL,
 CONSTRAINT [PK_Salary] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (1, N'CAT-320', 1, 5, 100000, 0)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (2, N'Кран Liebherr', 2, 3, 200000, 2)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (3, N'Бульдозер Komatsu', 3, 4, 150000, 3)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (4, N'Погрузчик Volvo', 4, 2, 180000, 4)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (5, N'Каток Hamm', 5, 6, 120000, 5)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (6, N'Сваебойный агрегат', 6, 3, 250000, 6)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (7, N'Грейдер Caterpillar', 7, 1, 300000, 7)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (8, N'Асфальтоукладчик Vogele', 8, 2, 220000, 8)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (9, N'Самосвал MAN', 9, 10, 90000, 9)
INSERT [dbo].[ConstructionMachinery] ([id], [name], [TypeId], [quantity], [cost], [currentProjectId]) VALUES (10, N'Фронтальный погрузчик JCB', 10, 2, 210000, 10)
GO
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (1, N'Иван', N'Иванов', CAST(N'1985-05-10' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (2, N'Петр', N'Петров', CAST(N'1990-12-20' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (3, N'Сергей', N'Сергеев', CAST(N'1980-07-15' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (4, N'Анна', N'Антонова', CAST(N'1992-03-18' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (5, N'Мария', N'Марианова', CAST(N'1995-11-02' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (6, N'Алексей', N'Алексеев', CAST(N'1988-06-08' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (7, N'Наталья', N'Натальева', CAST(N'1993-04-22' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (8, N'Дмитрий', N'Дмитриев', CAST(N'1987-01-29' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (9, N'Екатерина', N'Евгеньева', CAST(N'1990-09-12' AS Date))
INSERT [dbo].[Customer] ([id], [Name], [Surname], [Birthday]) VALUES (10, N'Владимир', N'Владимиров', CAST(N'1983-08-30' AS Date))
GO
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (1, N'Иван', N'Сидоров', 1, CAST(N'1980-01-01' AS Date), 160, 2, 123)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (2, N'Олег', N'Иванов', 2, CAST(N'1985-02-14' AS Date), 150, 2, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (3, N'Марина', N'Смирнова', 3, CAST(N'1990-03-12' AS Date), 0, 3, 123)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (4, N'Павел', N'Зайцев', 4, CAST(N'1992-04-18' AS Date), 130, 4, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (5, N'Елена', N'Петрова', 5, CAST(N'1989-05-10' AS Date), 120, 5, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (6, N'Виктор', N'Серов', 6, CAST(N'1987-06-05' AS Date), 110, 6, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (7, N'Александр', N'Сухов', 7, CAST(N'1982-07-22' AS Date), 100, 7, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (8, N'Наталья', N'Орлова', 8, CAST(N'1993-08-15' AS Date), 95, 8, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (9, N'Андрей', N'Егоров', 9, CAST(N'1991-09-30' AS Date), 80, 9, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (10, N'Ксения', N'Миронова', 10, CAST(N'1984-10-10' AS Date), 70, 10, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (11, N'Юлия', N'Кузнецова', 1, CAST(N'1986-11-25' AS Date), 160, 2, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (12, N'Игорь', N'Калинин', 2, CAST(N'1987-04-17' AS Date), 150, 3, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (13, N'Татьяна', N'Соколова', 3, CAST(N'1991-06-03' AS Date), 140, 4, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (14, N'Анатолий', N'Кривенко', 4, CAST(N'1990-09-27' AS Date), 130, 5, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (15, N'Дмитрий', N'Ребров', 5, CAST(N'1994-02-11' AS Date), 120, 6, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (16, N'Маргарита', N'Михайлова', 6, CAST(N'1985-07-05' AS Date), 110, 7, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (17, N'Кирилл', N'Федоров', 7, CAST(N'1988-01-20' AS Date), 100, 8, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (18, N'Оксана', N'Прокопова', 8, CAST(N'1992-05-22' AS Date), 95, 9, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (19, N'Станислав', N'Чернов', 9, CAST(N'1984-12-02' AS Date), 80, 10, NULL)
INSERT [dbo].[Employee] ([id], [Name], [Surname], [PositionId], [DateOfBirth], [WorkHours], [CurrentProjectId], [PerHourPayment]) VALUES (20, N'Екатерина', N'Данилова', 10, CAST(N'1993-03-15' AS Date), 70, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[equipment] ON 

INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (1, N'Дрель', 15, 3000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (2, N'Отбойный молоток', 10, 5000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (3, N'Лобзик', 20, 4000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (4, N'Шуруповерт', 25, 2500)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (5, N'Перфоратор', 30, 3500)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (6, N'Сварочный аппарат', 8, 7000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (7, N'Пилорама', 5, 20000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (8, N'Мотоблок', 12, 15000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (9, N'Компрессор', 6, 10000)
INSERT [dbo].[equipment] ([id], [name], [quantity], [cost]) VALUES (10, N'Генератор', 9, 20000)
SET IDENTITY_INSERT [dbo].[equipment] OFF
GO
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (1, N'Экскаватор')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (2, N'Кран')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (3, N'Бульдозер')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (4, N'Погрузчик')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (5, N'Каток')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (6, N'Сваебойная машина')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (7, N'Грейдер')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (8, N'Асфальтоукладчик')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (9, N'Самосвал')
INSERT [dbo].[MachineryType] ([id], [name]) VALUES (10, N'Фронтальный погрузчик')
GO
SET IDENTITY_INSERT [dbo].[Materials] ON 

INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (1, N'Цемент', 100, 300)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (2, N'Песок', 200, 100)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (3, N'Гравий', 150, 120)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (4, N'Арматура', 50, 500)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (5, N'Кирпич', 1000, 25)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (6, N'Бетон', 80, 400)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (7, N'Плитка', 300, 200)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (8, N'Доски', 500, 150)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (9, N'Утеплитель', 200, 350)
INSERT [dbo].[Materials] ([id], [name], [quantity], [cost]) VALUES (10, N'Кровельные материалы', 100, 1000)
SET IDENTITY_INSERT [dbo].[Materials] OFF
GO
INSERT [dbo].[Position] ([id], [name]) VALUES (1, N'Инженер')
INSERT [dbo].[Position] ([id], [name]) VALUES (2, N'Прораб')
INSERT [dbo].[Position] ([id], [name]) VALUES (3, N'Рабочий')
INSERT [dbo].[Position] ([id], [name]) VALUES (4, N'Архитектор')
INSERT [dbo].[Position] ([id], [name]) VALUES (5, N'Геодезист')
INSERT [dbo].[Position] ([id], [name]) VALUES (6, N'Техник')
INSERT [dbo].[Position] ([id], [name]) VALUES (7, N'Дизайнер')
INSERT [dbo].[Position] ([id], [name]) VALUES (8, N'Сметчик')
INSERT [dbo].[Position] ([id], [name]) VALUES (9, N'Оператор техники')
INSERT [dbo].[Position] ([id], [name]) VALUES (10, N'Менеджер')
GO
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (0, N'жопа жопа жопы', 4, 3, CAST(N'2025-12-31' AS Date), 1, 1000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (1, N'Жилой дом на улице Ленина', 1, 1, CAST(N'2025-12-31' AS Date), 1, 30000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (2, N'Торговый центр', 2, 9, CAST(N'2026-06-30' AS Date), 2, 150000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (3, N'Строительство моста через реку', 3, 3, CAST(N'2025-08-01' AS Date), 3, 300000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (4, N'Дорога к аэропорту', 4, 4, CAST(N'2025-09-15' AS Date), 4, 60000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (5, N'Подземный переход', 5, 5, CAST(N'2026-03-20' AS Date), 5, 4000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (6, N'Завод по переработке отходов', 6, 2, CAST(N'2026-10-10' AS Date), 6, 1000000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (7, N'Солнечная электростанция', 7, 7, CAST(N'2027-05-15' AS Date), 7, NULL)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (8, N'Ветряная электростанция', 8, 8, CAST(N'2025-11-10' AS Date), 8, NULL)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (9, N'Коммерческое здание', 9, 9, CAST(N'2025-07-05' AS Date), 9, 500000000)
INSERT [dbo].[Project] ([id], [name], [CustomerId], [TypeId], [EndDate], [ProjectStateId], [Budget]) VALUES (10, N'Строительство туннеля', 10, 5, CAST(N'2026-01-30' AS Date), 10, NULL)
GO
SET IDENTITY_INSERT [dbo].[ProjectEstimate] ON 

INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (0, 3, 1, 1000, 10, 3000)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (1, 1, 1, 10, 1, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (2, 2, 2, 20, 2, 3)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (3, 3, 3, 30, 3, 1)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (4, 4, 4, 40, 4, 1)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (5, 5, 5, 50, 5, 4)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (6, 6, 6, 60, 6, 3)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (7, 7, 7, 70, 7, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (8, 8, 8, 80, 8, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (9, 9, 9, 90, 9, 1)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (10, 10, 10, 100, 10, 1)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (11, 1, 2, 30, 2, 3)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (12, 2, 3, 15, 3, 4)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (13, 3, 4, 20, 4, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (14, 4, 5, 25, 5, 5)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (15, 5, 6, 35, 6, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (16, 6, 7, 40, 7, 3)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (17, 7, 8, 50, 8, 1)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (18, 8, 9, 60, 9, 2)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (19, 9, 10, 70, 10, 4)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (20, 10, 1, 80, 1, 3)
INSERT [dbo].[ProjectEstimate] ([id], [ProjectId], [MaterialId], [MaterialQuantity], [EquipmentId], [EquipmentQuantity]) VALUES (21, 4, 3, 3, 3, 3)
SET IDENTITY_INSERT [dbo].[ProjectEstimate] OFF
GO
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (1, N'Инициализация')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (2, N'Проектирование')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (3, N'Закупка')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (4, N'Строительство')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (5, N'Тестирование')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (6, N'Завершение')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (7, N'Архив')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (8, N'Заморожено')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (9, N'Отклонено')
INSERT [dbo].[ProjectState] ([id], [name]) VALUES (10, N'Утверждено')
GO
SET IDENTITY_INSERT [dbo].[ProjectTask] ON 

INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (0, CAST(N'2024-11-28' AS Date), CAST(N'2024-12-05' AS Date), N'Новая задача', N'Описание задачи', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (1, CAST(N'2022-11-22' AS Date), CAST(N'2022-11-29' AS Date), NULL, NULL, 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (2, CAST(N'2024-11-28' AS Date), CAST(N'2024-12-05' AS Date), N'Новая задача', N'Описание задачи', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (3, CAST(N'2024-11-28' AS Date), CAST(N'2024-12-05' AS Date), N'Новая задача', N'Описание задачи', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (4, CAST(N'2024-11-28' AS Date), CAST(N'2024-12-05' AS Date), N'Новая задача', N'Описание задачи', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (5, CAST(N'2024-11-01' AS Date), CAST(N'2024-11-10' AS Date), N'Проектирование', N'Подготовка архитектурного плана', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (6, CAST(N'2024-11-02' AS Date), CAST(N'2024-11-12' AS Date), N'Закупка материалов', N'Закупка необходимых материалов для строительства', 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (7, CAST(N'2024-11-05' AS Date), CAST(N'2024-11-15' AS Date), N'Бурение фундамента', N'Бурение глубоких отверстий для фундамента', 3)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (8, CAST(N'2024-11-06' AS Date), CAST(N'2024-11-16' AS Date), N'Кирпичная кладка', N'Возведение стен из кирпича', 4)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (9, CAST(N'2024-11-08' AS Date), CAST(N'2024-11-18' AS Date), N'Монтаж окон', N'Установка окон в здании', 5)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (10, CAST(N'2024-11-10' AS Date), CAST(N'2024-11-20' AS Date), N'Кровельные работы', N'Покрытие крыши и установка крыши', 6)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (11, CAST(N'2024-11-12' AS Date), CAST(N'2024-11-22' AS Date), N'Электропроводка', N'Монтаж электропроводки и освещения', 7)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (12, CAST(N'2024-11-15' AS Date), CAST(N'2024-11-25' AS Date), N'Отделка стен', N'Окраска и отделка стен в помещении', 8)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (13, CAST(N'2024-11-17' AS Date), CAST(N'2024-11-27' AS Date), N'Полы и покрытия', N'Укладка плитки на полы', 9)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (14, CAST(N'2024-11-19' AS Date), CAST(N'2024-11-29' AS Date), N'Окончательная отделка', N'Заключительные работы по отделке', 10)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (15, CAST(N'2024-11-20' AS Date), CAST(N'2024-11-30' AS Date), N'Заключительный контроль', N'Проверка всех выполненных работ', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (16, CAST(N'2024-11-21' AS Date), CAST(N'2024-12-01' AS Date), N'Установка дверей', N'Монтаж входных и внутренних дверей', 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (17, CAST(N'2024-11-22' AS Date), CAST(N'2024-12-02' AS Date), N'Кладка плитки', N'Укладка плитки в ванной и кухне', 3)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (18, CAST(N'2024-11-23' AS Date), CAST(N'2024-12-03' AS Date), N'Монтаж систем отопления', N'Установка труб и радиаторов', 4)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (19, CAST(N'2024-11-24' AS Date), CAST(N'2024-12-04' AS Date), N'Монтаж вентиляции', N'Установка вентиляционных систем', 5)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (20, CAST(N'2024-11-25' AS Date), CAST(N'2024-12-05' AS Date), N'Установка сантехники', N'Монтаж ванн, унитазов и раковин', 6)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (21, CAST(N'2024-11-26' AS Date), CAST(N'2024-12-06' AS Date), N'Покраска фасада', N'Покраска внешней стороны здания', 7)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (22, CAST(N'2024-11-27' AS Date), CAST(N'2024-12-07' AS Date), N'Монтаж наружного освещения', N'Установка уличных светильников', 8)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (23, CAST(N'2024-11-28' AS Date), CAST(N'2024-12-08' AS Date), N'Работы по благоустройству', N'Планировка и озеленение территории', 9)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (24, CAST(N'2024-11-29' AS Date), CAST(N'2024-12-09' AS Date), N'Финальный осмотр', N'Финальный осмотр всех завершенных работ', 10)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (25, CAST(N'2024-11-30' AS Date), CAST(N'2024-12-10' AS Date), N'Инспекция качества', N'Проверка на соответствие стандартам качества', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (26, CAST(N'2024-12-01' AS Date), CAST(N'2024-12-11' AS Date), N'Проверка систем безопасности', N'Проверка и настройка всех систем безопасности', 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (27, CAST(N'2024-12-02' AS Date), CAST(N'2024-12-12' AS Date), N'Установка сигнализации', N'Установка системы охранной сигнализации', 3)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (28, CAST(N'2024-12-03' AS Date), CAST(N'2024-12-13' AS Date), N'Ремонт электросистемы', N'Проверка и ремонт электросистемы', 4)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (29, CAST(N'2024-12-04' AS Date), CAST(N'2024-12-14' AS Date), N'Ремонт отопительной системы', N'Ремонт и настройка системы отопления', 5)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (30, CAST(N'2024-12-05' AS Date), CAST(N'2024-12-15' AS Date), N'Ремонт водоснабжения', N'Ремонт водоснабжения в здании', 6)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (31, CAST(N'2024-12-06' AS Date), CAST(N'2024-12-16' AS Date), N'Тестирование лифтов', N'Проверка работоспособности лифтов', 7)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (32, CAST(N'2024-12-07' AS Date), CAST(N'2024-12-17' AS Date), N'Ремонт крыш', N'Проверка и ремонт крыши', 8)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (33, CAST(N'2024-12-08' AS Date), CAST(N'2024-12-18' AS Date), N'Монтаж систем кондиционирования', N'Установка кондиционеров', 9)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (34, CAST(N'2024-12-09' AS Date), CAST(N'2024-12-19' AS Date), N'Монтаж оконных рам', N'Монтаж оконных рам в помещениях', 10)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (35, CAST(N'2024-12-10' AS Date), CAST(N'2024-12-20' AS Date), N'Подключение коммуникаций', N'Подключение всех коммуникационных систем', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (36, CAST(N'2024-12-11' AS Date), CAST(N'2024-12-21' AS Date), N'Обработка окон', N'Очистка и подготовка окон к установке', 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (37, CAST(N'2024-12-12' AS Date), CAST(N'2024-12-22' AS Date), N'Ремонт полов', N'Замена и ремонт полов в помещениях', 3)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (38, CAST(N'2024-12-13' AS Date), CAST(N'2024-12-23' AS Date), N'Заключение договоров', N'Заключение договоров с подрядчиками', 4)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (39, CAST(N'2024-12-14' AS Date), CAST(N'2024-12-24' AS Date), N'Техническое обслуживание', N'Проверка технических систем здания', 5)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (40, CAST(N'2024-12-15' AS Date), CAST(N'2024-12-25' AS Date), N'Ремонт дверей', N'Ремонт и настройка дверных механизмов', 6)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (41, CAST(N'2024-12-16' AS Date), CAST(N'2024-12-26' AS Date), N'Технический осмотр', N'Полный осмотр технического состояния здания', 7)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (42, CAST(N'2024-12-17' AS Date), CAST(N'2024-12-27' AS Date), N'Установка шлагбаума', N'Монтаж шлагбаума для контроля доступа', 8)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (43, CAST(N'2024-12-18' AS Date), CAST(N'2024-12-28' AS Date), N'Проверка безопасности', N'Проверка всех систем безопасности на соответствие', 9)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (44, CAST(N'2024-12-19' AS Date), CAST(N'2024-12-29' AS Date), N'Установка камер', N'Установка видеонаблюдения на объекте', 10)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (45, CAST(N'2024-12-20' AS Date), CAST(N'2024-12-30' AS Date), N'Финальный отчет', N'Подготовка финального отчета по проекту', 1)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (46, CAST(N'2024-12-21' AS Date), CAST(N'2024-12-31' AS Date), N'Проверка качества материалов', N'Проверка качества всех использованных материалов', 2)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (47, CAST(N'2024-12-22' AS Date), CAST(N'2024-12-31' AS Date), N'Запуск проекта', N'Запуск проекта на финальной стадии', 3)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (48, CAST(N'2024-12-23' AS Date), CAST(N'2025-01-02' AS Date), N'Окончательная уборка', N'Уборка после завершения всех строительных работ', 4)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (49, CAST(N'2024-12-24' AS Date), CAST(N'2025-01-03' AS Date), N'Демонтаж строительных материалов', N'Демонтаж и утилизация строительных материалов', 5)
INSERT [dbo].[ProjectTask] ([id], [StartDate], [EndDate], [Name], [Descrition], [ProjectId]) VALUES (50, CAST(N'2024-12-25' AS Date), CAST(N'2025-01-04' AS Date), N'Завершение проекта', N'Окончательное завершение проекта и подписание документов', 6)
SET IDENTITY_INSERT [dbo].[ProjectTask] OFF
GO
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (1, N'Жилое здание')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (2, N'Промышленное здание')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (3, N'Мост')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (4, N'Дорога')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (5, N'Туннель')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (6, N'ГЭС')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (7, N'Солнечная электростанция')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (8, N'Ветрогенератор')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (9, N'Коммерческая недвижимость')
INSERT [dbo].[ProjectType] ([id], [name]) VALUES (10, N'Другое')
GO
INSERT [dbo].[Salary] ([id], [EmployeeId], [ProjectId], [PerHour], [Hours], [Total]) VALUES (0, 3, 3, 140, 140, 19600)
GO
ALTER TABLE [dbo].[ConstructionMachinery]  WITH CHECK ADD  CONSTRAINT [FK_ConstructionMachinery_MachineryType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[MachineryType] ([id])
GO
ALTER TABLE [dbo].[ConstructionMachinery] CHECK CONSTRAINT [FK_ConstructionMachinery_MachineryType]
GO
ALTER TABLE [dbo].[ConstructionMachinery]  WITH CHECK ADD  CONSTRAINT [FK_ConstructionMachinery_Project] FOREIGN KEY([currentProjectId])
REFERENCES [dbo].[Project] ([id])
GO
ALTER TABLE [dbo].[ConstructionMachinery] CHECK CONSTRAINT [FK_ConstructionMachinery_Project]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Position] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Position] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Position]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Project] FOREIGN KEY([CurrentProjectId])
REFERENCES [dbo].[Project] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Project]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Customer]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ProjectState] FOREIGN KEY([ProjectStateId])
REFERENCES [dbo].[ProjectState] ([id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ProjectState]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ProjectType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[ProjectType] ([id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ProjectType]
GO
ALTER TABLE [dbo].[ProjectEstimate]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEstimate_equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[equipment] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectEstimate] CHECK CONSTRAINT [FK_ProjectEstimate_equipment]
GO
ALTER TABLE [dbo].[ProjectEstimate]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEstimate_Materials] FOREIGN KEY([MaterialId])
REFERENCES [dbo].[Materials] ([id])
GO
ALTER TABLE [dbo].[ProjectEstimate] CHECK CONSTRAINT [FK_ProjectEstimate_Materials]
GO
ALTER TABLE [dbo].[ProjectEstimate]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEstimate_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([id])
GO
ALTER TABLE [dbo].[ProjectEstimate] CHECK CONSTRAINT [FK_ProjectEstimate_Project]
GO
ALTER TABLE [dbo].[ProjectTask]  WITH CHECK ADD  CONSTRAINT [FK_ProjectTask_Project1] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectTask] CHECK CONSTRAINT [FK_ProjectTask_Project1]
GO
ALTER TABLE [dbo].[Salary]  WITH CHECK ADD  CONSTRAINT [FK_Salary_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Salary] CHECK CONSTRAINT [FK_Salary_Employee]
GO
ALTER TABLE [dbo].[Salary]  WITH CHECK ADD  CONSTRAINT [FK_Salary_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([id])
GO
ALTER TABLE [dbo].[Salary] CHECK CONSTRAINT [FK_Salary_Project]
GO
USE [master]
GO
ALTER DATABASE [BuilderDatabase] SET  READ_WRITE 
GO
