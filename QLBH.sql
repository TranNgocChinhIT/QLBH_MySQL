CREATE SCHEMA QLBH;
USE QLBH;

CREATE TABLE DANHMUC (
  DANHMUCID VARCHAR(8)PRIMARY KEY,
  TENDANHMUC VARCHAR(50) NOT NULL,
  MOTA VARCHAR(100) NOT NULL
);

CREATE TABLE NHACUNGCAP (
  NCCID VARCHAR(8) PRIMARY KEY,
  TENNCC VARCHAR(50) NOT NULL,
  DIACHI VARCHAR(100) NOT NULL,
  SDT VARCHAR(10) NOT NULL,
  TRANGTHAICC VARCHAR(50) NOT NULL,
  TENNHASX VARCHAR(50) NOT NULL
);

CREATE TABLE MAGIAMGIA (
  MAGG VARCHAR(8) PRIMARY KEY,
  CODE VARCHAR(8) NOT NULL,
  MOTA VARCHAR(20) NOT NULL,
  BATDAU DATE NOT NULL,
  KETTHUC DATE NOT NULL,
  MASP VARCHAR(8) NOT NULL
);

CREATE TABLE SANPHAM (
  MASP VARCHAR(8) PRIMARY KEY,
  TENSP VARCHAR(50) NOT NULL,
  SOLUONG INT NOT NULL,
  GIA DECIMAL(18,2) NOT NULL,
  LUOTXEM INT NOT NULL,
  MOTA VARCHAR(100) NOT NULL,
  TRANGTHAISP VARCHAR(50) NOT NULL,
  MADM VARCHAR(8) NOT NULL,
  NCCID VARCHAR(8) NOT NULL
);

CREATE TABLE DONHANG (
  MADH VARCHAR(8) PRIMARY KEY,
  TRIGIA DECIMAL(18,2) ,
  TRANGTHAIDH VARCHAR(50) NOT NULL,
  NGAYDATDONHANG DATE NOT NULL,
  MAKH VARCHAR(8)
);

CREATE TABLE QLDH (
  MADH VARCHAR(8),
  MASP VARCHAR(8),
  SL INT ,
  CONSTRAINT pk_QLDH PRIMARY KEY (MADH, MASP)
);

CREATE TABLE THANHTOAN (
  MATT VARCHAR(8)  PRIMARY KEY,
  MAGIAODICH VARCHAR(50) NOT NULL,
  TONGTIEN DECIMAL(18,2) ,
  TENPHUONGTHUCTT VARCHAR(50) NOT NULL,
  TRANGTHAITHANHTOAN VARCHAR(50),
  NGAYTHANHTOAN DATE ,
  MAKH VARCHAR(8) NOT NULL,
  MADH VARCHAR(8) NOT NULL,
  MAVC VARCHAR(8) 
);
CREATE TABLE VANCHUYEN (
  MAVC VARCHAR(8)  PRIMARY KEY,
  TENPHUONGTHUCVC VARCHAR(50) ,
  TRANGTHAIVANCHUYEN VARCHAR(50) ,
  NGAYVANCHUYEN DATE ,
  MESSAGE VARCHAR(100) 
);

CREATE TABLE KHACHHANG (
  MAKH VARCHAR(8)  PRIMARY KEY,
  TENKH VARCHAR(50) NOT NULL,
  NGAYSINH DATE NOT NULL,
  GIOITINH VARCHAR(10) NOT NULL,
  EMAIL VARCHAR(50) NOT NULL,
  SDT VARCHAR(10) NOT NULL,
  DIACHI VARCHAR(100) NOT NULL
);

CREATE TABLE PHANHOI (
  MAPH VARCHAR(8) PRIMARY KEY,
  NGAYPHANHOI DATE ,
  TIEUDEPHANHOI VARCHAR(100) ,
  NOIDUNGPHANHOI VARCHAR(500) ,
  TRALOIPHANHOI VARCHAR(500) ,
  TRANGTHAIPHANHOI VARCHAR(50) ,
  MAKH VARCHAR(8) NOT NULL,
  MASP VARCHAR(8) NOT NULL
);

CREATE TABLE TAIKHOAN(
  MATK VARCHAR(8) PRIMARY KEY,
  TENDANGNHAP VARCHAR(50) NOT NULL,
  MATKHAU VARCHAR(50) NOT NULL,
  MAPQ VARCHAR(8) NOT NULL
);

CREATE TABLE PHANQUYEN(
  MAPQ VARCHAR(8) PRIMARY KEY,
  VAITRO VARCHAR(50) NOT NULL
);
-- Ràng buộc các giá trị của trường dữ liệu trong bảng--
	-- Bảng DONHANG --
		-- TRIGIA < 0 --
        ALTER TABLE DONHANG ADD CONSTRAINT check_trigia CHECK (TRIGIA > 0);
    -- Bảng MAGIAMGIA --
		-- BATDAU < KETTHUC --
		ALTER TABLE MAGIAMGIA ADD CONSTRAINT check_batdau_ketthuc CHECK (DATEDIFF(KETTHUC,BATDAU) > 0 );
	-- Bảng SANPHAM --
        -- GIA > 0 --
        ALTER TABLE SANPHAM ADD CONSTRAINT check_gia CHECK (GIA > 0 );
        -- LUOTXEM >=0 --
		ALTER TABLE SANPHAM ADD CONSTRAINT check_luotxem CHECK (LUOTXEM >= 0 );
-- Thêm khóa ngoại cho bảng SANPHAM

ALTER TABLE SANPHAM
ADD CONSTRAINT fk_SANPHAM_NHACUNGCAP
FOREIGN KEY (NCCID)
REFERENCES NHACUNGCAP(NCCID);

ALTER TABLE SANPHAM
ADD CONSTRAINT fk_SANPHAM_DANHMUC
FOREIGN KEY (MADM)
REFERENCES DANHMUC(DANHMUCID);

-- Thêm khóa ngoại cho bảng QLDH
ALTER TABLE QLDH
ADD CONSTRAINT fk_QLDH_DONHANG
FOREIGN KEY (MADH)
REFERENCES DONHANG(MADH);

ALTER TABLE QLDH
ADD CONSTRAINT fk_QLDH_SANPHAM
FOREIGN KEY (MASP)
REFERENCES SANPHAM(MASP);

-- Thêm khóa ngoại cho bảng THANHTOAN
ALTER TABLE THANHTOAN
ADD CONSTRAINT fk_THANHTOAN_KHACHHANG
FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH);

ALTER TABLE THANHTOAN
ADD CONSTRAINT fk_THANHTOAN_DONHANG
FOREIGN KEY (MADH)
REFERENCES DONHANG(MADH);

ALTER TABLE THANHTOAN
ADD CONSTRAINT fk_THANHTOAN_VANCHUYEN
FOREIGN KEY (MAVC)
REFERENCES VANCHUYEN(MAVC);

-- Thêm khóa ngoại cho bảng PHANHOI
ALTER TABLE PHANHOI
ADD CONSTRAINT fk_PHANHOI_SANPHAM
FOREIGN KEY (MASP)
REFERENCES SANPHAM(MASP);

ALTER TABLE PHANHOI
ADD CONSTRAINT fk_PHANHOI_KHACHHANG
FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH);

-- Thêm khóa ngoại cho bảng TAIKHOAN
ALTER TABLE TAIKHOAN
ADD CONSTRAINT fk_TAIKHOAN_PHANQUYEN
FOREIGN KEY (MAPQ)
REFERENCES PHANQUYEN(MAPQ);

-- Thêm khóa ngoại cho bảng MAGIAMGIA
ALTER TABLE MAGIAMGIA
ADD CONSTRAINT fk_MAGIAMGIA_SANPHAM
FOREIGN KEY (MASP)
REFERENCES SANPHAM(MASP);
-- Thêm khóa ngoại cho bảng DONHANG
ALTER TABLE DONHANG
ADD CONSTRAINT fk_DONHANG_KHACHHANG
FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH);

-- Thêm dữ liệu mẫu vào bảng PHANQUYEN
INSERT INTO PHANQUYEN (MAPQ, VAITRO) 
VALUES	('PQ001', 'Admin'),
		('PQ002', 'Nhân viên'),
		('PQ003', 'Khách hàng');
-- Thêm dữ liệu mẫu vào bảng TAIKHOAN
INSERT INTO TAIKHOAN (MATK, TENDANGNHAP, MATKHAU, MAPQ)
VALUES ('TK001', 'user1', 'pass1', 'PQ001'),
       ('TK002', 'user2', 'pass2', 'PQ002');
-- Thêm dữ liệu mẫu bảng DANH MỤC 
INSERT INTO DANHMUC (DANHMUCID, TENDANHMUC, MOTA)
VALUES ('DM001', 'Iphone', 'Điện thoại Iphone'),
       ('DM002', 'Samsung', 'Điện thoại Samsung'),
       ('DM003', 'Xiaomi', 'Điện thoại Xiaomi'),
       ('DM004', 'Huawei', 'Điện thoại Huawei'),
       ('DM005', 'OPPO', 'Điện thoại OPPO'),
       ('DM006', 'Vivo', 'Điện thoại Vivo'),
       ('DM007', 'Realme', 'Điện thoại Realme');
INSERT INTO NHACUNGCAP (NCCID, TENNCC, DIACHI, SDT, TRANGTHAICC, TENNHASX) VALUES 
    ('NCC001', 'Apple Supplier', 'Địa chỉ nhà cung cấp Apple', '0123456789', 'Hoạt động', 'Apple'),
    ('NCC002', 'Samsung Supplier', 'Địa chỉ nhà cung cấp Samsung', '0123456789', 'Hoạt động', 'Samsung'),
    ('NCC003', 'Xiaomi Supplier', 'Địa chỉ nhà cung cấp Xiaomi', '0123456789', 'Hoạt động', 'Xiaomi'),
    ('NCC004', 'Huawei Supplier', 'Địa chỉ nhà cung cấp Huawei', '0123456789', 'Hoạt động', 'Huawei'),
    ('NCC005', 'OPPO Supplier', 'Địa chỉ nhà cung cấp OPPO', '0123456789', 'Hoạt động', 'OPPO'),
    ('NCC006', 'Vivo Supplier', 'Địa chỉ nhà cung cấp Vivo', '0123456789', 'Hoạt động', 'Vivo'),
    ('NCC007', 'Realme Supplier', 'Địa chỉ nhà cung cấp Realme', '0123456789', 'Hoạt động', 'Realme');
-- Thêm dữ liệu mẫu bảng SẢN PHẨM
INSERT INTO SANPHAM (MASP, TENSP, SOLUONG, GIA, LUOTXEM, MOTA, TRANGTHAISP, MADM, NCCID) VALUES 
    ('SP001', 'Iphone 12', 10, 15000000, 100, 'Điện thoại Iphone 12', 'Còn hàng', 'DM001', 'NCC001'),
    ('SP002', 'Samsung Galaxy S21', 8, 12000000, 80, 'Điện thoại Samsung Galaxy S21', 'Còn hàng', 'DM002', 'NCC002'),
    ('SP003', 'Xiaomi Redmi Note 10 Pro', 12, 8000000, 70, 'Điện thoại Xiaomi Redmi Note 10 Pro', 'Còn hàng', 'DM003', 'NCC003'),
    ('SP004', 'Huawei P40 Pro', 5, 10000000, 50, 'Điện thoại Huawei P40 Pro', 'Hết hàng', 'DM004', 'NCC004'),
    ('SP005', 'OPPO Reno5', 15, 7000000, 120, 'Điện thoại OPPO Reno5', 'Còn hàng', 'DM005', 'NCC005'),
    ('SP006', 'Vivo V21', 3, 9000000, 30, 'Điện thoại Vivo V21', 'Còn hàng', 'DM006', 'NCC006'),
    ('SP007', 'Realme 8 Pro', 6, 6000000, 60, 'Điện thoại Realme 8 Pro', 'Còn hàng', 'DM007', 'NCC007'),
    ('SP008', 'Iphone 11', 7, 13000000, 90, 'Điện thoại Iphone 11', 'Còn hàng', 'DM001', 'NCC001'),
    ('SP009', 'Samsung Galaxy A52', 9, 9000000, 75, 'Điện thoại Samsung Galaxy A52', 'Còn hàng', 'DM002', 'NCC002'),
    ('SP010', 'Xiaomi Redmi 9', 6, 4000000, 60, 'Điện thoại Xiaomi Redmi 9', 'Còn hàng', 'DM003', 'NCC003'),
    ('SP011', 'Huawei Nova 7i', 4, 7000000, 40, 'Điện thoại Huawei Nova 7i', 'Hết hàng', 'DM004', 'NCC004'),
    ('SP012', 'OPPO A54', 12, 5000000, 100, 'Điện thoại OPPO A54', 'Còn hàng', 'DM005', 'NCC005'),
    ('SP013', 'Vivo Y20s', 8, 3500000, 80, 'Điện thoại Vivo Y20s', 'Còn hàng', 'DM006', 'NCC006'),
    ('SP014', 'Realme C25', 10, 3000000, 95, 'Điện thoại Realme C25', 'Còn hàng', 'DM007', 'NCC007'),
    ('SP015', 'Iphone SE', 3, 8000000, 45, 'Điện thoại Iphone SE', 'Hết hàng', 'DM001', 'NCC001');
-- Thêm dữ liệu mẫu vào bảng MAGIAMGIA
INSERT INTO MAGIAMGIA (MAGG, CODE, MOTA, BATDAU, KETTHUC, MASP) VALUES 
    ('MG001', 'SALE20', 'Giảm 20%', '2023-06-01', '2023-06-30', 'SP001'),
    ('MG002', 'SALE10', 'Giảm 10%', '2023-06-15', '2023-06-25', 'SP001'),
    ('MG003', 'SUMMER30', 'Giảm 30%', '2023-07-01', '2023-07-31', 'SP002'),
    ('MG004', 'SALE15', 'Giảm 15%', '2023-06-20', '2023-07-05', 'SP006'),
    ('MG005', 'FLASH50', 'Giảm 50k', '2023-06-25', '2023-06-26', 'SP004'),
    ('MG006', 'SALE10', 'Giảm 10%', '2023-06-01', '2023-06-30', 'SP005');
-- Thêm dữ liệu mẫu bảng KHACHHANG
INSERT INTO KHACHHANG (MAKH, TENKH, NGAYSINH, GIOITINH, EMAIL, SDT, DIACHI) VALUES 
    ('KH001', 'Nguyễn Văn A', '1990-01-01', 'Nam', 'nguyenvana@gmail.com', '0123456789', 'Số 25, Đường Chơn Tâm 9, Phường Hòa Minh, Quận Liên Chiểu, TP Đà Nẵng'),
    ('KH002', 'Nguyễn Thị B', '1995-02-15', 'Nữ', 'nguyenthib@gmail.com', '0987654321', 'Số 30, Đường Nguyễn Văn Bình, Phường Đa Kao, Quận 1, TP Hồ Chí Minh'),
    ('KH003', 'Trần Văn C', '1988-07-10', 'Nam', 'tranvanc@gmail.com', '0909090909', 'Số 12, Đường Hàng Đậu, Phường Cửa Đông, Quận Hoàn Kiếm, TP Hà Nội'),
    ('KH004', 'Lê Thị D', '1992-04-20', 'Nữ', 'lethid@gmail.com', '0912345678', 'Số 8, Đường Nguyễn Văn Linh, Phường Bình Thuận, Quận 7, TP Hồ Chí Minh'),
    ('KH005', 'Phạm Văn E', '1998-11-05', 'Nam', 'phamvane@gmail.com', '0888888888', 'Số 5, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, TP Hồ Chí Minh'),
    ('KH006', 'Hoàng Thị F', '1993-09-25', 'Nữ', 'hoangthif@gmail.com', '0977777777', 'Số 18, Đường Võ Văn Kiệt, Phường Thắng Nhất, Quận Sơn Trà, TP Đà Nẵng'),
    ('KH007', 'Vũ Văn G', '1991-06-12', 'Nam', 'vuvang@gmail.com', '0866666666', 'Số 7, Đường Trần Hưng Đạo, Phường Quang Trung, Quận Hồng Bàng, TP Hải Phòng'),
    ('KH008', 'Nguyễn Văn H', '1994-03-18', 'Nam', 'nguyenvanh@gmail.com', '0944444444', 'Số 9, Đường Trường Sa, Phường Mỹ An, Quận Ngũ Hành Sơn, TP Đà Nẵng'),
    ('KH009', 'Trần Thị I', '1997-12-05', 'Nữ', 'tranthii@gmail.com', '0969696969', 'Số 14, Đường Trần Phú, Phường Lộc Thọ, Quận Ninh Kiều, TP Cần Thơ');
-- Thêm dữ liệu mẫu vào bảng PHANHOI
INSERT INTO PHANHOI (MAPH, NGAYPHANHOI, TIEUDEPHANHOI, NOIDUNGPHANHOI, TRALOIPHANHOI, TRANGTHAIPHANHOI, MAKH, MASP) VALUES 
    ('PH001', '2023-06-05', 'Góp ý sản phẩm', 'Sản phẩm chất lượng tốt', 'Cảm ơn quý khách đã góp ý', 'Đã trả lời', 'KH001', 'SP004'),
    ('PH002', '2023-06-06', 'Khiếu nại dịch vụ', 'Giao hàng chậm', 'Chúng tôi sẽ cố gắng cải thiện', 'Chưa trả lời', 'KH002', 'SP007'),
    ('PH003', '2023-06-07', 'Yêu cầu hỗ trợ', 'Tôi cần hướng dẫn sử dụng sản phẩm', 'Chúng tôi sẽ cung cấp hỗ trợ chi tiết', 'Chưa trả lời', 'KH003', 'SP012'),
    ('PH004', '2023-06-08', 'Khiếu nại sản phẩm', 'Sản phẩm bị lỗi', 'Chúng tôi sẽ tiếp nhận và xử lý', 'Chưa trả lời', 'KH004', 'SP015'),
    ('PH005', '2023-06-09', 'Góp ý dịch vụ', 'Nhân viên phục vụ không lịch sự', 'Chúng tôi sẽ cải thiện chất lượng dịch vụ', 'Chưa trả lời', 'KH005', 'SP009'),
    ('PH006', '2023-06-03', 'Góp ý sản phẩm', 'Sản phẩm chất lượng tạm được', 'Cảm ơn quý khách đã góp ý', 'Đã trả lời', 'KH005', 'SP004');
-- Thêm dữ liệu mẫu vào bảng DONHANG
INSERT INTO DONHANG (MADH, TRIGIA, TRANGTHAIDH, NGAYDATDONHANG, MAKH) VALUES 
    ('DH001', 42000000, 'Đã xác nhận', '2023-06-05', 'KH001'),
    ('DH002', 24000000, 'Đã xác nhận', '2023-06-06', 'KH003'),
    ('DH003', 45000000, 'Chưa xác nhận', '2023-06-07', 'KH003'),
    ('DH004', 7000000, 'Chưa xác nhận', '2023-06-08', 'KH002'),
    ('DH005', 20000000, 'Hoàn thành', '2023-06-28', 'KH001'),
    ('DH006', 27000000, 'Đã hủy', '2023-05-22', 'KH005'),
    ('DH007', 13000000, 'Đang xử lý', '2023-05-23', 'KH006'),
    ('DH008', 18000000, 'Đang xử lý', '2023-05-24', 'KH008'),
    ('DH009', 12000000, 'Đang giao hàng', '2023-05-25', 'KH007');
-- Thêm dữ liệu mẫu vào bảng VANCHUYEN
INSERT INTO VANCHUYEN (MAVC, TENPHUONGTHUCVC, TRANGTHAIVANCHUYEN, NGAYVANCHUYEN, MESSAGE)
VALUES 
    ('VC001', 'Giao hàng nhanh', 'Đang vận chuyển', '2023-06-01', 'Đơn hàng đang được vận chuyển'),
    ('VC002', 'Giao hàng tiết kiệm', 'Đã hủy', '2023-06-02', 'Đơn hàng đã bị hủy'),
    ('VC003', 'Giao hàng nhanh', 'Đã giao hàng', '2023-06-21', 'Đơn hàng đã được giao thành công');
-- Thêm dữ liệu mẫu vào bảng THANHTOAN
INSERT INTO THANHTOAN (MATT, MAGIAODICH, TONGTIEN, TENPHUONGTHUCTT, TRANGTHAITHANHTOAN, NGAYTHANHTOAN, MAKH, MADH, MAVC)
VALUES 
    ('TT001', 'GD001', 42000000, 'Thanh toán khi nhận hàng', 'Đang chờ thanh toán', NULL, 'KH001', 'DH001', NULL),
    ('TT002', 'GD002', 24000000, 'Thanh toán online', 'Đang chờ thanh toán', NULL, 'KH003', 'DH002', NULL),
    ('TT003', 'GD003', 45000000, 'Thanh toán khi nhận hàng', 'Chưa thanh toán', NULL, 'KH003', 'DH003', NULL),
    ('TT004', 'GD004', 7000000, 'Thanh toán online', 'Chưa thanh toán', NULL, 'KH002', 'DH004', NULL),
    ('TT005', 'GD005', 20000000, 'Thanh toán khi nhận hàng', 'Đã thanh toán', '2023-06-21', 'KH001', 'DH005', 'VC003'),
    ('TT006', 'GD006', 27000000, 'Thanh toán online', 'Đã hủy', '2023-06-22', 'KH005', 'DH006', 'VC002'),
    ('TT007', 'GD007', 13000000, 'Thanh toán khi nhận hàng', 'Đang chờ thanh toán', NULL, 'KH006', 'DH007', 'VC001');
-- Thêm dữ liệu mẫu vào bảng QLDH
INSERT INTO QLDH (MADH, MASP, SL) VALUES 
    ('DH001', 'SP001', 2),
    ('DH001', 'SP002', 1),
    ('DH002', 'SP003', 3),
    ('DH003', 'SP001', 1),
    ('DH003', 'SP004', 2),
    ('DH004', 'SP005', 1),
    ('DH005', 'SP011', 2),
    ('DH005', 'SP007', 1),
    ('DH006', 'SP009', 3),
    ('DH007', 'SP008', 1),
    ('DH008', 'SP006', 2),
    ('DH009', 'SP012', 1),
    ('DH009', 'SP013', 2);

select * from SANPHAM;

select * from KHACHHANG;

select * from DONHANG;

select * from DANHMUC;

select * from NHACUNGCAP;

select * from THANHTOAN;

select * from QLDH;

select * from PHANHOI;

select * from MAGIAMGIA;

select * from VANCHUYEN;

select * from PHANQUYEN;

select * from TAIKHOAN;

-- Stored Procedures ---------
-- Stored Procedures SỐ 1  ---------
-- Tìm kiếm thông tin khách hàng có MAVC, MATT,MAKH,SDT ----
DELIMITER //
CREATE PROCEDURE KiemTraThongTinKhachHang(
  IN p_MAVC VARCHAR(8),
  IN p_MATT VARCHAR(8),
  IN p_MAKH VARCHAR(8),
  IN p_SDT VARCHAR(10)
)
BEGIN
  DECLARE count INT DEFAULT 0;

  IF p_MAVC IS NOT NULL THEN
    SELECT COUNT(*) INTO count
    FROM KHACHHANG
    INNER JOIN THANHTOAN ON KHACHHANG.MAKH = THANHTOAN.MAKH
    INNER JOIN VANCHUYEN ON THANHTOAN.MAVC = VANCHUYEN.MAVC
    WHERE VANCHUYEN.MAVC = p_MAVC;
  ELSEIF p_MATT IS NOT NULL THEN
    SELECT COUNT(*) INTO count
    FROM KHACHHANG
    INNER JOIN THANHTOAN ON KHACHHANG.MAKH = THANHTOAN.MAKH
    WHERE THANHTOAN.MATT = p_MATT;
  ELSEIF p_MAKH IS NOT NULL THEN
    SELECT COUNT(*) INTO count
    FROM KHACHHANG
    WHERE KHACHHANG.MAKH = p_MAKH;
  ELSEIF p_SDT IS NOT NULL THEN
    SELECT COUNT(*) INTO count
    FROM KHACHHANG
    WHERE KHACHHANG.SDT = p_SDT;
  END IF;
  IF count > 0 THEN
	  IF p_MAVC IS NOT NULL THEN
		SELECT KHACHHANG.*
		FROM KHACHHANG
		INNER JOIN THANHTOAN ON KHACHHANG.MAKH = THANHTOAN.MAKH
		INNER JOIN VANCHUYEN ON THANHTOAN.MAVC = VANCHUYEN.MAVC
		WHERE VANCHUYEN.MAVC = p_MAVC;
	  ELSEIF p_MATT IS NOT NULL THEN
		SELECT KHACHHANG.*
		FROM KHACHHANG
		INNER JOIN THANHTOAN ON KHACHHANG.MAKH = THANHTOAN.MAKH
		WHERE THANHTOAN.MATT = p_MATT;
	  ELSEIF p_MAKH IS NOT NULL THEN
		SELECT KHACHHANG.*
		FROM KHACHHANG
		WHERE KHACHHANG.MAKH = p_MAKH;
	  ELSEIF p_SDT IS NOT NULL THEN
		SELECT KHACHHANG.*
		FROM KHACHHANG
		WHERE KHACHHANG.SDT = p_SDT;
	  END IF;
  ELSE
    SELECT 'Không có khách hàng hợp lệ.' AS Message;
  END IF;
END //
DELIMITER ;

------------------------------------------------------

DELIMITER //
CREATE PROCEDURE KiemTraThongTinKhachHangWrapper(
  IN p_MA VARCHAR(10)
)
BEGIN
  IF p_MA LIKE 'VC%' THEN
    CALL KiemTraThongTinKhachHang(p_MA,NULL,NULL,NULL);
  ELSEIF p_MA LIKE 'TT%' THEN
    CALL KiemTraThongTinKhachHang(NULL, p_MA,NULL,NULL);
  ELSEIF p_MA LIKE 'KH%' THEN
    CALL KiemTraThongTinKhachHang(NULL, NULL, p_MA,NULL);
  ELSEIF p_MA LIKE '0%' THEN
    CALL KiemTraThongTinKhachHang(NULL, NULL, NULL, p_MA);
  ELSE
    SELECT 'Vui lòng nhập ít nhất một tham số hợp lệ.' as Message;
  END IF;
END //
DELIMITER ;

-- thực thi 
CALL KiemTraThongTinKhachHangWrapper('VC004');  -- Không có khách hàng có mã vận chuyển hợp lệ.
CALL KiemTraThongTinKhachHangWrapper('TT001');-- Thành công vì có mã thanh toán hợp lệ
CALL KiemTraThongTinKhachHangWrapper('KH001'); -- call thành công
CALL KiemTraThongTinKhachHangWrapper('0888888888'); -- call thành công

select * from KHACHHANG ;
select * from THANHTOAN;
DROP PROCEDURE IF EXISTS KiemTraThongTinKhachHang;

-- Stored Procedures SỐ 2  ---------
-- kiểm tra thông tin vận chuyển của đơn hàng ----

DELIMITER //
CREATE PROCEDURE KiemTraThongTinVanChuyenDonHang(IN p_MADH VARCHAR(8))
BEGIN
  DECLARE count int DEFAULT 0;
  DECLARE v_MAVC VARCHAR(8);
  DECLARE v_TRANGTHAITHANHTOAN VARCHAR(50);
  DECLARE v_TRANGTHAIVANCHUYEN VARCHAR(50);
  
  SELECT COUNT(*) INTO count
  FROM DONHANG
  INNER JOIN THANHTOAN ON THANHTOAN.MADH = DONHANG.MADH
  WHERE THANHTOAN.MADH = p_MADH;
  -- Lấy thông tin vận chuyển và trạng thái thanh toán của đơn hàng
  SELECT THANHTOAN.MAVC, THANHTOAN.TRANGTHAITHANHTOAN, VANCHUYEN.TRANGTHAIVANCHUYEN
  INTO v_MAVC, v_TRANGTHAITHANHTOAN, v_TRANGTHAIVANCHUYEN
  FROM DONHANG
  LEFT JOIN THANHTOAN ON DONHANG.MADH = THANHTOAN.MADH
  LEFT JOIN VANCHUYEN ON THANHTOAN.MAVC = VANCHUYEN.MAVC
  WHERE DONHANG.MADH = p_MADH;
  IF count > 0 then
	  IF v_MAVC IS NOT NULL or v_TRANGTHAITHANHTOAN IS NOT NULL THEN
		SELECT 'Thông tin vận chuyển của đơn hàng:', v_MAVC AS MAVC, v_TRANGTHAITHANHTOAN AS TRANGTHAITHANHTOAN, v_TRANGTHAIVANCHUYEN AS TRANGTHAIVANCHUYEN;
	  END IF;
  ELSE
	  SELECT 'Mã đơn hàng không hợp lệ hoặc chưa được thanh toán.' AS Message;
  END IF;
END //
DELIMITER ;


-- thực thi 
select * from THANHTOAN;
CALL KiemTraThongTinVanChuyenDonHang('DH008'); -- mã đơn hàng chưa được thanh toán
CALL KiemTraThongTinVanChuyenDonHang('DH005'); -- tìm thành công 
DROP PROCEDURE IF EXISTS KiemTraThongTinVanChuyenDonHang;

-- Stored Procedures SỐ 3  ---------
-- lấy thông tin sản phẩm trong một danh mục cụ thể ----

DELIMITER //
CREATE PROCEDURE LayDanhSachSanPhamTrongDanhMuc(IN p_MADM VARCHAR(8))
BEGIN
   DECLARE count int DEFAULT 0;
   SELECT COUNT(*) INTO count
   FROM SANPHAM
   WHERE MADM = p_MADM;
   IF count > 0 then
	    SELECT *
		FROM SANPHAM
		WHERE SANPHAM.MADM = p_MADM;
  ELSE
	  SELECT 'Mã danh mục không hợp lệ.' AS Message;
  END IF;
END //
DELIMITER ;
-- thực thi 
select * from SANPHAM;
CALL LayDanhSachSanPhamTrongDanhMuc('DM0010'); -- Mã danh mục không hợp lệ
CALL LayDanhSachSanPhamTrongDanhMuc('DM001'); -- tìm thành công 
DROP PROCEDURE IF EXISTS LayDanhSachSanPhamTrongDanhMuc;

-- Stored Procedures SỐ 4  ---------
-- In ra danh sách các hóa đơn đã thanh toán và tổng tiền của các hóa đơn đó ----

DELIMITER //
CREATE PROCEDURE InDanhSachHoaDonDaThanhToan()
BEGIN
  -- In danh sách hóa đơn đã thanh toán
  SELECT DONHANG.MADH, DONHANG.TRANGTHAIDH, DONHANG.NGAYDATDONHANG, THANHTOAN.TONGTIEN
  FROM DONHANG
  INNER JOIN THANHTOAN ON DONHANG.MADH = THANHTOAN.MADH
  WHERE THANHTOAN.TRANGTHAITHANHTOAN = 'Đã thanh toán';

  -- Tính tổng tiền của các hóa đơn đã thanh toán
  SELECT 'Tổng doanh thu:' AS Message, SUM(THANHTOAN.TONGTIEN) AS TongDoanhThu
  FROM DONHANG
  INNER JOIN THANHTOAN ON DONHANG.MADH = THANHTOAN.MADH
  WHERE THANHTOAN.TRANGTHAITHANHTOAN = 'Đã thanh toán';
END //
DELIMITER ;

-- thực thi
select *from THANHTOAN ;
CALL InDanhSachHoaDonDaThanhToan();
DROP PROCEDURE IF EXISTS InDanhSachHoaDonDaThanhToan;


-- Stored Procedures SỐ 5  ---------
-- Hiển thị các thông tin như mã giảm giá, nhà cung cấp, phản hồi của khách hàng khi nhập MASP  ----

DELIMITER //
CREATE PROCEDURE HienThiThongTinSanPham(IN p_MASP VARCHAR(8))
BEGIN
  DECLARE v_TENNCC VARCHAR(50);
  DECLARE count INT DEFAULT 0;

  -- Kiểm tra sự tồn tại của sản phẩm
  SELECT COUNT(*) INTO count
  FROM SANPHAM
  WHERE MASP = p_MASP;

  IF count > 0 THEN
    -- Lấy tên nhà cung cấp của sản phẩm
    SELECT TENNCC INTO v_TENNCC
    FROM NHACUNGCAP
    WHERE NCCID = (SELECT NCCID FROM SANPHAM WHERE MASP = p_MASP);

    -- Hiển thị thông tin sản phẩm
    SELECT 'Thông tin sản phẩm:' AS ThongBao, p_MASP AS MASP, v_TENNCC AS TenNhaCungCap;

    -- Lấy thông tin mã giảm giá của sản phẩm
    SELECT 'Thông tin mã giảm giá:' AS ThongBao, MAGG, MOTA
    FROM MAGIAMGIA
    WHERE MASP = p_MASP;

    -- Lấy số lượng phản hồi của khách hàng khi nhập MASP
    SELECT COUNT(*) INTO count
    FROM PHANHOI
    WHERE MASP = p_MASP;

    IF count > 0 THEN
      -- Hiển thị thông tin phản hồi của khách hàng cho MASP đã cho
      SELECT 'Thông tin phản hồi khách hàng:' AS ThongBao, MAPH,TIEUDEPHANHOI, NOIDUNGPHANHOI,MAKH
      FROM PHANHOI
      WHERE MASP = p_MASP;
    ELSE
      SELECT 'Không có phản hồi.' AS ThongBao;
    END IF;

  ELSE
    SELECT 'Mã sản phẩm không hợp lệ.' AS ThongBao;
  END IF;
END //
DELIMITER ;


-- thực thi
select *from MAGIAMGIA;
select *from SANPHAM;
select *from PHANHOI;

CALL HienThiThongTinSanPham('SP004'); 
CALL HienThiThongTinSanPham('SP0040'); -- mã sản phẩm không hợp lệ


DROP PROCEDURE IF EXISTS HienThiThongTinSanPham;


-- TRIGGER cho bảng SANPHAM----------------------------
-- INSERT------------

DELIMITER $$
CREATE TRIGGER sanpham_insert
BEFORE INSERT ON SANPHAM
FOR EACH ROW
BEGIN

    -- Kiểm tra TENSP đã tồn tại trong bảng chưa

    IF EXISTS(SELECT 1 FROM SANPHAM WHERE TENSP = NEW.TENSP) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Sản phẩm đã tồn tại trong bảng.';
    END IF;
    
    -- SET TENSP phù hợp với MADM và NCCID 
    IF NEW.TENSP LIKE '%Iphone%' THEN
        SET NEW.MADM = 'DM001';
        SET NEW.NCCID = 'NCC001';
    ELSEIF NEW.TENSP LIKE '%Samsung%' THEN
        SET NEW.MADM = 'DM002';
        SET NEW.NCCID = 'NCC002';
    ELSEIF NEW.TENSP LIKE '%Xiaomi%' THEN
        SET NEW.MADM = 'DM003';
        SET NEW.NCCID = 'NCC003';
    ELSEIF NEW.TENSP LIKE '%Huawei%' THEN
        SET NEW.MADM = 'DM004';
        SET NEW.NCCID = 'NCC004';
    ELSEIF NEW.TENSP LIKE '%OPPO%' THEN
        SET NEW.MADM = 'DM005';
        SET NEW.NCCID = 'NCC005';
    ELSEIF NEW.TENSP LIKE '%Vivo%' THEN
        SET NEW.MADM = 'DM006';
        SET NEW.NCCID = 'NCC006';
    ELSEIF NEW.TENSP LIKE '%Realme%' THEN
        SET NEW.MADM = 'DM007';
        SET NEW.NCCID = 'NCC007';
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Vui lòng nhập lại Tên sản phẩm (TENSP). Tên sản phẩm không hợp lệ.';
    END IF;
        
    -- kiểm tra TRANGTHAISP, SOLUONGSP
    IF NEW.SOLUONG > 0 THEN
        SET NEW.TRANGTHAISP = 'Còn hàng';
    ELSEIF NEW.SOLUONG < 0 THEN
        SET NEW.TRANGTHAISP = 'Hết hàng';
        SET NEW.SOLUONG = 0;
    END IF;
    
	-- Tự động nhập MASP
	SET NEW.MASP = CONCAT('SP', LPAD((SELECT COUNT(*) FROM SANPHAM) + 1, 3, '0'));
    
    -- SET MOTA
	SET NEW.MOTA = CONCAT('Điện thoại ', NEW.TENSP);
END $$

-- UPDATE----------------

DELIMITER $$
CREATE TRIGGER sanpham_update
BEFORE UPDATE ON SANPHAM
FOR EACH ROW
BEGIN

    -- SET TENSP phù hợp với MADM và NCCID 
    IF NEW.TENSP LIKE '%Iphone%' THEN
        SET NEW.MADM = 'DM001';
        SET NEW.NCCID = 'NCC001';
    ELSEIF NEW.TENSP LIKE '%Samsung%' THEN
        SET NEW.MADM = 'DM002';
        SET NEW.NCCID = 'NCC002';
    ELSEIF NEW.TENSP LIKE '%Xiaomi%' THEN
        SET NEW.MADM = 'DM003';
        SET NEW.NCCID = 'NCC003';
    ELSEIF NEW.TENSP LIKE '%Huawei%' THEN
        SET NEW.MADM = 'DM004';
        SET NEW.NCCID = 'NCC004';
    ELSEIF NEW.TENSP LIKE '%OPPO%' THEN
        SET NEW.MADM = 'DM005';
        SET NEW.NCCID = 'NCC005';
    ELSEIF NEW.TENSP LIKE '%Vivo%' THEN
        SET NEW.MADM = 'DM006';
        SET NEW.NCCID = 'NCC006';
    ELSEIF NEW.TENSP LIKE '%Realme%' THEN
        SET NEW.MADM = 'DM007';
        SET NEW.NCCID = 'NCC007';
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Vui lòng nhập lại Tên sản phẩm (TENSP). Tên sản phẩm không hợp lệ.';
    END IF;
        
    -- kiểm tra TRANGTHAISP, SOLUONGSP
    IF NEW.SOLUONG > 0 THEN
        SET NEW.TRANGTHAISP = 'Còn hàng';
    ELSEIF NEW.SOLUONG < 0 THEN
        SET NEW.TRANGTHAISP = 'Hết hàng';
        SET NEW.SOLUONG = 0;
    END IF;

    -- Tự động nhập MOTA
    SET NEW.MOTA = CONCAT('Điện thoại ', NEW.TENSP);
END $$
DELIMITER ;

-- kiểm tra
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('apple', 2, 23000000, 50)-- TENSP không hợp lệ
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('iphone 12', 2, 23000000, 50)-- Sản phẩm đã có trong cơ sở dữ liệu
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('iphone 14', -2, 23000000, 50)-- Thêm thành công, TRANGTHAISP='hết hàng'
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('iphone 16', -2, -23000000, 50)-- Giá không được nhỏ hơn 0
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('iphone 16', -2, 23000000, -50)-- Lượt xem không được nhỏ hơn 0
INSERT INTO SANPHAM (TENSP, SOLUONG, GIA, LUOTXEM) VALUES ('iphone 15', 5, 23000000, 50)-- Thêm thành công, TRANGTHAISP='còn hàng'

select *from SANPHAM
drop trigger sanpham_update

-- Trigger cho bảng MAGIAMGIA --------------------------------------------

-- INSERT ---------------

DELIMITER $$
CREATE TRIGGER magiamgia_insert
BEFORE INSERT ON MAGIAMGIA
FOR EACH ROW
BEGIN
    DECLARE magg_exists INT;    
    DECLARE masp_exists INT;
	-- kiểm tra MASP có tồn tại không
    
    SET masp_exists = (SELECT COUNT(*) FROM SANPHAM WHERE MASP = NEW.MASP);
    IF masp_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã sản phẩm không tồn tại.';
    END IF;
	-- kiểm tra cặp CODE và MASP đã có trong bảng chưa
    
    SET magg_exists = (SELECT COUNT(*) FROM MAGIAMGIA WHERE CODE = NEW.CODE AND MASP = NEW.MASP);
    IF magg_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sản phẩm đã có CODE giảm giá này.';
    END IF;
    
    -- tự động nhập MAGG
    SET NEW.MAGG = CONCAT('MG', LPAD((SELECT COUNT(*) FROM MAGIAMGIA) + 1, 3, '0'));
END $$
DELIMITER ;
select * from MAGIAMGIA
INSERT INTO MAGIAMGIA (CODE, MOTA, KETTHUC,MASP) VALUES (  'SALE20','Giảm 20%', '2023-06-30','SP001')-- cặp CODE và MASP đã tồn tại trong bảng MAGIAMGIA
INSERT INTO MAGIAMGIA (CODE, MOTA, KETTHUC,MASP) VALUES (  'SALE20','Giảm 20%', '2023-09-19','SP020')-- Mã sản phẩm không tồn tại trong bảng SANPHAM
INSERT INTO MAGIAMGIA (CODE, MOTA, KETTHUC,MASP) VALUES (  'SALE20','Giảm 20%', '2023-09-19','SP006')-- Thêm thành công mã giảm giá cho SP006

delete from MAGIAMGIA where MAGG='MG007'

-- TRIGGER cho bảng DONHANG---------------------------------

DELIMITER $$
CREATE TRIGGER donhang_insert
BEFORE INSERT ON DONHANG
FOR EACH ROW
BEGIN
  DECLARE makh_count INT;
  
  -- Kiểm tra MAKH phải tồn tại
  SELECT COUNT(*) INTO makh_count
  FROM KHACHHANG
  WHERE MAKH = NEW.MAKH;
  
  IF makh_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MAKH không tồn tại.';
  END IF;

  -- Kiểm tra NGAYDATDONHANG không được lớn hơn ngày hiện tại
  IF NEW.NGAYDATDONHANG > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NGAYDATDONHANG không được lớn hơn hiện tại.';
  END IF;
  
  -- tự động nhập MADH
SET NEW.MADH = CONCAT('DH', LPAD((SELECT COUNT(*) FROM DONHANG) + 1, 3, '0'));

END $$
DELIMITER ;

-- UPDATE-----------------------------------

DELIMITER $$
CREATE TRIGGER donhang_update
BEFORE UPDATE ON DONHANG
FOR EACH ROW
BEGIN
  DECLARE makh_count INT;
DECLARE trangthai_thanhtoan VARCHAR(50);

  -- Kiểm tra MAKH phải tồn tại
  SELECT COUNT(*) INTO makh_count
  FROM KHACHHANG
  WHERE MAKH = NEW.MAKH;
  
  IF makh_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MAKH không tồn tại.';
  END IF;
  
    -- Kiểm tra NGAYDATDONHANG không được lớn hơn ngày hiện tại
  IF NEW.NGAYDATDONHANG > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NGAYDATDONHANG không được lớn hơn hiện tại.';
  END IF;
  
  -- Lưu trạng thái thanh toán hiện tại vào biến tạm
  SET trangthai_thanhtoan = (SELECT TRANGTHAITHANHTOAN FROM THANHTOAN WHERE MADH = NEW.MADH);
  
  -- Thực hiện câu lệnh UPDATE
  UPDATE THANHTOAN
  SET TRANGTHAITHANHTOAN = trangthai_thanhtoan
  WHERE MADH = NEW.MADH;
END $$
DELIMITER ;
drop trigger donhang_update
-- kiểm tra
INSERT INTO DONHANG (TRANGTHAIDH, NGAYDATDONHANG,MAKH)VALUES ('Đang giao hàng', '2023-06-01','KH011')-- MAKH không tồn tại
INSERT INTO DONHANG (TRANGTHAIDH, NGAYDATDONHANG,MAKH)VALUES ('Đang giao hàng', '2023-06-21','KH008')-- NGAYDATDONHANG 
INSERT INTO DONHANG (TRIGIA,TRANGTHAIDH, NGAYDATDONHANG,MAKH)VALUES (NULL,'Đang giao hàng', '2023-06-11','KH008')-- NGAYDATDONHANG 

select * from DONHANG
select * from THANHTOAN
select * from VANCHUYEN

-- TRIGGER cho bảng QLDH--------------------------------------

-- INSERT------------------------------

DELIMITER $$
CREATE TRIGGER qldh_insert
AFTER INSERT ON QLDH
FOR EACH ROW
BEGIN
    -- Cập nhật TRIGIA trong DONHANG
    UPDATE DONHANG
    SET TRIGIA = (
        SELECT SUM(SL * GIA)
        FROM QLDH
        INNER JOIN SANPHAM ON QLDH.MASP = SANPHAM.MASP
        WHERE QLDH.MADH = NEW.MADH
    )
    WHERE MADH = NEW.MADH;
END $$

-- UPDATE---------------------

DELIMITER $$
CREATE TRIGGER qldh_update
AFTER UPDATE ON QLDH
FOR EACH ROW
BEGIN
    -- Cập nhật TRIGIA trong DONHANG
    UPDATE DONHANG
    SET TRIGIA = (
        SELECT SUM(SL * GIA)
        FROM QLDH
        INNER JOIN SANPHAM ON QLDH.MASP = SANPHAM.MASP
        WHERE QLDH.MADH = OLD.MADH
    )
    WHERE MADH = OLD.MADH;
END $$

-- DELETE-------------------

DELIMITER $$
CREATE TRIGGER qldh_delete
AFTER DELETE ON QLDH
FOR EACH ROW
BEGIN
    -- Cập nhật TRIGIA trong DONHANG
    UPDATE DONHANG
    SET TRIGIA = (
        SELECT SUM(SL * GIA)
        FROM QLDH
        INNER JOIN SANPHAM ON QLDH.MASP = SANPHAM.MASP
        WHERE QLDH.MADH = OLD.MADH
    )
    WHERE MADH = OLD.MADH;
END $$
DELIMITER ;

-- kiểm tra
select * from SANPHAM;
select * from DONHANG;
select * from QLDH
	-- cập nhật lại TRIGIA
INSERT INTO QLDH (MADH, MASP, SL) VALUES ('DH004', 'SP011', 2)-- Thêm sản phẩm vào đơn hàng DH004
UPDATE QLDH SET SL=1 where MADH='DH009' and MASP='SP011' -- UPDATE thành công
DELETE from QLDH where MADH='DH004' and MASP='SP011' -- xóa thành công

-- TRIGGER cho bảng THANHTOAN-----------------------------------------------

-- INSERT--------------------------------

DELIMITER $$
CREATE TRIGGER thanhtoan_insert
BEFORE INSERT ON THANHTOAN
FOR EACH ROW
BEGIN
  DECLARE trangthai_thanhtoan VARCHAR(50);
  DECLARE NGAYDAT DATE;
  DECLARE TRANGTHAI VARCHAR(50);

  -- Kiểm tra NGAYTHANHTOAN không được nhỏ hơn NGAYDATDONHANG
  SET NGAYDAT = (SELECT NGAYDATDONHANG FROM DONHANG WHERE MADH = NEW.MADH);
  IF NEW.NGAYTHANHTOAN < NGAYDAT THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NGAYTHANHTOAN không được nhỏ hơn NGAYDATDONHANG.';
  END IF;

  -- Tính TONGTIEN từ TRIGIA
  SET NEW.TONGTIEN = (SELECT TRIGIA FROM DONHANG WHERE MADH = NEW.MADH);
  SET NEW.MAKH=(SELECT MAKH FROM DONHANG WHERE MADH = NEW.MADH);
  -- Tự động nhập TRANGTHAITHANHTOAN dựa trên TRANGTHAIDH và TENPHUONGTHUCTT
  SET TRANGTHAI = (SELECT TRANGTHAIDH FROM DONHANG WHERE MADH = NEW.MADH);
  IF TRANGTHAI = 'Đã xác nhận' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  ELSEIF TRANGTHAI = 'Chưa xác nhận' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  ELSEIF TRANGTHAI = 'Đang xử lí' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  ELSEIF TRANGTHAI = 'Đã hủy' THEN
    SET trangthai_thanhtoan = 'Đã hủy';
  ELSEIF TRANGTHAI = 'Hoàn thành' THEN
    SET trangthai_thanhtoan = 'Hoàn thành đơn hàng';
  ELSEIF TRANGTHAI = 'Đang giao hàng' AND NEW.TENPHUONGTHUCTT = 'Thanh toán online' THEN
    SET trangthai_thanhtoan = 'Đã thanh toán';
  ELSEIF TRANGTHAI = 'Đang giao hàng' AND NEW.TENPHUONGTHUCTT = 'Thanh toán khi nhận hàng' THEN
    SET trangthai_thanhtoan = 'Chưa thanh toán';
  END IF;
  
  -- Kiểm tra nếu TRANGTHAITHANHTOAN là 'Đã thanh toán' hoặc 'Hoàn thành' thì NGAYTHANHTOAN không được để null
  IF trangthai_thanhtoan = 'Đã thanh toán' OR trangthai_thanhtoan = 'Hoàn thành đơn hàng' THEN
    IF NEW.NGAYTHANHTOAN IS NULL THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đã thanh toán, hãy nhập NGAYTHANHTOAN.';
    END IF;
  END IF;

  SET NEW.TRANGTHAITHANHTOAN = trangthai_thanhtoan;
-- Kiểm tra nếu TRANGTHAITHANHTOAN là 'Đang giao hàng', thì MAVC không được để null
  IF trangthai_thanhtoan = 'Đang giao hàng' AND NEW.MAVC IS NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đang giao hàng, hãy nhập MAVC.';
  END IF;
  -- Tự động nhập MATT và MAGIAODICH
  SET NEW.MATT = CONCAT('TT', LPAD((SELECT COUNT(*) FROM THANHTOAN) + 1, 3, '0'));
  SET NEW.MAGIAODICH = CONCAT('GD', LPAD((SELECT COUNT(*) FROM THANHTOAN) + 1, 3, '0'));
END $$
DELIMITER ;

-- UPDATE----------------------------------

DELIMITER $$
CREATE TRIGGER thanhtoan_update
BEFORE UPDATE ON THANHTOAN
FOR EACH ROW
BEGIN
  DECLARE trangthai_thanhtoan VARCHAR(50);
  DECLARE NGAYDAT DATE;
  DECLARE TRANGTHAI VARCHAR(50);

  -- Kiểm tra NGAYTHANHTOAN không được nhỏ hơn NGAYDATDONHANG
  SET NGAYDAT = (SELECT NGAYDATDONHANG FROM DONHANG WHERE MADH = NEW.MADH);
  IF NEW.NGAYTHANHTOAN < NGAYDAT THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NGAYTHANHTOAN không được nhỏ hơn NGAYDATDONHANG.';
  END IF;

  -- Tính TONGTIEN từ TRIGIA
  SET NEW.TONGTIEN = (SELECT TRIGIA FROM DONHANG WHERE MADH = NEW.MADH);
  SET NEW.MAKH = (SELECT MAKH FROM DONHANG WHERE MADH = NEW.MADH);

  -- Tự động nhập TRANGTHAITHANHTOAN dựa trên TRANGTHAIDH và TENPHUONGTHUCTT
  SET TRANGTHAI = (SELECT TRANGTHAIDH FROM DONHANG WHERE MADH = NEW.MADH);
  IF TRANGTHAI = 'Đã xác nhận' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  ELSEIF TRANGTHAI = 'Chưa xác nhận' THEN
    SET trangthai_thanhtoan = 'Chưa thanh toán';
  ELSEIF TRANGTHAI = 'Đang xử lí' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  ELSEIF TRANGTHAI = 'Đã hủy' THEN
    SET trangthai_thanhtoan = 'Đã hủy';
  ELSEIF TRANGTHAI = 'Hoàn thành' THEN
    SET trangthai_thanhtoan = 'Hoàn thành đơn hàng';
  ELSEIF TRANGTHAI = 'Đang giao hàng' AND NEW.TENPHUONGTHUCTT = 'Thanh toán online' THEN
    SET trangthai_thanhtoan = 'Đã thanh toán';
  ELSEIF TRANGTHAI = 'Đang giao hàng' AND NEW.TENPHUONGTHUCTT = 'Thanh toán khi nhận hàng' THEN
    SET trangthai_thanhtoan = 'Chờ thanh toán';
  END IF;
  
  -- Kiểm tra nếu TRANGTHAITHANHTOAN là 'Đã thanh toán' hoặc 'Hoàn thành đơn hàng' thì NGAYTHANHTOAN không được để null
  IF trangthai_thanhtoan = 'Đã thanh toán' OR trangthai_thanhtoan = 'Hoàn thành đơn hàng' THEN
    IF NEW.NGAYTHANHTOAN IS NULL THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đã thanh toán, hãy nhập NGAYTHANHTOAN.';
    END IF;
  END IF;

  SET NEW.TRANGTHAITHANHTOAN = trangthai_thanhtoan;
  -- Kiểm tra nếu TRANGTHAITHANHTOAN là 'Đang giao hàng', thì MAVC không được để null
	IF trangthai_thanhtoan = 'Đang giao hàng' AND NEW.MAVC IS NULL THEN
	  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đang giao hàng, hãy nhập MAVC.';
	END IF;

END $$
DELIMITER ;

-- kiểm tra
INSERT INTO THANHTOAN (TENPHUONGTHUCTT, MADH, MAVC)VALUES ('Thanh toán khi nhận hàng', 'DH010', NULL);
update DONHANG
set TRANGTHAIDH='Hoàn Thành'
where MADH='DH001';

update THANHTOAN
set NGAYTHANHTOAN='2023-06-18'
where MADH='DH001';
select *from THANHTOAN;
select *from DONHANG;

-- Tạo logins (users)
CREATE USER 'quanly'@'localhost' IDENTIFIED WITH mysql_native_password BY '0000';
CREATE USER 'khachhang'@'localhost' IDENTIFIED WITH mysql_native_password BY '1000';
CREATE USER 'nhanvien'@'localhost' IDENTIFIED WITH mysql_native_password BY '1100';
CREATE USER 'vanchuyen'@'localhost' IDENTIFIED WITH mysql_native_password BY '1110';
-- Tạo roles
CREATE ROLE R1; -- quản lý
CREATE ROLE R2; -- khách hàng
CREATE ROLE R3; -- nhân viên 
CREATE ROLE R4; -- Nhân viên giao hàng
-- Gán roles cho users
GRANT R1 TO 'quanly'@'localhost';
GRANT R2 TO 'khachhang'@'localhost';
GRANT R3 TO 'nhanvien'@'localhost';
GRANT R4 TO 'vanchuyen'@'localhost';
-- Cấp quyền bổ sung cho quản lý
GRANT ALL PRIVILEGES ON qlbh.* TO R1 WITH GRANT OPTION ;
-- Cấp quyền bổ sung cho khách hàng
GRANT SELECT ON qlbh.danhmuc TO R2;-- cấp quyền truy vấn bảng DANHMUC
GRANT SELECT ON qlbh.magiamgia TO R2;-- cấp quyền truy vấn bảng MAGIAMGIA
GRANT SELECT ON qlbh.sanpham TO R2;-- cấp quyền truy vấn bảng SANPHAM

-- Cấp quyền bổ sung cho nhân viên
GRANT SELECT ON qlbh.donhang TO R3;-- cấp quyền truy vấn bảng DONHANG
GRANT SELECT ON qlbh.khachhang TO R3;-- cấp quyền truy vấn bảng KHACHHANG
GRANT SELECT ON qlbh.vanchuyen TO R3;-- cấp quyền truy vấn bảng VANCHUYEN
GRANT SELECT ON qlbh.magiamgia TO R3;-- cấp quyền truy vấn bảng MAGIAMGIA
GRANT SELECT,INSERT ON qlbh.SANPHAM TO R3;-- cấp quyền truy vấn, và insert dữ liệu bảng SANPHAM
GRANT SELECT,INSERT ON qlbh.DANHMUC TO R3;-- cấp quyền truy vấn, và insert dữ liệu bảng DANHMUC
GRANT SELECT,INSERT ON qlbh.PHANHOI TO R3;-- cấp quyền truy vấn, và insert dữ liệu bảng PHANHOI
SHOW GRANTS FOR R3;

-- Cấp quyền bổ sung cho nhân viên vận chuyển
GRANT SELECT ON qlbh.khachhang TO R4;-- cấp quyền truy vấn bảng KHACHHANG
GRANT SELECT ON qlbh.vanchuyen TO R4;-- cấp quyền truy vấn bảng VANCHUYEN

