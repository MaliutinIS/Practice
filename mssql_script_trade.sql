create database [Trade]
go
use [Trade]
go

create table [Role]
(
    RoleID int primary key identity,
    RoleName nvarchar(100) not null
)
go

create table [User]
(
    UserID int primary key identity,
    UserSurname nvarchar(100) not null,
    UserName nvarchar(100) not null,
    UserPatronymic nvarchar(100) null,
    UserLogin nvarchar(255) not null unique,
    UserPassword nvarchar(255) not null,
    UserRole int foreign key references [Role](RoleID) not null
)
go

create table OrderStatus
(
    StatusID int primary key identity,
    StatusName nvarchar(50) not null unique
)
go

create table PickupPoint
(
    PickupPointID int primary key identity,
    PickupPointAddress nvarchar(300) not null unique
)
go

create table Client
(
    ClientID int primary key identity,
    ClientSurname nvarchar(100) not null,
    ClientName nvarchar(100) not null,
    ClientPatronymic nvarchar(100) null,
    ClientLogin nvarchar(255) not null unique,
    ClientPassword nvarchar(255) not null
)
go

create table [Order]
(
    OrderID int primary key identity,
    OrderNumber int not null unique,
    OrderDate datetime not null,
    OrderDeliveryDate datetime not null,
    PickupPointID int foreign key references PickupPoint(PickupPointID) not null,
    ClientID int foreign key references Client(ClientID) null,
    PickupCode nvarchar(10) not null,
    OrderStatusID int foreign key references OrderStatus(StatusID) not null
)
go

create table Product
(
    ProductArticleNumber nvarchar(100) primary key,
    ProductName nvarchar(max) not null,
    ProductDescription nvarchar(max) null,
    ProductCategory nvarchar(max) not null,
    ProductPhoto image null,
    ProductManufacturer nvarchar(max) not null,
    ProductSupplier nvarchar(max) not null,
    ProductUnit nvarchar(10) not null,
    ProductCost decimal(19,4) not null,
    ProductMaxDiscountPercent int not null,
    ProductDiscountAmount tinyint null,
    ProductQuantityInStock int not null
)
go

create table OrderProduct
(
    OrderID int foreign key references [Order](OrderID) not null,
    ProductArticleNumber nvarchar(100) foreign key references Product(ProductArticleNumber) not null,
    Quantity int not null check (Quantity > 0),
    Primary key (OrderID, ProductArticleNumber)
)
go
