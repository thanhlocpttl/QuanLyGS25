use master
if exists (SELECT name FROM master.dbo.sysdatabases  WHERE name = 'QuanLyBanHangGS25')
Begin
	drop database QuanLyBanHangGS25
End

Create database	QuanLyBanHangGS25
go
use QuanLyBanHangGS25 


go 

--Create database QLGS25
--1. Nhan vien
create table NhanVien 
		(
		MaNV nchar(6) not null primary key,
		HoTenNV nvarchar(100) not null,
		NgaySinh date not null,
		GioiTinh nvarchar(10)not null,
		DiaChi nvarchar(100)not null,
		DienThoai int not null,
		Email nvarchar(100) not null
		)
go
--2.Khach hang
create table KhachHang 
		(
		MaKH nchar(6) not null primary key,
		HoTenKH nvarchar (100) not null,
		DiaChi nvarchar(100)not null,
		DienThoai int not null
		)
go
--3.Loai san pham
create table LoaiSP
		(
		MaLoaiSP nchar(6) not null primary key,
		TenLoaiSP nvarchar(60) not null
		)
go
--4. Nhà cung cấp
create table NhaCungCap
		(
		MaNCC nchar(6) not null primary key,
		TenNCC nvarchar(60) not null,
		DiaChi nvarchar(100) not null,
		Email nvarchar (100) not null
		)
go
--5. Sản phẩm 
create table SanPham
		(
		MaSP nchar(6) not null primary key,
		TenSP nvarchar(60) not null,
		DgNhap float not null,
		DgBan float not null,
		SLTon int not null,
		DVTinh nvarchar(30) not null,
		MaLoaiSP nchar(6) ,
		constraint FK_SanPham_MaLoaiSP 
		foreign key (MaLoaiSP) references LoaiSP(MaLoaiSP),
		MaNCC nchar(6) ,
		constraint FK_SanPham_MaNCC 
		foreign key (MaNCC) references NhaCungCap(MaNCC)
		)
go
--6. Hóa đơn
create table HoaDon
		(
		MaHD nchar(6) not null primary key,
		NgayLapHD date not null,
		PTTT nvarchar(50) not null,
		MaNV nchar(6) ,
		constraint FK_HoaDon_MaNV
		foreign key (MaNV) references NhanVien(MaNV),
		MaKH nchar(6),
		constraint FK_HoaDon_MaKH
		foreign key (MaKH) references KhachHang(MaKH),
		)
go
--7.Chi tiết hóa đơn
create table CTHoaDon
		(
		MaHD nchar(6) not null,
		constraint FK_CTHoaDon_MaHD
		foreign key (MaHD) references HoaDon(MaHD),
		MaSP nchar(6) not null,
		constraint FK_CTHoaDon_MaSP
		foreign key (MaSP) references SanPham(MaSP),
		SLBan int not null,
		DgBan float not null,
		primary key (MaHD,MaSP)
		)
go
--8.Phiếu nhập
create table PhieuNhap
		(
		MaPN nchar(6) primary key,
		NgayNhap date not null,
		MaNV nchar(6),
		constraint FK_PhieuNhap_MaNV
		foreign key (MaNV) references NhanVien(MaNV),
		MaNCC nchar(6),
		constraint FK_PhieuNhap_MaNCC
		foreign key (MaNCC) references NhaCungCap(MaNCC),

		)
go
--9.Chi tiết phiếu nhập
create table CTPhieuNhap
		(
		MaPN nchar(6) not null,
		constraint FK_CTPhieuNhap_MaPN
		foreign key (MaPN) references PhieuNhap(MaPN),
		MaSP nchar(6) not null,
		constraint FK_CTPhieuNhap_MaSP
		foreign key (MaSP) references SanPham(MaSP),
		SLNhap int,
		DgNhap float,
		primary key (MaPN,MaSP)
		)


-- Bảng nhân viên
	insert into NhanVien values
	('NV0001',N'Trần Minh Nhựt','2001/04/12',N'Nam',N'2/4 Nguyễn Tri Phương, Quận 8,TP.HCM','0813838112','nhut@gmail.com'),
	('NV0002',N'Đoàn Kim Oanh','2001/09/04',N'Nữ',	N'04 Nguyễn Huệ, Quận 10,TP.HCM',	'0784868637','Oanh@gmail.com'),
	('NV0003',N'Nguyễn Chánh Thông', '2001/02/21',N'Nam',N'156/3 Võ Văn Ngân, Quận 6, TP.HCM','0743783939','Thong@gmail.com'),
	('NV0004',N'Trần Minh Quang','2001/05/11',N'Nam',N'08 Lê Lợi, Quận 6, TP.HCM','0480598921','Quang@gmail.com'),
	('NV0005',N'Lê Uyên','2001/03/03',N'Nữ',	N'12 Lý Thường Kiệt, Quận 10, TP.HCM','0813838112','uyen@gmail.com'),
	('NV0006',N'Nguyễn Lan Anh','2001/05/15',N'Nữ',N'243 Lê Văn Sỹ, Quận 3, TP.HCM','0265318165','Anh@gmail.com'),
	('NV0007',N'Nguyễn Hùng','1995/04/02',N'Nam',N'56 Nguyễn Tri Phương, Quận 5,TP.HCM','0813265348','hung@gmail.com'),
	('NV0008',N'Lê Thị An',	'1996/04/04',N'Nữ',	N'2/6 Nguyễn Huệ, Quận 3,TP.HCM','0784853780','an@gmail.com'),
	('NV0009',N'Trần Dũng','1998/02/03',N'Nam',	N'04 Võ Văn Ngân, Quận 4, TP.HCM',	'0743734870','Dung@gmail.com'),
	('NV0010',N'Trần Anh Huy','1997/06/11',	N'Nam',	N'67 Lê Lợi, Quận 5, TP.HCM',	'0480545321','Huy@gmail.com') ,
	('NV0011',N'Nguyễn Anh Thư','1994/06/13',N'Nữ',	N'56 Lý Thường Kiệt, Quận 1, TP.HCM','0813832654','thu@gmail.com'),
	('NV0012',N'Lê Lan Anh', '1996/08/15',	N'Nữ',	N'34 Lê Văn Sỹ, Tân Bình, TP.HCM','0265314231','anh12@gmail.com'),
	('NV0013',N'Nguyễn Quang','1997/05/12',	N'Nam',	N'564 Nguyễn Tri Phương,TP.HCM','0814347809','Quang23@gmail.com'),
	('NV0014',N'Lê Minh Châu','1994/02/14',	N'Nữ',	N'34 Nguyễn Huệ, Quận 1,TP.HCM','0784825632','Chau@gmail.com'),
	('NV0015',N'Bùi Dũng','1996/04/21',N'Nam',N'3/96 Võ Văn Ngân, Quận 7, TP.HCM',	'0743719878','Dung89@gmail.com'),
	('NV0016',N'Trần Phong','1995/05/21',N'Nam',	N'54 Lê Lợi, Quận 2, TP.HCM','0480535678','Phong@gmail.com'),
	('NV0017',N'Lê Nhã Ái', '1999/04/03',N'Nữ',	N'18 Lý Thái Tổ, Quận 5, TP.HCM','0813809145','Aiiii@gmail.com'),
	('NV0018',N'Nguyễn Thị Nhã', '1998/05/25',	N'Nữ',	N'243 Lê Văn Việt, Quận 3, TP.HCM','0265347892','Nha56@gmail.com'),
	('NV0019',N'Nguyễn Quân','2003/08/03',	N'Nam',	N'12 Tân Sơn Nhì, Quận 10, TP.HCM','0813817807','Quan023@gmail.com'),
	('NV0020',N'Nguyễn Quốc Hòa','2005/07/15',N'Nam',	N'243 Lê Thị Sáu, Quận 3, TP.HCM','0265324690','Hoa5698@gmail.com'),
	('NV0021',N'Lê Thảo Mai ','1986/07/06',	N'Nữ',	N'23 Bui Thi Đức, Quận 1, TP.HCM','0456789101','Mai@gmail.com'),
	('NV0022',N'Nguyễn Văn Dũng','1987/09/15',N'Nam',	N'2 Bà Trưng, Quận 8, TP.HCM','0948561325','DUNG123456@gmail.com'),
	('NV0023',N'Lê Dũ',	'1988/04/14',N'Nam',	N'12/3 Kp4, Quận 3, TP.HCM','0125794619','Du09@gmail.com'),
	('NV0024',N'Phùng Vân Anh',	'2001/04/16',N'Nữ',	N'Trần Soạn, Quận 7, TP.HCM','0549761297','Anh768@gmail.com'),
	('NV0025',N'Lê Hà Tiên','2008/07/15',N'Nữ',	N'Vạn Kiếp, Quận 1, TP.HCM','0974681324','tien@gmail.com')
go

-- Bảng Khách hàng
	insert into KhachHang values
	('KH0001', N'Lê Thị Cúc',  N'Lô C phòng 28, chung cư Thanh Đa',	'0929879870'),
	('KH0002', N'Mai Minh Mẫn' ,N'78/12/8/Tân Hội',	'0987897899'),
	('KH0003', N'Võ Tú Hoàng',N'178/97 An Dương Vương',	'0912342347'),
	('KH0004', N'Trần Hữu Thắng', N'50 Nguyễn Du','0926786788'),
	('KH0005', N'Nguyễn Duy Hưng',N'67 Kỳ Đồng' ,'0984566540'),
	('KH0006',N'Nguyễn Việt Dũng',N'493 Trường Chinh,Phường 14,TP.HCM','0339317215'),
	('KH0007','Đỗ Hồng Anh',N'12 KP1,Hiệp Thành,Quận 12,TP.HCM','0939393993'),
	('KH0008',N'Nguyễn Ngọc Trúc',N'321 Lãnh Binh Thăng,TP.HCM',	'0852785457'),
	('KH0009',N'Hoàng Quang Huy',N'319 Quận Bình Thạnh,TP.HCM',	'0939393993'),
	('KH0010',N'Lê Minh Hiếu',N'72 Trần Đình Xu,P.Cầu Kho,Quận 1','0852783113'),
	('KH0011',N'Trần Tố Tố',N'116/11 Quận Phú Nhuận,TP.HCM','0931111193'),
	('KH0012',N'Đặng Giáng Mi',N'60A Cao Thắng, P.5,Quận 3,TP.HCM','0939222293'),
	('KH0013',N'Nguyễn Giáng ON',N'835/17E Trần Hưng Đạo,P.1,Quận 5','0912313993'),
	('KH0014',N'Liễu Liễu',N'143 Lê Quang Sung,Quận 6,TP.HCM',	'0332317215'),
	('KH0015',N'Trương Mỹ Lệ',N'243/29G Tôn Đản,phường 15,quận 4,','0851735457'),
	('KH0016',N'Tú Tú',N'9 Nguyễn Án,P.11,Quận 5,TP.HCM','0929299113'),
	('KH0017',N'Liễu Liễu',	N'Hẻm 419 P.3,Quận Phú Nhuận',	'0937364313'),
	('KH0018',N'Lan Ly',N'25 P.Phạm Ngũ Lão, Quận 1',	'0990986332'),
	('KH0019',N'Tôn Ngọc Nữ',N'43 Lê Đại Hành,Phường 11,Quận 11','0909813993'),
	('KH0020',N'Nhã Lan Thanh',	N'187 Cống Quỳnh,P.Phạm Ngũ Lão,Quận 1','0990986332')
go

--Bang LoaiSP
	insert into LoaiSP values 
	('LSP001',N'Bánh ngọt'),
	('LSP002',N'Kẹo'),
	('LSP003',N'Cơm'),
	('LSP004',N'Bánh mì'),
	('LSP005',N'Nước ngọt'),
	('LSP006',N'Trà sữa'),
	('LSP007',N'Cafe'),
	('LSP008',N'Mỳ'),
	('LSP009',N'Kem'),
	('LSP010',N'Đồ chơi')
go

-- Bảng NhaCungCap
	insert into NhaCungCap values 
	('NCC001',N'Bánh Kẹo Ngọt Thiên An',N'Thuận An - Bình Dương','banhkeongotthienan@gmail.com'),
	('NCC002',N'Nước Ngọt Minh Dương',N'Biên Hòa - Đồng Nai','nuocngotminhduong@gmail.com'),
	('NCC003',N'Trà sửa Hàn Quốc',N'Thuận An - Bình Dương','trasuahq@gmail.com'),
	('NCC004',N'Mỳ Acecook',N'Quận 10 - Tp.Hồ Chí Minh','myAcecook@gmail.com'),
	('NCC005',N'Com Phuc Loc Tho',N'Quận 8 - Tp.Hồ Chí Minh','phucloctho@gmail.com'),
	('NCC006',N'Đồ chơi trẻ em',N'Quận 1 - Tp.Hồ Chí Minh','mimi@gmail.com')
go


--Bảng SanPham
insert into SanPham values 
	('SP0001',N'Trà sữa thái xanh',10000,15000,'10',N'Ly','LSP006','NCC003'),
	('SP0002',N'Trà sữa thái đỏ',10000,15000,'31',N'Ly','LSP006','NCC003'),
	('SP0003',N'Nước Sting đỏ',7000,12000,'20',N'Chai','LSP005','NCC002'),
	('SP0004',N'Nước Sting vàng',7000,12000,'9',N'Chai','LSP005','NCC002'),
	('SP0005',N'Bánh Oishi Tôm Cay',3000,7000,'20',N'Bịch','LSP001','NCC001'),
	('SP0006',N'Bánh Oishi Hành',3000,7000,'33',N'Bịch','LSP001','NCC001'),
	('SP0007',N'Bánh Mochi vị dâu',6000,13000,'10',N'Cái','LSP001','NCC001'),
	('SP0008',N'Bánh Mochi vị matcha',7000,15000,'32',N'Cái','LSP001','NCC001'),
	('SP0009',N'Cơm nắm vị cá ngừ',10000,15000,'17',N'Cái','LSP003','NCC004'),
	('SP0010',N'Cafe sữa',8000,15000,'46',N'Ly','LSP007','NCC003'),
	('SP0011',N'Kẹo chupa chups',1000,3000,'15',N'Cây','LSP002','NCC001'),
	('SP0012',N'Mỳ SiuKay vị bò',8000,13000,'10',N'Gói','LSP008','NCC004'),
	('SP0013',N'Tokbokki vị phô mai',10000,20000,'50',N'Hộp','LSP008','NCC005'),
	('SP0014',N'Cơm nắm vị phô mai',10000,15000,'14',N'Cái','LSP003','NCC004'),
	('SP0015',N'Cafe đen',5000,15000,'7',N'Ly','LSP007','NCC003'),
	('SP0016',N'Kẹo dẻo',1000,3000,'20',N'Cây','LSP002','NCC001'),
	('SP0017',N'Mỳ SiuKay hải sản',8000,13000,'10',N'Gói','LSP008','NCC004'),
	('SP0018',N'Tokbokki truyền thống',10000,25000,'50',N'Hộp','LSP008','NCC005'),
	('SP0019',N'Nước suối',2000,10000,'20',N'Chai','LSP005','NCC002'),
	('SP0020',N'Bánh Oishi cua',3000,8000,'10',N'Bịch','LSP001','NCC001'),
	('SP0021',N'Tranh tô màu',1000,15000,'40',N'Cái','LSP010','NCC006')
go

---Bảng Hóa đơn
	insert into HoaDon values 
	 ('HD0001','2023-03-24',N'Tiền mặt','NV0001','KH0016'),
	 ('HD0002','2023-02-02',N'Tiền mặt','NV0002','KH0015'),
	 ('HD0003','2023-03-15',N'Chuyển khoản','NV0003','KH0014'),
	 ('HD0004','2023-01-26',N'Tiền mặt','NV0004','KH0013'),
	 ('HD0005','2023-04-10',N'Chuyển khoản','NV0006','KH0012')
go

-- Bảng CTHoaDon
	insert into CTHoaDon values 
	 ('HD0001','SP0001','3','15000'),
	 ('HD0002','SP0012','2','13000'),
	 ('HD0003','SP0016','2','3000'),
	 ('HD0004','SP0002','1','15000'),
	 ('HD0005','SP0009','5','15000')
go

-- Bảng PhieuNhap
	insert into PhieuNhap values
	('PN0001','2022-02-24','NV0001','NCC001'),
	('PN0002','2023-01-04','NV0008','NCC002'),
	('PN0003','2022-05-02','NV0004','NCC003'),
	('PN0004','2022-08-03','NV0007','NCC004'),
	('PN0005','2022-12-08','NV0009','NCC005'),
	('PN0006','2023-01-16','NV0003','NCC006')

go

-- Bảng CTPhieuNhap
	insert into CTPhieuNhap values 
	('PN0001','SP0007','80','5000'),
	('PN0002','SP0019','50','1000'),
	('PN0003','SP0001','100','5000'),
	('PN0004','SP0014','50','4000'),
	('PN0005','SP0018','10','3000'),
	('PN0006','SP0021','10','1000')

	-------------------------BÀI TẬP -----------------
--1. Synonym
--a) Tạo tên đồng nghĩa cho bảng NhaCungCap
Create synonym NCC
For NhaCungCap
--kiểm thử tạo tên đồng nghĩa cho bảng NhaCungCap
Select * from NCC
--b) Tạo tên đồng nghĩa cho bảng CTPhieuNhap
Create synonym CTPN
For CTPhieuNhap
--kiểm thử tạo tên đồng nghĩa cho bảng CTPhieuNhap
Select * from CTPN


--2. Index
	--a)Tạo chỉ mục có tên bất kỳ trên cột tên loại sản phẩm của bảng loại sản phẩm
	create index TenLoaiSP_LoaiSanPham_idx
	on LoaiSP (TenLoaiSP)
	--Kiểm thử tạo chỉ mục có tên bất kỳ trên cột tên loại sản phẩm của bảng loại sản phẩm
	select TenLoaiSP
	from LoaiSP


	--b)Tạo chỉ mục cho cột họ tên nhân viên trong bảng với điều kiện giới tính là nam.
	Create index NV_HoTenNV_idx
	on NhanVien (HoTenNV)
	where GioiTinh = N'Nam'
	--Kiểm thử tạo chỉ mục cho cột họ tên nhân viên trong bảng với điều kiện giới tính là nam.
	select HoTenNV
	from NhanVien
	where GioiTinh = N'Nam'
	order by HoTenNV
	
	--c)Tạo chỉ mục cho tên sản phẩm trong bảng với điều kiện nhà cung cấp trà sửa hàn quốc
	Create index SP_TenSP_idx
	on SanPham (TenSP)
	where MaNCC= N'NCC002'
	--Kiểm tra tạo chỉ mục cho tên sản phẩm trong bảng với điều kiện nhà cung cấp trà sửa hàn quốc
	select TenSP, TenNCC
	from SanPham sp join
			NhaCungCap ncc on ncc.MaNCC=sp.MaNCC
	where ncc.MaNCC= N'NCC002'

--3. View
--a) Tạo view vwSoLuongNhap với các thông tin: Tên sản phẩm, số lượng nhập và mã nhà cung cấp

Create view vwSoLuongNhap
AS
Select TenSP AS N'Tên sản phẩm', SUM(SLNhap) AS N'Số lượng nhập', NCC.MaNCC AS N'Mã nhà cung cấp'
From SanPham SP join CTPhieuNhap CTPN on SP.MaSP=CTPN.MaSP join NhaCungCap NCC on NCC.MaNCC = SP.MaNCC
Group by TenSP, NCC.MaNCC

-- Kiểm thử view vwSoLuongNhap
Select *
From vwSoLuongNhap

--b) Tạo view vwDoanhThuSanPham với các thông tin: Tên sản phẩm và doanh thu sản phẩm

Create view vwDoanhThuSanPham
AS
Select TenSP AS N'Tên sản phẩm',( CTHD.DgBan * SLBan ) AS N'Doanh thu sản phẩm'
From SanPham SP inner join CTHoaDon CTHD on SP.MaSP = CTHD.MaSP
Group by TenSP, CTHD.DgBan, SLBan

--Kiểm thử view vwDoanhThuSanPham
Select *
From vwDoanhThuSanPham

--c) Tạo view vwSanPhamNhapASC với các thông tin: Mã sản phẩm, tên sản phẩm, số lượng nhập tăng 

Create view vwSanPhamNhapASC
AS
select SP.MaSP, TenSP, MAX(SLNhap) AS N'Số lượng nhập tăng dần'
From SanPham SP inner join CTPhieuNhap CTPN on SP.MaSP = CTPN.MaSP
Group by SP.MaSP, TenSP, SLNhap

--Kiểm thử view vwSanPhamNhapASC

Select *
From vwSanPhamNhapASC

--d) Tạo view vwHoaDonThang3 với các thông tin: Mã hóa đơn, ngày lập hóa đơn vào tháng 3

Create view vwHoaDonThang3
AS
Select MaHD, NgayLapHD
From HoaDon HD
Where MONTH(NgayLapHD) = 3
Group by MaHD, NgayLapHD

--kiểm thử
Select * 
From vwHoaDonThang3




--4. Stored Procedure
	--a)Cho biết hóa đơn có giá trị lớn nhất
	Create proc sp_top1HD
	as
	select distinct top (1) with ties hd.MaHD, NgayLapHD, PTTT,HoTenKH, sum(SLBan*DgBan) as ThanhTien
	from HoaDon hd join 
			CTHoaDon cthd on hd.MaHD=cthd.MaHD join
			KhachHang kh on kh.MaKH=hd.MaKH
	group by hd.MaHD, NgayLapHD, PTTT, HoTenKH
	order by ThanhTien 
	--Kiem tra
	EXEC sp_top1HD

	--b)Xem thông tin khách hàng với mã khách hàng do người dùng nhập 
	Create proc sp_ttKhachHang @Makh nvarchar(6)
	as
	select *
	from KhachHang
	where @Makh=MaKH

	--Kiem tra
	exec sp_ttKhachHang 'KH0005'

	--c)Xem số lượng tồn của một san pham, số lượng tồn > 0 thì thông báo còn hàng, 
		--ngươc lại thông báo hết hàng, với mã san pham do người dùng nhập.
	Create proc sp_slton @Masp nvarchar(6)
	as
	declare @Soluongton int
	select @Soluongton=SLTon
	from SanPham
	Where MaSP=@Masp
	if @Soluongton>0
		Begin 
		print N'Còn hàng'
		print N'Số lượng tồn là: '+cast (@SoLuongTon as nvarchar(10))
		end 
	else print N'Hết hàng'

	--Kiem tra
	exec sp_slton 'SP00020'

	--d)Xem đơn giá bán một sản phẩm với mã sản phẩm do người dùng nhập.
	Create proc sp_DgBan_MaSP @Masp nvarchar(6)
	as
	select MaSP, TenSP, DgBan
	from SanPham
	where MaSP=@Masp

	--Kiem tra
	exec sp_DgBan_MaSP 'SP0009'


	--e)Tạo thủ tục thêm mới loại sản phẩm 
	Create proc sp_insert_LoaiSP (@malsp nvarchar(6),@tenlsp nvarchar(6))
	as
	if exists (select *
				from LoaiSP
				where MaLoaiSP=@malsp)
				begin transaction 
				insert into LoaiSP (MaLoaiSP,TenLoaiSP) values (@malsp, @tenlsp)
				commit transaction
				if @@error <>0
				rollback transaction

				---kiem tra
				exec sp_insert_LoaiSP 'LSP007','Trái cây'


	--f)Tạo thủ tục xóa một nhân viên với tham số truyền vào là mã nhân viên
	Create proc sp_delete_nhanvien (@Manv nvarchar (6))
	as
	if exists (select *
				from NhanVien
				where MaNV=@Manv)
				begin transaction 
				delete from NhanVien
				where MaNV=@Manv
				commit transaction 
				if @@error <>0 
				rollback transaction 

				---kiem tra
				exec sp_delete_nhanvien 'NV0050'



	--g) Tạo thủ tục cập nhật ngày nhập của phiếu nhập 
		--với tham số truyền vào là số phiếu nhập và ngày nhập cần cập nhật
		create proc sp_update_phieunhap (@mapn nvarchar (6), @Ngaynhap date, 
										@manv nvarchar(6), @Mancc nvarchar(6))
		AS
		if exists ( select *
					from PhieuNhap 
					where @mapn=MaPN)
					begin transaction 
					update PhieuNhap
					set NgayNhap=@Ngaynhap, MaNV=@manv, MaNCC=@Mancc
					where MaPN=@mapn
					COMMIT Transaction 
				if @@ERROR <>0
				rollback transaction 

				--Kiem tra
				exec sp_update_phieunhap 'PN0006','2023-03-16','NV0024','NCC005'


--5. Function
--a) Viết hàm Function tính tiền lãi sản phẩm
Create Function Lai_SP ()
returns table
AS
return( select CTHD.MaSP, sum((CTHD.DgBan-DgNhap)*SLBan) as TienLai
from CTHoaDon CTHD inner join CTPhieuNhap CTPN on CTHD.MaSP = CTPN.MaSP
group by CTHD.MaSP)
-- thực thi
select * from Lai_SP()

--b) Tạo hàm Function tính số lượng tồn theo sản phẩm

	Create Function f_SlTonTheoSanPham (@MaSP nchar(6))  
	Returns int  
	As      
	Begin              
		Declare @SLT int             
		Select @SLT = sum(SLTon) 
		From SanPham              
		Where MaSP=@MaSP         
		Return @SLT      
	End   


-- Kiểm tra
Select [dbo].[f_SlTonTheoSanPham]('SP0001')


--6. Trigger
	--a) Số lượng tồn của ản phẩm phải lớn hơn hoặc bằng 0
		create trigger TG_soluongton
		on SanPham
		for insert, update 
		as
		if exists (select *
					from inserted
					where inserted.SLTon <0)
		begin 
			print (N'So luong ton phai lon hon hoac bang 0')
			rollback tran
		end 

		--kiem tra
		insert into SanPham values ('SP0022',N'Đồ chơi lắp ráp',50000,70000,'2','Bộ','LSP010','NCC006')--đúng
		insert into SanPham values ('SP0022',N'Đồ chơi lắp ráp',50000,70000,'-2','Bộ','LSP010','NCC006')--sai

	--b) Tự động cập nhật lại số lượng tồn của sản phẩm khi có sản phẩm được bán ra
		create trigger TG_CapnhatSLTon_BanSP
		on CTHoaDon
		for Insert
		as
		begin
			update SanPham
			set SLTon=SLTon-inserted.SLBan
			from SanPham join inserted on SanPham.MaSP=inserted.MaSP
		end
		--Kiem tra
		insert into CTHoaDon values ('HD0005','SP0021','2',15000)
drop trigger TG_CapnhatSLTon_BanSP

	--c) Tự động cập nhật số lượng tồn sản phẩm khi khi bi huy hoa don
		create trigger TG_CapnhatSLTon_HuyHD
		on CTHoaDon
		for delete 
		as
		begin 
			update SanPham
			set SLTon=SLTon + (select SLBan from deleted where MaSP=SanPham.MaSP)
			from SanPham join deleted on SanPham.MaSP=deleted.MaSP
		end
		--Kiem tra
		delete from CTHoaDon where MaHD='HD0005'
drop trigger TG_CapnhatSLTon_HuyHD 


--7. User cấp nhân viên bán hàng

CREATE LOGIN nhanvienbanhang with password = '123456',
default_database = QuanLyBanHangGS25



-- cấp quyền
Grant select, insert,delete, update on CTHoaDon to nhanvienbanhang
Grant select, insert,delete, update on HoaDon to nhanvienbanhang
Grant select, insert,delete, update on KhachHang to nhanvienbanhang

-- kiểm tra
select *
from KhachHang

--User cấp nhân viên kiểm kho
CREATE LOGIN nhanvienkiemkho with password = '123456',
default_database = QuanLyBanHangGS25

create user QuanLyGS25 for login nhanvienkiemkho
--cấp quyền
Grant select, insert,delete, update on LoaiSP to nhanvienkiemkho
Grant select, insert,delete, update on NhaCungCap to nhanvienkiemkho
Grant select, insert,delete, update on PhieuNhap to nhanvienkiemkho
Grant select, insert,delete, update on SanPham to nhanvienkiemkho
