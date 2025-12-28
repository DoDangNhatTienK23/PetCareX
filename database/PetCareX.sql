CREATE DATABASE PetCare_X
USE PetCare_X
GO

/*******************************************************************************
 * PHẦN 1: TẠO BẢNG VÀ KHOÁ CHÍNH (PRIMARY KEY)
 ******************************************************************************/

--=============================================================================
-- NHÓM 1: CƠ CẤU TỔ CHỨC & NHÂN SỰ
--=============================================================================

CREATE TABLE CHINHANH (
    MaChiNhanh CHAR(4) NOT NULL,
    TenChiNhanh NVARCHAR(70),
    DiaChi NVARCHAR(150),
    SDT CHAR(10),
    MaQuanLy CHAR(5), -- FK liên kết đến NHANVIEN
    ThoiGianMoCua TIME(0),
    ThoiGianDongCua TIME(0),
    PRIMARY KEY (MaChiNhanh)
);

CREATE TABLE KHO (
    MaKho CHAR(4) NOT NULL,
    NhanVienPhuTrach CHAR(5), -- FK liên kết đến NHANVIEN
    PRIMARY KEY (MaKho)
);

CREATE TABLE KHOA (
    MaKhoa CHAR(2) NOT NULL,
    TenKhoa NVARCHAR(50),
    TruongKhoa CHAR(5), -- FK liên kết đến NHANVIEN
    PRIMARY KEY (MaKhoa)
);

CREATE TABLE LOAINHANVIEN_LUONG (
    LoaiNhanVien NVARCHAR(20) NOT NULL,
    Luong DECIMAL(9, 0),
    PRIMARY KEY (LoaiNhanVien)
);

CREATE TABLE NHANVIEN (
    MaNhanVien CHAR(5) NOT NULL,
    HoTen NVARCHAR(50),
    NgayVaoLam DATE,
    NgayNghiLam DATE,
    NgaySinh DATE,
    SDT CHAR(10),
    MaChiNhanh CHAR(4), -- FK
    LoaiNhanVien NVARCHAR(20), -- FK
    MaKhoa CHAR(2), -- FK
    PRIMARY KEY (MaNhanVien)
);

CREATE TABLE LICHLAMVIECBACSI (
    MaBacSi CHAR(5) NOT NULL, -- FK
    MaChiNhanh CHAR(4) NOT NULL, -- FK
    Ngay DATE NOT NULL,
    TrangThai NVARCHAR(5),
    PRIMARY KEY (MaBacSi, MaChiNhanh, Ngay)
);

--=============================================================================
-- NHÓM 2: KHÁCH HÀNG & THÚ CƯNG
--=============================================================================

CREATE TABLE KHACHHANG (
    MaKhachHang INT IDENTITY(1,1) NOT NULL,
    HoTen NVARCHAR(50),
    SoDienThoai CHAR(10),
    PRIMARY KEY (MaKhachHang)
);

CREATE TABLE HANGTHANHVIEN (
    TenHang NVARCHAR(10) NOT NULL,
    GiamGia DECIMAL(3,2),
    PRIMARY KEY (TenHang)
);

CREATE TABLE KHACHHANGTHANHVIEN (
    MaKhachHang INT NOT NULL, -- Lưu ý: Đề bài yêu cầu IDENTITY riêng, có thể không khớp với KHACHHANG
    Email VARCHAR(50),
    GioiTinh NVARCHAR(3),
    NgaySinh DATE,
    CCCD CHAR(12),
    TongChiTieu DECIMAL(12,2),
    TenHang NVARCHAR(10), -- FK
    DiaChi NVARCHAR(150),
    PRIMARY KEY (MaKhachHang)
);

CREATE TABLE LOAITHUCUNG (
    MaLoaiThuCung CHAR(2) NOT NULL,
    TenLoaiThuCung NVARCHAR(10),
    PRIMARY KEY (MaLoaiThuCung)
);

CREATE TABLE CHUNGLOAITHUCUNG (
    MaChungLoaiThuCung CHAR(2) NOT NULL,
    TenChungLoaiThuCung NVARCHAR(20),
    MaLoaiThuCung CHAR(2), -- FK
    PRIMARY KEY (MaChungLoaiThuCung)
);

CREATE TABLE THUCUNG (
    MaThuCung INT IDENTITY(1, 1) NOT NULL,
    TenThuCung NVARCHAR(20),
    NgaySinhThuCung DATE,
    MaKhachHang INT, -- FK
    MaChungLoai CHAR(2), -- FK
    PRIMARY KEY (MaThuCung)
);

CREATE TABLE LICHHEN (
    MaLichHen INT IDENTITY(1,1) NOT NULL, -- Đã sửa lỗi chính tả INDENTITY
    MaKhachHang INT, -- FK
    MaThuCung INT, -- FK
    MaBacSi CHAR(5), -- FK
    NgayHen DATE,
    GioHen TIME(0),
    TrangThai NVARCHAR(16),
    PRIMARY KEY (MaLichHen)
);

--=============================================================================
-- NHÓM 3: SẢN PHẨM, KHO & VACCINE
--=============================================================================

CREATE TABLE SANPHAM (
    MaSanPham CHAR(5) NOT NULL,
    TenSanPham NVARCHAR(50),
    GiaTienSanPham INT,
    LoaiSanPham NVARCHAR(50),
    PRIMARY KEY (MaSanPham)
);

CREATE TABLE LICHSUGIASANPHAM (
    MaSanPham CHAR(5) NOT NULL, -- FK
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE,
    Gia INT,
    PRIMARY KEY (MaSanPham, NgayBatDau)
);

-- Các bảng kế thừa từ SANPHAM
CREATE TABLE THUOC (
    MaSanPham CHAR(5) NOT NULL, -- FK & PK
    PRIMARY KEY (MaSanPham)
);

CREATE TABLE THUCAN (
    MaSanPham CHAR(5) NOT NULL, -- FK & PK
    PRIMARY KEY (MaSanPham)
);

CREATE TABLE THANHPHANTHUCAN (
    MaSanPham CHAR(5) NOT NULL, -- FK
    ThanhPhan NVARCHAR(20) NOT NULL,
    KhoiLuong FLOAT,
    PRIMARY KEY (MaSanPham, ThanhPhan)
);

CREATE TABLE PHUKIEN (
    MaSanPham CHAR(5) NOT NULL, -- FK & PK
    PRIMARY KEY (MaSanPham)
);

CREATE TABLE CHITIETTONKHO (
    MaKho CHAR(4) NOT NULL, -- FK
    MaSanPham CHAR(5) NOT NULL, -- FK
    SoLuong INT,
    PRIMARY KEY (MaKho, MaSanPham)
);

CREATE TABLE VACCINE (
    MaVaccine CHAR(5) NOT NULL,
    TenVaccine NVARCHAR(20),
    LoaiVaccine NVARCHAR(50),
    GiaVaccine INT,
    PRIMARY KEY (MaVaccine)
);

CREATE TABLE KHO_VACCINE (
    MaKho CHAR(4) NOT NULL, -- FK
    MaVaccine CHAR(5) NOT NULL, -- FK
    PRIMARY KEY (MaKho, MaVaccine)
);

--=============================================================================
-- NHÓM 4: DỊCH VỤ & GÓI TIÊM PHÒNG
--=============================================================================

CREATE TABLE DICHVUYTE (
    MaDichVu CHAR(5) NOT NULL,
    TenDichVu NVARCHAR(50),
    LoaiDichVu NVARCHAR(10),
    PRIMARY KEY (MaDichVu)
);

CREATE TABLE CUNGCAPDICHVU (
    MaChiNhanh CHAR(4) NOT NULL, -- FK
    MaDichVu CHAR(5) NOT NULL, -- FK
    PRIMARY KEY (MaChiNhanh, MaDichVu)
);

CREATE TABLE GOITIEMPHONG (
    MaGoi CHAR(4) NOT NULL,
    TenGoi NVARCHAR(50),
    GiaGoi INT,
    PRIMARY KEY (MaGoi)
);

CREATE TABLE CHITIETGOITIEMPHONG ( 
    MaGoi CHAR(4) NOT NULL, -- FK
    MaVaccine CHAR(5) NOT NULL, -- FK
    SoLuong INT,
    PRIMARY KEY (MaGoi, MaVaccine)
);

CREATE TABLE PHIEUDANGKYTIEMPHONG (
    MaDangKy INT IDENTITY(1, 1) NOT NULL,
    MaKhachHang INT, -- FK
    MaThuCung INT, -- FK
    NgayDangKy DATETIME,
    MaDichVu CHAR(5), -- FK
    PRIMARY KEY (MaDangKy)
);

-- Bảng kế thừa/chi tiết của Phiếu đăng ký
CREATE TABLE PHIEUDANGKYGOI (
    MaDangKy INT NOT NULL, -- FK & PK
    MaGoi CHAR(4), -- FK
    PRIMARY KEY (MaDangKy)
);

CREATE TABLE PHIEUDANGKYLE (
    MaDangKy INT NOT NULL, -- FK & PK
    MaVaccine CHAR(5), -- FK
    PRIMARY KEY (MaDangKy)
);

--=============================================================================
-- NHÓM 5: KHÁM CHỮA BỆNH (QUY TRÌNH NGHIỆP VỤ)
--=============================================================================

CREATE TABLE GIAYKHAMBENHTONGQUAT (
    MaGiayKhamTongQuat INT IDENTITY(1,1) NOT NULL,
    NhietDo FLOAT,
    MoTa NVARCHAR(100),
    MaThuCung INT, -- FK
    MaPhieuDangKyTiemPhong INT, -- FK. Đã sửa từ CHAR(20) sang INT để khớp bảng cha
    PRIMARY KEY (MaGiayKhamTongQuat)
);

CREATE TABLE GIAYKHAMBENHCHUYENKHOA (
    MaGiayKhamChuyenKhoa INT IDENTITY(1,1) NOT NULL, -- Sửa VARCHAR thành CHAR cho thống nhất
    NgayKham DATETIME,
    NgayTaiKham DATETIME,
    MaBacSi CHAR(5), -- FK
    MaThuCung INT, -- FK
    MaDichVu CHAR(5), -- FK. Sửa CHAR(20) thành CHAR(5) khớp DICHVUYTE
    PRIMARY KEY (MaGiayKhamChuyenKhoa)
);

CREATE TABLE CHITIETKHAMBENH_TRIEUCHUNG (
    MaGiayKhamChuyenKhoa INT NOT NULL, -- FK. Sửa VARCHAR thành CHAR
    TrieuChung NVARCHAR(200) NOT NULL,
    PRIMARY KEY (MaGiayKhamChuyenKhoa, TrieuChung)
);

CREATE TABLE CHITIETKHAMBENH_CHUANDOAN (
    MaGiayKhamChuyenKhoa INT NOT NULL, -- FK. Sửa VARCHAR thành CHAR
    ChuanDoan NVARCHAR(200) NOT NULL,
    PRIMARY KEY (MaGiayKhamChuyenKhoa, ChuanDoan)
);

CREATE TABLE TOATHUOC (
    MaToaThuoc INT IDENTITY(1,1) NOT NULL, -- Sửa VARCHAR thành CHAR
    MaThuCung INT, -- FK
    MaBacSi CHAR(5), -- FK
    NgayKham DATETIME,
    TongTien DECIMAL(18,0),
    PRIMARY KEY (MaToaThuoc)
);

CREATE TABLE CHITIETTOATHUOC (
    MaToaThuoc INT NOT NULL, -- FK. Sửa VARCHAR thành CHAR
    MaThuoc CHAR(5) NOT NULL, -- FK. Sửa VARCHAR(20) thành CHAR(5) để khớp SANPHAM/THUOC
    SoLuong INT,
    GhiChu NVARCHAR(100),
    PRIMARY KEY (MaToaThuoc, MaThuoc)
);

CREATE TABLE GIAYTIEMPHONG (
    MaGiayTiem INT IDENTITY(1,1) NOT NULL, -- Sửa VARCHAR thành CHAR
    MaVaccine CHAR(5), -- FK
    MaBacSi CHAR(5), -- FK
    LieuLuong INT,
    NgayTiem DATETIME,
    MaGiayKhamTongQuat INT, -- FK. Sửa VARCHAR(20) thành CHAR(6) khớp GIAYKHAMBENHTONGQUAT
    PRIMARY KEY (MaGiayTiem)
);

--=============================================================================
-- NHÓM 6: HÓA ĐƠN & ĐÁNH GIÁ
--=============================================================================

CREATE TABLE HOADON (
    MaHoaDon INT IDENTITY(1,1) NOT NULL,
    NgayLap DATETIME,
    GiamGia DECIMAL(3,2),
    TongTien DECIMAL(12,2),
    MaNhanVien CHAR(5), -- FK
    MaKhachHang INT, -- FK
    PRIMARY KEY (MaHoaDon)
);

CREATE TABLE HOADON_SANPHAM (
    MaHoaDon INT NOT NULL, -- FK
    MaSanPham CHAR(5) NOT NULL, -- FK
    SoLuong INT,
    PRIMARY KEY (MaHoaDon, MaSanPham)
);

CREATE TABLE THANHTOANDICHVUYTE (
    MaHoaDon INT NOT NULL, -- FK
    MaDichVu CHAR(5) NOT NULL, -- FK
    PRIMARY KEY (MaHoaDon, MaDichVu)
);

CREATE TABLE DANHGIAYTE (
    MaDanhGia INT IDENTITY(1,1) NOT NULL,
    BinhLuan NVARCHAR(200),
    MucDoHaiLong INT,
    ThaiDoNhanVien INT,
    DiemChatLuongDichVu INT,
    MaHoaDon INT, -- FK
    PRIMARY KEY (MaDanhGia)
);

CREATE TABLE DANHGIAMUAHANG (
    MaDanhGia INT IDENTITY(1,1) NOT NULL,
    BinhLuan NVARCHAR(200),
    MaHoaDon INT, -- FK. Đã sửa lỗi chính tả INT00
    MucDoHaiLong INT,
    ThaiDoNhanVien INT,
    PRIMARY KEY (MaDanhGia)
);
GO

/*******************************************************************************
 * PHẦN 2: TẠO KHOÁ NGOẠI (FOREIGN KEY) SỬ DỤNG ALTER TABLE
 ******************************************************************************/

-- NHÓM 1
ALTER TABLE CHINHANH ADD CONSTRAINT FK_CHINHANH_NHANVIEN FOREIGN KEY (MaQuanLy) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE KHO ADD CONSTRAINT FK_KHO_NHANVIEN FOREIGN KEY (NhanVienPhuTrach) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE KHOA ADD CONSTRAINT FK_KHOA_NHANVIEN FOREIGN KEY (TruongKhoa) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_CHINHANH FOREIGN KEY (MaChiNhanh) REFERENCES CHINHANH(MaChiNhanh);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_LOAINV FOREIGN KEY (LoaiNhanVien) REFERENCES LOAINHANVIEN_LUONG(LoaiNhanVien);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa);
ALTER TABLE LICHLAMVIECBACSI ADD CONSTRAINT FK_LICHBACSI_NHANVIEN FOREIGN KEY (MaBacSi) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE LICHLAMVIECBACSI ADD CONSTRAINT FK_LICHBACSI_CHINHANH FOREIGN KEY (MaChiNhanh) REFERENCES CHINHANH(MaChiNhanh);

-- NHÓM 2
ALTER TABLE KHACHHANGTHANHVIEN ADD CONSTRAINT FK_KHTV_HANG FOREIGN KEY (TenHang) REFERENCES HANGTHANHVIEN(TenHang);
ALTER TABLE KHACHHANGTHANHVIEN ADD CONSTRAINT FK_KHTV_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang);
ALTER TABLE CHUNGLOAITHUCUNG ADD CONSTRAINT FK_CHUNGLOAI_LOAI FOREIGN KEY (MaLoaiThuCung) REFERENCES LOAITHUCUNG(MaLoaiThuCung);
ALTER TABLE THUCUNG ADD CONSTRAINT FK_THUCUNG_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang);
ALTER TABLE THUCUNG ADD CONSTRAINT FK_THUCUNG_CHUNGLOAI FOREIGN KEY (MaChungLoai) REFERENCES CHUNGLOAITHUCUNG(MaChungLoaiThuCung);
ALTER TABLE LICHHEN ADD CONSTRAINT FK_LICHHEN_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang);
ALTER TABLE LICHHEN ADD CONSTRAINT FK_LICHHEN_THUCUNG FOREIGN KEY (MaThuCung) REFERENCES THUCUNG(MaThuCung);
ALTER TABLE LICHHEN ADD CONSTRAINT FK_LICHHEN_BACSI FOREIGN KEY (MaBacSi) REFERENCES NHANVIEN(MaNhanVien);

-- NHÓM 3
ALTER TABLE LICHSUGIASANPHAM ADD CONSTRAINT FK_LICHSUGIA_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE THUOC ADD CONSTRAINT FK_THUOC_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE THUCAN ADD CONSTRAINT FK_THUCAN_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE THANHPHANTHUCAN ADD CONSTRAINT FK_TPTHUCAN_THUCAN FOREIGN KEY (MaSanPham) REFERENCES THUCAN(MaSanPham);
ALTER TABLE PHUKIEN ADD CONSTRAINT FK_PHUKIEN_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE CHITIETTONKHO ADD CONSTRAINT FK_CTTONKHO_KHO FOREIGN KEY (MaKho) REFERENCES KHO(MaKho);
ALTER TABLE CHITIETTONKHO ADD CONSTRAINT FK_CTTONKHO_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE KHO_VACCINE ADD CONSTRAINT FK_KHOVACCINE_KHO FOREIGN KEY (MaKho) REFERENCES KHO(MaKho);
ALTER TABLE KHO_VACCINE ADD CONSTRAINT FK_KHOVACCINE_VACCINE FOREIGN KEY (MaVaccine) REFERENCES VACCINE(MaVaccine);

-- NHÓM 4
ALTER TABLE CUNGCAPDICHVU ADD CONSTRAINT FK_CCDV_CHINHANH FOREIGN KEY (MaChiNhanh) REFERENCES CHINHANH(MaChiNhanh);
ALTER TABLE CUNGCAPDICHVU ADD CONSTRAINT FK_CCDV_DICHVU FOREIGN KEY (MaDichVu) REFERENCES DICHVUYTE(MaDichVu);
ALTER TABLE CHITIETGOITIEMPHONG ADD CONSTRAINT FK_CTGOI_GOI FOREIGN KEY (MaGoi) REFERENCES GOITIEMPHONG(MaGoi);
ALTER TABLE CHITIETGOITIEMPHONG ADD CONSTRAINT FK_CTGOI_VACCINE FOREIGN KEY (MaVaccine) REFERENCES VACCINE(MaVaccine);
ALTER TABLE PHIEUDANGKYTIEMPHONG ADD CONSTRAINT FK_PDK_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang);
ALTER TABLE PHIEUDANGKYTIEMPHONG ADD CONSTRAINT FK_PDK_THUCUNG FOREIGN KEY (MaThuCung) REFERENCES THUCUNG(MaThuCung);
ALTER TABLE PHIEUDANGKYTIEMPHONG ADD CONSTRAINT FK_PDK_DICHVU FOREIGN KEY (MaDichVu) REFERENCES DICHVUYTE(MaDichVu);
ALTER TABLE PHIEUDANGKYGOI ADD CONSTRAINT FK_PDKGOI_PDK FOREIGN KEY (MaDangKy) REFERENCES PHIEUDANGKYTIEMPHONG(MaDangKy);
ALTER TABLE PHIEUDANGKYGOI ADD CONSTRAINT FK_PDKGOI_GOI FOREIGN KEY (MaGoi) REFERENCES GOITIEMPHONG(MaGoi);
ALTER TABLE PHIEUDANGKYLE ADD CONSTRAINT FK_PDKLE_PDK FOREIGN KEY (MaDangKy) REFERENCES PHIEUDANGKYTIEMPHONG(MaDangKy);
ALTER TABLE PHIEUDANGKYLE ADD CONSTRAINT FK_PDKLE_VACCINE FOREIGN KEY (MaVaccine) REFERENCES VACCINE(MaVaccine);

-- NHÓM 5
ALTER TABLE GIAYKHAMBENHTONGQUAT ADD CONSTRAINT FK_GKBTQ_THUCUNG FOREIGN KEY (MaThuCung) REFERENCES THUCUNG(MaThuCung);
ALTER TABLE GIAYKHAMBENHTONGQUAT ADD CONSTRAINT FK_GKBTQ_PDK FOREIGN KEY (MaPhieuDangKyTiemPhong) REFERENCES PHIEUDANGKYTIEMPHONG(MaDangKy);
ALTER TABLE GIAYKHAMBENHCHUYENKHOA ADD CONSTRAINT FK_GKBCK_BACSI FOREIGN KEY (MaBacSi) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE GIAYKHAMBENHCHUYENKHOA ADD CONSTRAINT FK_GKBCK_THUCUNG FOREIGN KEY (MaThuCung) REFERENCES THUCUNG(MaThuCung);
ALTER TABLE GIAYKHAMBENHCHUYENKHOA ADD CONSTRAINT FK_GKBCK_DICHVU FOREIGN KEY (MaDichVu) REFERENCES DICHVUYTE(MaDichVu);
ALTER TABLE CHITIETKHAMBENH_TRIEUCHUNG ADD CONSTRAINT FK_CKTC_GKBCK FOREIGN KEY (MaGiayKhamChuyenKhoa) REFERENCES GIAYKHAMBENHCHUYENKHOA(MaGiayKhamChuyenKhoa);
ALTER TABLE CHITIETKHAMBENH_CHUANDOAN ADD CONSTRAINT FK_CKCD_GKBCK FOREIGN KEY (MaGiayKhamChuyenKhoa) REFERENCES GIAYKHAMBENHCHUYENKHOA(MaGiayKhamChuyenKhoa);
ALTER TABLE TOATHUOC ADD CONSTRAINT FK_TOATHUOC_THUCUNG FOREIGN KEY (MaThuCung) REFERENCES THUCUNG(MaThuCung);
ALTER TABLE TOATHUOC ADD CONSTRAINT FK_TOATHUOC_BACSI FOREIGN KEY (MaBacSi) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE CHITIETTOATHUOC ADD CONSTRAINT FK_CTTOA_TOA FOREIGN KEY (MaToaThuoc) REFERENCES TOATHUOC(MaToaThuoc);
-- Giả sử MaThuoc trong chi tiết toa thuốc tham chiếu đến bảng THUOC (sản phẩm là thuốc)
ALTER TABLE CHITIETTOATHUOC ADD CONSTRAINT FK_CTTOA_THUOC FOREIGN KEY (MaThuoc) REFERENCES THUOC(MaSanPham);
ALTER TABLE GIAYTIEMPHONG ADD CONSTRAINT FK_GTP_VACCINE FOREIGN KEY (MaVaccine) REFERENCES VACCINE(MaVaccine);
ALTER TABLE GIAYTIEMPHONG ADD CONSTRAINT FK_GTP_BACSI FOREIGN KEY (MaBacSi) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE GIAYTIEMPHONG ADD CONSTRAINT FK_GTP_GKBTQ FOREIGN KEY (MaGiayKhamTongQuat) REFERENCES GIAYKHAMBENHTONGQUAT(MaGiayKhamTongQuat);

-- NHÓM 6
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien);
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang);
ALTER TABLE HOADON_SANPHAM ADD CONSTRAINT FK_HDSP_HOADON FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon);
ALTER TABLE HOADON_SANPHAM ADD CONSTRAINT FK_HDSP_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham);
ALTER TABLE THANHTOANDICHVUYTE ADD CONSTRAINT FK_TTDV_HOADON FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon);
ALTER TABLE THANHTOANDICHVUYTE ADD CONSTRAINT FK_TTDV_DICHVU FOREIGN KEY (MaDichVu) REFERENCES DICHVUYTE(MaDichVu);
ALTER TABLE DANHGIAYTE ADD CONSTRAINT FK_DGYTE_HOADON FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon);
ALTER TABLE DANHGIAMUAHANG ADD CONSTRAINT FK_DGMH_HOADON FOREIGN KEY (MaHoaDon) REFERENCES HOADON(MaHoaDon);
GO


-- Sinh dữ liệu cho các bảng
GO 
SET NOCOUNT ON;

PRINT '=== BẮT ĐẦU SINH DỮ LIỆU ===';

-- ============================================================================
-- NHÓM 1: CƠ CẤU TỔ CHỨC & NHÂN SỰ
-- ============================================================================

PRINT '1. Insert CHINHANH...';

INSERT INTO CHINHANH (MaChiNhanh, TenChiNhanh, DiaChi, SDT, ThoiGianMoCua, ThoiGianDongCua, MaQuanLy) VALUES 
('CN01', N'PetCareX Hà Nội', N'15 Tràng Tiền, P. Tràng Tiền, TP. Hà Nội', '0901000001', '08:00:00', '22:00:00', NULL),
('CN02', N'PetCareX Hải Phòng', N'20 Lạch Tray, P. Lạch Tray, TP. Hải Phòng', '0901000002', '08:00:00', '22:00:00', NULL),
('CN03', N'PetCareX Quảng Ninh', N'50 Lê Thánh Tông, P. Hồng Gai, Tỉnh Quảng Ninh', '0901000003', '08:00:00', '22:00:00', NULL),
('CN04', N'PetCareX Nghệ An', N'10 Quang Trung, P. Quang Trung, Tỉnh Nghệ An', '0901000004', '08:00:00', '22:00:00', NULL),
('CN05', N'PetCareX Huế', N'15 Lê Lợi, P. Vĩnh Ninh, TP. Huế', '0901000005', '08:00:00', '22:00:00', NULL),
('CN06', N'PetCareX Đà Nẵng', N'200 Bạch Đằng, P. Phước Ninh, TP. Đà Nẵng', '0901000006', '08:00:00', '22:00:00', NULL),
('CN07', N'PetCareX Nha Trang', N'78 Trần Phú, P. Lộc Thọ, Tỉnh Khánh Hòa', '0901000007', '08:00:00', '22:00:00', NULL),
('CN08', N'PetCareX Đà Lạt', N'01 Lê Đại Hành, P. 1, Tỉnh Lâm Đồng', '0901000008', '08:00:00', '22:00:00', NULL),
('CN09', N'PetCareX Hồ Chí Minh', N'68 Nguyễn Huệ, P. Bến Nghé, TP. Hồ Chí Minh', '0901000009', '08:00:00', '22:00:00', NULL),
('CN10', N'PetCareX Cần Thơ', N'50 Đường 30/4, P. An Phú, TP. Cần Thơ', '0901000010', '08:00:00', '22:00:00', NULL);

GO

PRINT '2. Insert KHOA...';
INSERT INTO KHOA (MaKhoa, TenKhoa, TruongKhoa) VALUES 
('01', N'Khoa Nội', NULL), ('02', N'Khoa Ngoại', NULL), ('03', N'Da Liễu', NULL), ('04', N'CĐ Hình ảnh', NULL), ('05', N'Cấp cứu', NULL);

GO

PRINT '3. Insert LOAINHANVIEN_LUONG...';
INSERT INTO LOAINHANVIEN_LUONG (LoaiNhanVien, Luong) VALUES 
('QuanLy', 25000000), ('BacSi', 18000000), ('TiepTan', 8000000), ('Kho', 7000000), ('TapVu', 6000000);

GO

PRINT '4. Insert NHANVIEN...';

DECLARE @i INT = 1;
DECLARE @Ho NVARCHAR(20), @Dem NVARCHAR(20), @Ten NVARCHAR(20);
DECLARE @Fullname NVARCHAR(50);
DECLARE @SDT_Dau CHAR(3);
DECLARE @SDT_Duoi CHAR(7);
DECLARE @MaCN CHAR(4);
DECLARE @LoaiNV NVARCHAR(20);
DECLARE @MaKhoa CHAR(2);

WHILE @i <= 150
BEGIN
    -- 1. Logic Phân bổ Chi nhánh & Loại NV
    SET @MaCN = 'CN' + RIGHT('00' + CAST(((@i % 10) + 1) AS VARCHAR), 2);
    
    SET @LoaiNV = CASE 
        WHEN @i <= 10 THEN 'QuanLy' 
        WHEN @i <= 60 THEN 'BacSi' 
        WHEN @i <= 110 THEN 'TiepTan' 
        ELSE 'Kho' END;
    
    SET @MaKhoa = NULL;
    IF @LoaiNV = 'BacSi' SET @MaKhoa = RIGHT('00' + CAST(((@i % 5) + 1) AS VARCHAR), 2);

    -- 2. SINH TÊN (Dùng cách SELECT FROM VALUES để không bao giờ bị NULL)
    
    -- Random Họ
    SELECT TOP 1 @Ho = Ho FROM (VALUES 
        (N'Nguyễn'), (N'Trần'), (N'Lê'), (N'Phạm'), (N'Huỳnh'), (N'Hoàng'), (N'Phan'), (N'Vũ'), (N'Võ'), (N'Đặng'), 
        (N'Bùi'), (N'Đỗ'), (N'Hồ'), (N'Ngô'), (N'Dương'), (N'Lý')
    ) AS A(Ho) ORDER BY NEWID();

    -- Random Đệm
    SELECT TOP 1 @Dem = Dem FROM (VALUES 
        (N'Văn'), (N'Thị'), (N'Minh'), (N'Ngọc'), (N'Thanh'), (N'Quốc'), (N'Đức'), (N'Hữu'), (N'Mỹ'), (N'Xuân'), (N'Gia'), (N'Bảo')
    ) AS A(Dem) ORDER BY NEWID();

    -- Random Tên
    SELECT TOP 1 @Ten = Ten FROM (VALUES 
        (N'Hùng'), (N'Dũng'), (N'Lan'), (N'Hương'), (N'Tuấn'), (N'Kiệt'), (N'Vy'), (N'Trân'), (N'Phúc'), (N'Lộc'), 
        (N'Thảo'), (N'Tâm'), (N'Anh'), (N'Khang'), (N'Châu'), (N'Quỳnh'), (N'Nhung'), (N'Huy'), (N'Tú'), (N'Giang')
    ) AS A(Ten) ORDER BY NEWID();

    -- Ghép tên (Sử dụng ISNULL để chặn mọi trường hợp xấu nhất)
    SET @Fullname = ISNULL(@Ho, N'Nguyễn') + ' ' + ISNULL(@Dem, N'Văn') + ' ' + ISNULL(@Ten, N'A');

    -- 3. SINH SỐ ĐIỆN THOẠI
    -- Random đầu số
    SELECT TOP 1 @SDT_Dau = DauSo FROM (VALUES 
        ('090'), ('091'), ('098'), ('032'), ('070'), ('089'), ('093')
    ) AS A(DauSo) ORDER BY NEWID();
    
    -- Random đuôi số (Đảm bảo đủ 7 ký tự)
    SET @SDT_Duoi = RIGHT('0000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000 AS VARCHAR), 7);

    -- 4. INSERT VÀO BẢNG
    INSERT INTO NHANVIEN (MaNhanVien, HoTen, NgayVaoLam, NgaySinh, SDT, MaChiNhanh, LoaiNhanVien, MaKhoa)
    VALUES (
        RIGHT('00000' + CAST(@i AS VARCHAR(5)), 5), 
        @Fullname, 
        DATEADD(DAY, -CAST(RAND()*1500 AS INT), GETDATE()), 
        DATEADD(YEAR, -CAST((RAND()*20 + 22) AS INT), GETDATE()), 
        @SDT_Dau + @SDT_Duoi, 
        @MaCN, @LoaiNV, @MaKhoa
    );
    
    SET @i = @i + 1;
END;

GO

-- Update lại MaQuanLy và TruongKhoa sau khi đã có dữ liệu nhân viên
UPDATE CHINHANH SET MaQuanLy = (SELECT TOP 1 MaNhanVien FROM NHANVIEN WHERE MaChiNhanh = CHINHANH.MaChiNhanh AND LoaiNhanVien = 'QuanLy');
UPDATE KHOA SET TruongKhoa = (SELECT TOP 1 MaNhanVien FROM NHANVIEN WHERE MaKhoa = KHOA.MaKhoa AND LoaiNhanVien = 'BacSi');

GO

PRINT '5. Insert KHO...';
INSERT INTO KHO (MaKho, NhanVienPhuTrach)
SELECT 
    'K' + RIGHT('00' + SUBSTRING(MaChiNhanh, 3, 2), 3),
    (SELECT TOP 1 MaNhanVien FROM NHANVIEN WHERE MaChiNhanh = CN.MaChiNhanh AND LoaiNhanVien='Kho') 
FROM CHINHANH CN;

GO


PRINT '6. Insert LICHLAMVIECBACSI...';
DECLARE @DayCount INT = 0;
WHILE @DayCount < 100
BEGIN
    INSERT INTO LICHLAMVIECBACSI (MaBacSi, MaChiNhanh, Ngay, TrangThai)
    SELECT 
        MaNhanVien, MaChiNhanh, DATEADD(DAY, @DayCount, '2025-01-01'), 
        CASE WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0 THEN N'Bận' ELSE N'Trống' END
    FROM NHANVIEN WHERE LoaiNhanVien = 'BacSi';
    SET @DayCount = @DayCount + 1;
END;

GO

-- ============================================================================
-- NHÓM 2: KHÁCH HÀNG & THÚ CƯNG
-- ============================================================================

-- 7. KHACHHANG (TĂNG LÊN 80.000)
PRINT '7. Insert KHACHHANG...';

DECLARE @i INT = 1;
DECLARE @Ho NVARCHAR(20), @Dem NVARCHAR(20), @Ten NVARCHAR(20);
DECLARE @Fullname NVARCHAR(50);
DECLARE @SDT_Dau CHAR(3);
DECLARE @SDT_Duoi CHAR(7);

WHILE @i <= 80000
BEGIN
    -- 1. SINH HỌ TÊN NGẪU NHIÊN
    
    -- Random Họ (Mở rộng danh sách họ phổ biến VN)
    SELECT TOP 1 @Ho = Ho FROM (VALUES 
        (N'Nguyễn'), (N'Trần'), (N'Lê'), (N'Phạm'), (N'Huỳnh'), (N'Hoàng'), (N'Phan'), (N'Vũ'), (N'Võ'), (N'Đặng'), 
        (N'Bùi'), (N'Đỗ'), (N'Hồ'), (N'Ngô'), (N'Dương'), (N'Lý'), (N'Phí'), (N'Đinh'), (N'Lâm'), (N'Đoàn'),
        (N'Trịnh'), (N'Mai'), (N'Cao'), (N'Lương'), (N'Thái')
    ) AS A(Ho) ORDER BY NEWID();

    -- Random Đệm
    SELECT TOP 1 @Dem = Dem FROM (VALUES 
        (N'Văn'), (N'Thị'), (N'Minh'), (N'Ngọc'), (N'Thanh'), (N'Quốc'), (N'Đức'), (N'Hữu'), (N'Mỹ'), (N'Xuân'), 
        (N'Gia'), (N'Bảo'), (N'Tuấn'), (N'Thùy'), (N'Kim'), (N'Hoài'), (N'Hồng'), (N'Nhật'), (N'Đình')
    ) AS A(Dem) ORDER BY NEWID();

    -- Random Tên
    SELECT TOP 1 @Ten = Ten FROM (VALUES 
        (N'Hùng'), (N'Dũng'), (N'Lan'), (N'Hương'), (N'Tuấn'), (N'Kiệt'), (N'Vy'), (N'Trân'), (N'Phúc'), (N'Lộc'), 
        (N'Thảo'), (N'Tâm'), (N'Anh'), (N'Khang'), (N'Châu'), (N'Quỳnh'), (N'Nhung'), (N'Huy'), (N'Tú'), (N'Giang'),
        (N'Linh'), (N'Chi'), (N'Khánh'), (N'My'), (N'Ngân'), (N'Yến'), (N'Trang'), (N'Vân'), (N'Nam'), (N'Bình')
    ) AS A(Ten) ORDER BY NEWID();

    -- Ghép tên (Có ISNULL dự phòng)
    SET @Fullname = ISNULL(@Ho, N'Nguyễn') + ' ' + ISNULL(@Dem, N'Văn') + ' ' + ISNULL(@Ten, N'A');

    -- 2. SINH SỐ ĐIỆN THOẠI
    -- Random đầu số (Viettel, Vina, Mobi...)
    SELECT TOP 1 @SDT_Dau = DauSo FROM (VALUES 
        ('090'), ('091'), ('098'), ('097'), ('088'), ('086'), ('093'), ('039'), ('079'), ('077')
    ) AS A(DauSo) ORDER BY NEWID();
    
    SET @SDT_Duoi = RIGHT('0000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000 AS VARCHAR), 7);

    -- 3. INSERT
    INSERT INTO KHACHHANG (HoTen, SoDienThoai) 
    VALUES (@Fullname, @SDT_Dau + @SDT_Duoi);
    
    -- In log mỗi 10.000 dòng
    IF @i % 10000 = 0 PRINT N'-> Đã sinh ' + CAST(@i AS NVARCHAR) + N' khách hàng...';

    SET @i = @i + 1;
END;

GO

PRINT '8. Insert HANGTHANHVIEN...';
INSERT INTO HANGTHANHVIEN VALUES (N'VIP', 0.30), (N'Thân thiết', 0.20), (N'Cơ bản', 0);

GO

-- 9. KHACHHANGTHANHVIEN (Tăng lên 30.000)
PRINT '9. Insert KHACHHANGTHANHVIEN (30k dòng)...';
INSERT INTO KHACHHANGTHANHVIEN (MaKhachHang, Email, GioiTinh, NgaySinh, CCCD, TongChiTieu, TenHang, DiaChi)
SELECT 
    MaKhachHang,
    'user' + CAST(MaKhachHang AS VARCHAR) + '@gmail.com',
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN 'Nam' ELSE N'Nữ' END,
    -- Random ngày sinh (18-60 tuổi)
    DATEADD(DAY, -CAST(RAND(CHECKSUM(NEWID())) * 15000 + 6500 AS INT), GETDATE()),
    -- CCCD Random (12 số)
    RIGHT('000000000000' + CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR) + CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR), 12),
    
    -- Cột Tổng chi tiêu và Tên hạng được lấy từ Subquery bên dưới
    RandomChiTieu,
    CASE 
        WHEN RandomChiTieu < 5000000 THEN N'Cơ bản'
        WHEN RandomChiTieu < 12000000 THEN N'Thân thiết'
        ELSE N'VIP'
    END AS TenHang,
    
    N'TP.HCM'
FROM (
    SELECT TOP 30000 
        MaKhachHang,
        -- Random Tổng chi tiêu từ 1.000.000 đến 20.000.000 VNĐ
        -- Để rải đều khách vào các hạng Cơ bản, Thân thiết và VIP
        (CAST(ABS(CHECKSUM(NEWID())) % 190 + 10 AS INT) * 100000) AS RandomChiTieu
    FROM KHACHHANG
    ORDER BY NEWID()
) AS DataNguon;

GO

PRINT '10. Insert LOAITHUCUNG...';
INSERT INTO LOAITHUCUNG (MaLoaiThuCung, TenLoaiThuCung) VALUES ('01', N'Chó'), ('02', N'Mèo'), ('03', N'Hamster'), ('04', N'Thỏ'), ('05', N'Chim');

GO

PRINT '11. Insert CHUNGLOAITHUCUNG...';
INSERT INTO CHUNGLOAITHUCUNG (MaChungLoaiThuCung, TenChungLoaiThuCung, MaLoaiThuCung) VALUES 
('01', N'Husky', '01'), ('02', N'Corgi', '01'), ('03', N'Poodle', '01'), ('04', N'Mèo Anh', '02'), ('05', N'Mèo Ba Tư', '02'), ('06', N'W.White', '03');

GO

-- 12. THUCUNG (TĂNG LÊN 120.000)
PRINT '12. Insert THUCUNG...';

DECLARE @i INT = 1;
DECLARE @TenPet NVARCHAR(20);
DECLARE @BaseName NVARCHAR(15); -- Tên gốc
DECLARE @Suffix NVARCHAR(10);   -- Hậu tố (Adjective/Số)
DECLARE @RandomDate DATE;
DECLARE @MaKhachHang INT;
DECLARE @MaChungLoai CHAR(2);

WHILE @i <= 120000
BEGIN
    -- 1. SINH TÊN THÚ CƯNG ĐA DẠNG (KHÔNG NULL)
    
    -- Bước A: Random Tên Gốc (Mở rộng thêm tên Tiếng Anh cho phong phú)
    SELECT TOP 1 @BaseName = Ten FROM (VALUES 
        (N'Milu'), (N'Kiki'), (N'Lu'), (N'Misa'), (N'Bông'), (N'Mực'), (N'Vàng'), (N'Cọp'), (N'Đen'), (N'Xoài'), 
        (N'Mận'), (N'Kem'), (N'Bơ'), (N'Sữa'), (N'Cafe'), (N'Mập'), (N'Lùn'), (N'Hổ'), (N'Báo'), (N'Gấu'),
        (N'Bim'), (N'Bon'), (N'Tôm'), (N'Tép'), (N'Cam'), (N'Quýt'), (N'Na'), (N'Miu'), (N'Mun'), (N'Vằn'),
        (N'Rex'), (N'Bella'), (N'Charlie'), (N'Luna'), (N'Lucy'), (N'Max'), (N'Bailey'), (N'Cooper'), (N'Daisy'), (N'Rocky')
    ) AS A(Ten) ORDER BY NEWID();

    -- Bước B: Random Hậu tố (Để tạo sự khác biệt)
    -- Tỉ lệ: 40% chỉ lấy tên gốc, 60% sẽ ghép thêm hậu tố (Ví dụ: "Nhỏ", "Béo", "01", "VIP"...)
    IF RAND() < 0.4
    BEGIN
        SET @TenPet = @BaseName;
    END
    ELSE
    BEGIN
        SELECT TOP 1 @Suffix = HauTo FROM (VALUES 
            (N' Nhỏ'), (N' Béo'), (N' Còi'), (N' Xinh'), (N' Đại'), (N' Ú'), (N' Xù'), (N' Hôi'), (N' Lỳ'), (N' Ngốc'),
            (N' 01'), (N' 02'), (N' 03'), (N' 04'), (N' 05'), (N' Pro'), (N' VIP'), (N' Cute'), (N' Lười'), (N' Lucky')
        ) AS B(HauTo) ORDER BY NEWID();
        
        -- Ghép lại: "Milu" + " Béo" = "Milu Béo"
        SET @TenPet = @BaseName + @Suffix;
    END

    -- Bước C: Cắt chuỗi an toàn (Chặn mọi trường hợp lố 20 ký tự)
    SET @TenPet = LEFT(@TenPet, 20);

    -- 2. SINH NGÀY SINH (Giữ nguyên logic của bạn)
    SET @RandomDate = DATEADD(DAY, -CAST(RAND()*2900 AS INT), GETDATE());

    -- 3. MÃ KHÁCH HÀNG (Logic toán học nhanh, khớp với dữ liệu 1-80.000 đã tạo)
    SET @MaKhachHang = CAST(RAND() * 80000 AS INT) + 1;

    -- 4. CHỦNG LOÀI (Giữ nguyên logic)
    SET @MaChungLoai = RIGHT('00' + CAST((CAST(RAND()*6 AS INT) + 1) AS VARCHAR), 2);

    -- 5. INSERT
    INSERT INTO THUCUNG (TenThuCung, NgaySinhThuCung, MaKhachHang, MaChungLoai)
    VALUES (@TenPet, @RandomDate, @MaKhachHang, @MaChungLoai);
    
    -- Log tiến độ
    IF @i % 20000 = 0 PRINT N'-> Đã sinh ' + CAST(@i AS NVARCHAR) + N' thú cưng...';

    SET @i = @i + 1;
END;

GO

PRINT '13. Insert LICHHEN...';
INSERT INTO LICHHEN (MaKhachHang, MaThuCung, MaBacSi, NgayHen, GioHen, TrangThai)
SELECT TOP 100000 
    T.MaKhachHang, 
    T.MaThuCung,
    -- Random Bác sĩ (ID từ 00011 đến 00060 theo logic tạo nhân viên ở mục 4)
    -- Công thức: '000' + (Random từ 11 đến 60)
    RIGHT('00000' + CAST((ABS(CHECKSUM(NEWID())) % 50 + 11) AS VARCHAR), 5),
    
    -- Random Ngày hẹn (Trong vòng 1000 ngày qua)
    DATEADD(DAY, -CAST(ABS(CHECKSUM(NEWID())) % 1000 AS INT), GETDATE()),
    
    -- Random Giờ hẹn (Từ 8h đến 17h)
    CAST(DATEADD(HOUR, ABS(CHECKSUM(NEWID())) % 9 + 8, 0) AS TIME(0)),
    
    -- Random Trạng thái
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN N'Đã hoàn thành'
        WHEN 1 THEN N'Đã hủy'
        ELSE N'Chờ khám'
    END
FROM THUCUNG T
ORDER BY NEWID();

GO

-- ============================================================================
-- NHÓM 3: SẢN PHẨM & KHO
-- ============================================================================

PRINT '14. Insert SANPHAM...';

DECLARE @i INT = 1;
DECLARE @MaSP CHAR(5);
DECLARE @TenSP NVARCHAR(100);
DECLARE @GiaTien DECIMAL(18,0);
DECLARE @LoaiSP NVARCHAR(20);
DECLARE @Part1 NVARCHAR(30), @Part2 NVARCHAR(30), @Part3 NVARCHAR(30);

WHILE @i <= 999 
BEGIN
    -- 1. XÁC ĐỊNH MÃ SP VÀ LOẠI SP (Tiếng Việt có dấu)
    SET @MaSP = 'SP' + RIGHT('000' + CAST(@i AS VARCHAR), 3);
    
    -- Chia đều 3 loại theo số dư
    IF @i % 3 = 0 SET @LoaiSP = N'Thuốc';
    ELSE IF @i % 3 = 1 SET @LoaiSP = N'Thức Ăn';
    ELSE SET @LoaiSP = N'Phụ Kiện';

    -- 2. SINH TÊN SẢN PHẨM (Dùng VALUES để chống NULL)
    IF @LoaiSP = N'Thức Ăn'
    BEGIN
        -- Part 1: Thương hiệu
        SELECT TOP 1 @Part1 = V FROM (VALUES (N'Royal Canin'), (N'Whiskas'), (N'Pedigree'), (N'Me-O'), (N'SmartHeart'), (N'Ganador'), (N'Nutrience')) A(V) ORDER BY NEWID();
        -- Part 2: Loại
        SELECT TOP 1 @Part2 = V FROM (VALUES (N'Hạt khô'), (N'Pate'), (N'Sốt'), (N'Bánh thưởng'), (N'Súp thưởng'), (N'Thịt sấy')) A(V) ORDER BY NEWID();
        -- Part 3: Vị/Đặc điểm
        SELECT TOP 1 @Part3 = V FROM (VALUES (N'Vị Gà'), (N'Vị Bò'), (N'Vị Cá Ngừ'), (N'Cho Chó Con'), (N'Cho Mèo Lớn'), (N'Dưỡng Lông'), (N'Hải Sản')) A(V) ORDER BY NEWID();
        
        SET @TenSP = @Part1 + N' - ' + @Part2 + N' ' + @Part3;
        SET @GiaTien = (CAST(RAND()*100 AS INT) + 20) * 5000; 
    END
    ELSE IF @LoaiSP = N'Thuốc'
    BEGIN
        -- Part 1: Dạng
        SELECT TOP 1 @Part1 = V FROM (VALUES (N'Viên nhai'), (N'Dung dịch'), (N'Thuốc nhỏ'), (N'Gel'), (N'Xịt'), (N'Kem bôi')) A(V) ORDER BY NEWID();
        -- Part 2: Công dụng
        SELECT TOP 1 @Part2 = V FROM (VALUES (N'Trị ve rận'), (N'Tẩy giun'), (N'Trị nấm da'), (N'Bổ sung Canxi'), (N'Hỗ trợ tiêu hóa'), (N'Sát trùng'), (N'Giảm đau')) A(V) ORDER BY NEWID();
        -- Part 3: Thương hiệu
        SELECT TOP 1 @Part3 = V FROM (VALUES (N'NexGard'), (N'Bravecto'), (N'Bio-Pharm'), (N'Frontline'), (N'Vime-Blue'), (N'Advantage')) A(V) ORDER BY NEWID();

        SET @TenSP = @Part1 + N' ' + @Part2 + N' ' + @Part3;
        SET @GiaTien = (CAST(RAND()*50 AS INT) + 10) * 5000;
    END
    ELSE -- Phụ Kiện
    BEGIN
        -- Part 1: Vật dụng
        SELECT TOP 1 @Part1 = V FROM (VALUES (N'Vòng cổ'), (N'Dây dắt'), (N'Bát ăn'), (N'Chuồng'), (N'Đệm nằm'), (N'Đồ chơi'), (N'Cát vệ sinh'), (N'Lược chải'), (N'Ba lô')) A(V) ORDER BY NEWID();
        -- Part 2: Tính năng
        SELECT TOP 1 @Part2 = V FROM (VALUES (N'Inox'), (N'Nhựa cao cấp'), (N'Vải Cotton'), (N'Phản quang'), (N'Tự động'), (N'Hình xương'), (N'Gỗ thông')) A(V) ORDER BY NEWID();
        -- Part 3: Size/Đối tượng
        SELECT TOP 1 @Part3 = V FROM (VALUES (N'Cho Chó'), (N'Cho Mèo'), (N'Size L'), (N'Size S'), (N'Size M'), (N'Đa năng')) A(V) ORDER BY NEWID();

        SET @TenSP = @Part1 + N' ' + @Part2 + N' (' + @Part3 + N')';
        SET @GiaTien = (CAST(RAND()*80 AS INT) + 10) * 5000;
    END

    -- 3. INSERT
    INSERT INTO SANPHAM (MaSanPham, TenSanPham, GiaTienSanPham, LoaiSanPham)
    VALUES (@MaSP, @TenSP, @GiaTien, @LoaiSP);

    SET @i = @i + 1;
END;

GO

PRINT '15-18. Đưa các sản phẩm vào các bảng cụ thể...';

-- Lưu ý: Điều kiện WHERE bây giờ phải dùng N'...' và đúng từ khóa tiếng Việt
INSERT INTO THUOC(MaSanPham) 
SELECT MaSanPham FROM SANPHAM WHERE LoaiSanPham = N'Thuốc';

GO

INSERT INTO THUCAN(MaSanPham) 
SELECT MaSanPham FROM SANPHAM WHERE LoaiSanPham = N'Thức Ăn';

GO

-- Insert Thành phần thức ăn
INSERT INTO THANHPHANTHUCAN (MaSanPham, ThanhPhan, KhoiLuong)
SELECT 
    T.MaSanPham,
    Ingredient.TenThanhPhan,
    -- Random khối lượng từ 0.1kg đến 1.5kg cho mỗi thành phần
    CAST(RAND(CHECKSUM(NEWID())) * 1.4 + 0.1 AS DECIMAL(4,2))
FROM THUCAN T
JOIN SANPHAM S ON T.MaSanPham = S.MaSanPham
CROSS APPLY (
    -- Logic: Dựa vào tên sản phẩm, sinh ra 3 dòng thành phần tương ứng
    -- Lưu ý: Mỗi tên thành phần phải <= 20 ký tự
    SELECT TenThanhPhan FROM (
        -- NHÓM 1: GÀ
        SELECT N'Thịt gà' AS TenThanhPhan WHERE S.TenSanPham LIKE N'%Gà%'
        UNION ALL SELECT N'Gạo lứt' WHERE S.TenSanPham LIKE N'%Gà%'
        UNION ALL SELECT N'Vitamin B' WHERE S.TenSanPham LIKE N'%Gà%'
        
        UNION ALL
        
        -- NHÓM 2: BÒ
        SELECT N'Thịt bò' WHERE S.TenSanPham LIKE N'%Bò%'
        UNION ALL SELECT N'Khoai tây' WHERE S.TenSanPham LIKE N'%Bò%'
        UNION ALL SELECT N'Protein' WHERE S.TenSanPham LIKE N'%Bò%'

        UNION ALL

        -- NHÓM 3: CÁ/HẢI SẢN
        SELECT N'Cá ngừ' WHERE S.TenSanPham LIKE N'%Cá%' OR S.TenSanPham LIKE N'%Hải Sản%'
        UNION ALL SELECT N'Tôm' WHERE S.TenSanPham LIKE N'%Cá%' OR S.TenSanPham LIKE N'%Hải Sản%'
        UNION ALL SELECT N'Omega-3' WHERE S.TenSanPham LIKE N'%Cá%' OR S.TenSanPham LIKE N'%Hải Sản%'

        UNION ALL

        -- NHÓM 4: PATE (Chung chung)
        SELECT N'Gan heo' WHERE S.TenSanPham LIKE N'%Pate%' AND S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%'
        UNION ALL SELECT N'Nước dùng' WHERE S.TenSanPham LIKE N'%Pate%' AND S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%'
        UNION ALL SELECT N'Rau củ' WHERE S.TenSanPham LIKE N'%Pate%' AND S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%'

        UNION ALL

        -- NHÓM 5: CÁC LOẠI KHÁC (Fallback)
        SELECT N'Ngũ cốc' WHERE S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%' AND S.TenSanPham NOT LIKE N'%Hải Sản%' AND S.TenSanPham NOT LIKE N'%Pate%'
        UNION ALL SELECT N'Chất xơ' WHERE S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%' AND S.TenSanPham NOT LIKE N'%Hải Sản%' AND S.TenSanPham NOT LIKE N'%Pate%'
        UNION ALL SELECT N'Khoáng chất' WHERE S.TenSanPham NOT LIKE N'%Gà%' AND S.TenSanPham NOT LIKE N'%Bò%' AND S.TenSanPham NOT LIKE N'%Cá%' AND S.TenSanPham NOT LIKE N'%Hải Sản%' AND S.TenSanPham NOT LIKE N'%Pate%'
    ) AS Temp
) AS Ingredient;

GO

INSERT INTO PHUKIEN(MaSanPham) 
SELECT MaSanPham FROM SANPHAM WHERE LoaiSanPham = N'Phụ Kiện';

GO

PRINT '19. Insert LICHSUGIASANPHAM...';
INSERT INTO LICHSUGIASANPHAM (MaSanPham, NgayBatDau, NgayKetThuc, Gia) 
SELECT 
    MaSanPham, 
    -- Ngày bắt đầu: Cách đây khoảng 1-2 năm
    DATEADD(DAY, -CAST(RAND(CHECKSUM(NEWID())) * 365 + 365 AS INT), GETDATE()), 
    
    -- Ngày kết thúc: Cách đây vài ngày/tháng (đã hết hiệu lực)
    DATEADD(DAY, -CAST(RAND(CHECKSUM(NEWID())) * 300 + 1 AS INT), GETDATE()),
    
    -- GIÁ LỊCH SỬ:
    -- Logic: Giá gốc * (Random từ 0.8 đến 1.2) -> Biến động +/- 20% so với giá hiện tại
    -- Ví dụ: Giá 100k -> Lịch sử có thể là 80k hoặc 120k
    CAST(GiaTienSanPham * (0.8 + (RAND(CHECKSUM(NEWID())) * 0.4)) AS INT)
FROM SANPHAM;
GO


PRINT '20. Insert CHITIETTONKHO...';
INSERT INTO CHITIETTONKHO (MaKho, MaSanPham, SoLuong) 
SELECT 
    K.MaKho, 
    S.MaSanPham,
    ABS(CHECKSUM(NEWID())) % 5001
FROM KHO K CROSS JOIN SANPHAM S;

GO

DECLARE @i INT = 1;
DECLARE @MaVC CHAR(5);
DECLARE @TenVC NVARCHAR(20); -- Giới hạn 20 ký tự
DECLARE @LoaiVC NVARCHAR(100); -- Mô tả dài thì để ở cột Loại
DECLARE @GiaVC DECIMAL(18,0);
DECLARE @HangSX NVARCHAR(10);
DECLARE @Benh NVARCHAR(10);
DECLARE @MaLoai CHAR(2);

WHILE @i <= 50
BEGIN
    SET @MaVC = 'VC' + RIGHT('000' + CAST(@i AS VARCHAR), 3);
    
    -- Random Chó (01) hay Mèo (02)
    IF RAND() < 0.7 
    BEGIN
        SET @MaLoai = '01'; -- CHÓ
        
        -- Hãng ngắn gọn (Max 8 ký tự)
        SELECT TOP 1 @HangSX = V FROM (VALUES (N'Nobivac'), (N'Vanguard'), (N'Canigen'), (N'Recomb')) A(V) ORDER BY NEWID();
        
        -- Loại bệnh ngắn gọn (Max 8 ký tự)
        SELECT TOP 1 @Benh = V FROM (VALUES (N'Parvo'), (N'Care'), (N'Dại'), (N'5-in-1'), (N'7-in-1'), (N'Lepto')) A(V) ORDER BY NEWID();

        -- Ghép tên: "Nobivac Parvo" (Tổng tầm 10-15 ký tự -> An toàn)
        SET @TenVC = @HangSX + ' ' + @Benh;
        SET @LoaiVC = N'Vaccine cho Chó - Phòng ' + @Benh;
        
        -- Giá
        IF @Benh LIKE N'%in-1%' SET @GiaVC = 350000; ELSE SET @GiaVC = 150000;
    END
    ELSE 
    BEGIN
        SET @MaLoai = '02'; -- MÈO

        -- Hãng ngắn gọn
        SELECT TOP 1 @HangSX = V FROM (VALUES (N'Rabisin'), (N'Purevax'), (N'Feligen')) A(V) ORDER BY NEWID();

        -- Loại bệnh ngắn gọn
        SELECT TOP 1 @Benh = V FROM (VALUES (N'Dại'), (N'3-in-1'), (N'4-in-1'), (N'FIP'), (N'Giảm BC')) A(V) ORDER BY NEWID();

        -- Ghép tên
        SET @TenVC = @HangSX + ' ' + @Benh;
        SET @LoaiVC = N'Vaccine cho Mèo - Phòng ' + @Benh;

        -- Giá
        IF @Benh LIKE N'%in-1%' SET @GiaVC = 450000; ELSE SET @GiaVC = 200000;
    END

    -- Cắt chuỗi lần cuối để đảm bảo tuyệt đối không lỗi
    SET @TenVC = LEFT(@TenVC, 20);

    -- INSERT
    INSERT INTO VACCINE (MaVaccine, TenVaccine, LoaiVaccine, GiaVaccine)
    VALUES (@MaVC, @TenVC, @LoaiVC, @GiaVC);

    SET @i = @i + 1;
END;

GO

PRINT '22. Insert KHO_VACCINE...';
INSERT INTO KHO_VACCINE (MaKho, MaVaccine) SELECT MaKho, MaVaccine FROM KHO CROSS JOIN VACCINE;

GO

-- ============================================================================
-- NHÓM 4: DỊCH VỤ & GÓI TIÊM PHÒNG
-- ============================================================================

PRINT '23. Insert DICHVUYTE...';
INSERT INTO DICHVUYTE (MaDichVu, TenDichVu, LoaiDichVu) VALUES 
('DV001', N'Dịch vụ Khám Lâm Sàng', N'KhamBenh'), 
('DV002', N'Dịch vụ Tiêm Vaccine', N'TiemPhong'), 
('DV003', N'Dịch vụ Siêu âm', N'KhamBenh'),
('DV004', N'Dịch vụ X-Quang', N'KhamBenh'),
('DV005', N'Dịch vụ Spa Cắt tỉa', N'Spa');

GO

PRINT '24. Insert CUNGCAPDICHVU...';
INSERT INTO CUNGCAPDICHVU (MaChiNhanh, MaDichVu) SELECT C.MaChiNhanh, D.MaDichVu FROM CHINHANH C CROSS JOIN DICHVUYTE D;

GO

PRINT '25. Insert GOITIEMPHONG...';
INSERT INTO GOITIEMPHONG (MaGoi, TenGoi, GiaGoi) VALUES ('G001', 'Care Dog', 1000000), ('G002', 'Care Cat', 800000);

GO

PRINT '26. Insert CHITIETGOITIEMPHONG...';
INSERT INTO CHITIETGOITIEMPHONG (MaGoi, MaVaccine, SoLuong) VALUES ('G001', 'VC001', 1), ('G001', 'VC002', 2), ('G002', 'VC003', 2);

GO

PRINT '27. Insert PHIEUDANGKYTIEMPHONG...';
INSERT INTO PHIEUDANGKYTIEMPHONG (MaKhachHang, MaThuCung, NgayDangKy, MaDichVu) 
SELECT TOP 40000 
    MaKhachHang, 
    MaThuCung, 
    -- Random ngày
    DATEADD(DAY, -CAST(ABS(CHECKSUM(NEWID())) % 365 AS INT), GETDATE()),
    
    -- RANDOM DỊCH VỤ (Thay vì fix cứng 'DV002')
    -- Lấy ngẫu nhiên 1 mã dịch vụ bất kỳ trong bảng DICHVUYTE
    (SELECT TOP 1 MaDichVu FROM DICHVUYTE ORDER BY NEWID())
FROM THUCUNG
ORDER BY NEWID();

GO

PRINT '28. Insert PHIEUDANGKYGOI...';
-- Logic: Lấy 10.000 phiếu bất kỳ để gán vào Gói tiêm
INSERT INTO PHIEUDANGKYGOI (MaDangKy, MaGoi) 
SELECT TOP 10000 
    MaDangKy, 
    CASE WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0 THEN 'G001' ELSE 'G002' END
FROM PHIEUDANGKYTIEMPHONG
ORDER BY NEWID();

GO

PRINT '29. Insert PHIEUDANGKYLE...';
-- Logic: Những phiếu còn lại là tiêm lẻ
INSERT INTO PHIEUDANGKYLE (MaDangKy, MaVaccine) 
SELECT 
    P.MaDangKy, 
    (SELECT TOP 1 MaVaccine FROM VACCINE ORDER BY NEWID())
FROM PHIEUDANGKYTIEMPHONG P
WHERE P.MaDangKy NOT IN (SELECT MaDangKy FROM PHIEUDANGKYGOI);

GO

-- ============================================================================
-- NHÓM 5: KHÁM CHỮA BỆNH
-- ============================================================================

PRINT '30-35. Insert DU LIEU Y TE...';
DECLARE @k INT = 1;
DECLARE @MaThuCung INT, @MaBacSi CHAR(5), @NgayKham DATETIME;
DECLARE @MaGKTQ INT, @MaGKCK INT, @MaToa INT;
DECLARE @MaPDK INT;
DECLARE @NhietDo DECIMAL(3,1);
DECLARE @MoTaTQ NVARCHAR(50);
DECLARE @MaDichVu CHAR(5);
DECLARE @TrieuChung NVARCHAR(200);
DECLARE @ChuanDoan NVARCHAR(200);
DECLARE @HuongDanThuoc NVARCHAR(100);
DECLARE @KichBan INT; -- Biến để chọn kịch bản bệnh (0: Da liễu, 1: Tiêu hóa, 2: Hô hấp...)

WHILE @k <= 10000 
BEGIN
    -- A. SETUP CƠ BẢN
    -- Lấy random 1 thú cưng và 1 bác sĩ
    SET @MaThuCung = CAST(RAND()*120000 AS INT) + 1;
    -- Random Bác sĩ (ID từ 11-60)
    SET @MaBacSi = RIGHT('00000' + CAST((CAST(RAND()*50 AS INT) + 11) AS VARCHAR), 5);
    -- Ngày khám random
    SET @NgayKham = DATEADD(HOUR, -CAST(RAND()*4000 AS INT), GETDATE());

    -- B. XỬ LÝ KHÁM TỔNG QUÁT (Fix Nhiệt độ & Mã Đăng Ký)
    -- Random Nhiệt độ từ 37.5 đến 40.5
    SET @NhietDo = CAST(37.5 + (RAND() * 3.0) AS DECIMAL(3,1));
    
    -- Random Mô tả dựa theo nhiệt độ
    IF @NhietDo > 39.5 SET @MoTaTQ = N'Sốt cao, mệt mỏi';
    ELSE IF @NhietDo > 38.5 SET @MoTaTQ = N'Sốt nhẹ, lừ đừ';
    ELSE SET @MoTaTQ = N'Thể trạng bình thường, ổn định';

    -- Lấy Random 1 Mã phiếu đăng ký tiêm phòng (Để không bị NULL)
    -- (Lấy ngẫu nhiên 10% cơ hội là NULL - khám vãng lai, còn lại là có phiếu)
    SET @MaPDK = NULL;
    IF RAND() < 0.9 
    BEGIN
        SELECT TOP 1 @MaPDK = MaDangKy FROM PHIEUDANGKYTIEMPHONG ORDER BY NEWID();
    END

    INSERT INTO GIAYKHAMBENHTONGQUAT (NhietDo, MoTa, MaThuCung, MaPhieuDangKyTiemPhong) 
    VALUES (@NhietDo, @MoTaTQ, @MaThuCung, @MaPDK);
    SET @MaGKTQ = SCOPE_IDENTITY();

    -- C. XỬ LÝ KHÁM CHUYÊN KHOA (Fix Triệu chứng & Chẩn đoán)
    -- Chọn kịch bản bệnh ngẫu nhiên (0-4)
    SET @KichBan = ABS(CHECKSUM(NEWID())) % 5;

    IF @KichBan = 0 -- BỆNH DA LIỄU
    BEGIN
        SET @MaDichVu = 'DV005'; -- Spa/Cắt tỉa (hoặc khám da)
        SET @TrieuChung = N'Rụng lông mảng lớn, gãi nhiều, da mẩn đỏ';
        SET @ChuanDoan = N'Viêm da dị ứng / Nấm da';
        SET @HuongDanThuoc = N'Bôi trực tiếp lên vùng da bệnh';
    END
    ELSE IF @KichBan = 1 -- BỆNH TIÊU HÓA
    BEGIN
        SET @MaDichVu = 'DV003'; -- Siêu âm
        SET @TrieuChung = N'Nôn mửa dịch vàng, bỏ ăn, tiêu chảy';
        SET @ChuanDoan = N'Viêm dạ dày / Rối loạn tiêu hóa cấp';
        SET @HuongDanThuoc = N'Uống sau khi ăn, chia 2 lần';
    END
    ELSE IF @KichBan = 2 -- BỆNH HÔ HẤP
    BEGIN
        SET @MaDichVu = 'DV004'; -- X-Quang
        SET @TrieuChung = N'Ho khan, khò khè, chảy nước mũi';
        SET @ChuanDoan = N'Viêm phổi / Viêm phế quản';
        SET @HuongDanThuoc = N'Uống sáng - chiều sau ăn';
    END
    ELSE IF @KichBan = 3 -- CHẤN THƯƠNG
    BEGIN
        SET @MaDichVu = 'DV004'; -- X-Quang xương
        SET @TrieuChung = N'Đi khập khiễng chân sau, kêu đau khi chạm';
        SET @ChuanDoan = N'Rạn xương / Sai khớp nhẹ';
        SET @HuongDanThuoc = N'Uống giảm đau, hạn chế vận động';
    END
    ELSE -- KHÁM ĐỊNH KỲ/SỨC KHỎE
    BEGIN
        SET @MaDichVu = 'DV001'; -- Khám lâm sàng
        SET @TrieuChung = N'Ăn uống bình thường, đến lịch tẩy giun';
        SET @ChuanDoan = N'Sức khỏe tốt, cần bổ sung Vitamin';
        SET @HuongDanThuoc = N'Uống kèm trong bữa ăn';
    END

    -- Insert Giấy khám chuyên khoa
    INSERT INTO GIAYKHAMBENHCHUYENKHOA (NgayKham, NgayTaiKham, MaBacSi, MaThuCung, MaDichVu) 
    VALUES (@NgayKham, DATEADD(DAY, 7, @NgayKham), @MaBacSi, @MaThuCung, @MaDichVu);
    SET @MaGKCK = SCOPE_IDENTITY();

    -- Insert Chi tiết (Triệu chứng & Chẩn đoán)
    INSERT INTO CHITIETKHAMBENH_TRIEUCHUNG (MaGiayKhamChuyenKhoa, TrieuChung) VALUES (@MaGKCK, @TrieuChung);
    INSERT INTO CHITIETKHAMBENH_CHUANDOAN (MaGiayKhamChuyenKhoa, ChuanDoan) VALUES (@MaGKCK, @ChuanDoan);

    -- D. XỬ LÝ TOA THUỐC (Fix Ghi chú)
    INSERT INTO TOATHUOC (MaThuCung, MaBacSi, NgayKham, TongTien) 
    VALUES (@MaThuCung, @MaBacSi, @NgayKham, 0); -- Tổng tiền update sau
    SET @MaToa = SCOPE_IDENTITY();

    -- Insert thuốc ngẫu nhiên
    INSERT INTO CHITIETTOATHUOC (MaToaThuoc, MaThuoc, SoLuong, GhiChu)
    SELECT TOP 3 
        @MaToa, 
        MaSanPham, 
        CAST(RAND()*2 AS INT) + 1, 
        @HuongDanThuoc -- Lấy hướng dẫn từ kịch bản trên
    FROM THUOC 
    ORDER BY NEWID();
    
    -- Cập nhật tổng tiền toa thuốc
    UPDATE TOATHUOC 
    SET TongTien = (SELECT SUM(C.SoLuong * S.GiaTienSanPham) 
                    FROM CHITIETTOATHUOC C JOIN SANPHAM S ON C.MaThuoc = S.MaSanPham 
                    WHERE C.MaToaThuoc = @MaToa)
    WHERE MaToaThuoc = @MaToa;

    -- Log tiến độ
    IF @k % 2000 = 0 PRINT N'-> Đã khám bệnh ' + CAST(@k AS NVARCHAR) + N' ca...';
    
    SET @k = @k + 1;
END;

GO

PRINT '36. Insert GIAYTIEMPHONG (Lấy từ kết quả khám tổng quát)...';
-- Chỉ những ca khám tổng quát nào có "Sức khỏe ổn định" (Nhiệt độ < 39) mới được tiêm
INSERT INTO GIAYTIEMPHONG (MaVaccine, MaBacSi, LieuLuong, NgayTiem, MaGiayKhamTongQuat)
SELECT TOP 4000 
    (SELECT TOP 1 MaVaccine FROM VACCINE ORDER BY NEWID()), 
    (SELECT TOP 1 MaNhanVien FROM NHANVIEN WHERE LoaiNhanVien='BacSi' ORDER BY NEWID()), 
    1, 
    GETDATE(), 
    MaGiayKhamTongQuat 
FROM GIAYKHAMBENHTONGQUAT 
WHERE NhietDo < 39 -- Chỉ tiêm khi không sốt
ORDER BY NEWID();

GO

-- ============================================================================
-- NHÓM 6: HÓA ĐƠN & ĐÁNH GIÁ
-- ============================================================================

PRINT 'Insert 37 - 39: HOADON & CHI TIET...';

DECLARE @i INT = 1;
DECLARE @MaHD INT;
DECLARE @NgayLap DATETIME;
DECLARE @TongTien DECIMAL(18,0);
DECLARE @SoLuongMon INT;
DECLARE @MaNV CHAR(5);
DECLARE @MaKH INT;
DECLARE @PhanTramGiam DECIMAL(3,2); -- Lưu % giảm (0.00, 0.20, 0.30...)

WHILE @i <= 100000 
BEGIN
    SET @TongTien = 0;
    
    -- 1. Random thông tin cơ bản
    -- Ngày lập: Trong vòng 3 năm trở lại đây
    SET @NgayLap = DATEADD(HOUR, 8 + CAST(RAND()*13 AS INT), DATEADD(DAY, -CAST(RAND()*1000 AS INT), GETDATE()));
    -- Nhân viên: Chỉ lấy Tiếp tân (khoảng ID từ 61-110 theo logic nhân viên cũ)
    SET @MaNV = RIGHT('00000' + CAST((CAST(RAND()*50 AS INT) + 61) AS VARCHAR), 5);
    -- Khách hàng: Random từ 1 đến 80.000
    SET @MaKH = CAST(RAND()*80000 AS INT) + 1;
    
    -- [LOGIC QUAN TRỌNG]: Lấy % Giảm giá dựa trên Hạng thành viên hiện tại
    SET @PhanTramGiam = 0; -- Mặc định là khách vãng lai (0%)

    SELECT @PhanTramGiam = H.GiamGia
    FROM KHACHHANGTHANHVIEN K
    JOIN HANGTHANHVIEN H ON K.TenHang = H.TenHang
    WHERE K.MaKhachHang = @MaKH;

    -- Đề phòng trường hợp NULL (khách không có thẻ thành viên)
    IF @PhanTramGiam IS NULL SET @PhanTramGiam = 0;

    -- 2. Tạo Header Hóa đơn (Lưu % giảm giá vào cột GiamGia để đối chiếu sau này)
    INSERT INTO HOADON (NgayLap, GiamGia, TongTien, MaNhanVien, MaKhachHang)
    VALUES (@NgayLap, @PhanTramGiam, 0, @MaNV, @MaKH);
    
    SET @MaHD = SCOPE_IDENTITY();

    -- 3. Tạo Chi tiết Sản phẩm (Mua từ 1-3 món)
    SET @SoLuongMon = CAST(RAND()*3 AS INT) + 1;

    INSERT INTO HOADON_SANPHAM (MaHoaDon, MaSanPham, SoLuong) 
    SELECT TOP (@SoLuongMon) 
        @MaHD, 
        MaSanPham, 
        CAST(RAND()*5 AS INT) + 1 -- Số lượng mua mỗi món: 1-5 cái
    FROM SANPHAM 
    ORDER BY NEWID(); -- Random sản phẩm không trùng lặp

    -- Cộng tiền hàng vào Tổng tiền
    SELECT @TongTien = SUM(C.SoLuong * S.GiaTienSanPham)
    FROM HOADON_SANPHAM C 
    JOIN SANPHAM S ON C.MaSanPham = S.MaSanPham
    WHERE C.MaHoaDon = @MaHD;

    -- 4. Xử lý Dịch vụ Y tế (30% hóa đơn có sử dụng dịch vụ)
    IF RAND() < 0.3 
    BEGIN
        -- Random 1 dịch vụ bất kỳ
        INSERT INTO THANHTOANDICHVUYTE (MaHoaDon, MaDichVu) 
        VALUES (@MaHD, (SELECT TOP 1 MaDichVu FROM DICHVUYTE ORDER BY NEWID()));
        
        -- Cộng thêm chi phí dịch vụ (Giả định trung bình 200k/dịch vụ vì bảng DICHVU không có cột giá)
        SET @TongTien = @TongTien + 200000; 
    END

    -- 5. CHỐT TỔNG TIỀN (Áp dụng giảm giá VIP/Thân thiết)
    -- Công thức: Tiền phải trả = Tổng tiền * (1 - %Giảm)
    SET @TongTien = @TongTien * (1.0 - @PhanTramGiam);

    -- Cập nhật lại vào bảng Hóa đơn
    UPDATE HOADON SET TongTien = @TongTien WHERE MaHoaDon = @MaHD;

    -- Log tiến độ (Mỗi 10k dòng báo 1 lần)
    IF @i % 10000 = 0 PRINT N'-> Đã lập ' + CAST(@i AS NVARCHAR) + N' hóa đơn (Có tính giảm giá VIP)...';
    
    SET @i = @i + 1;
END;

GO

PRINT '40. Insert DANHGIAYTE...';

INSERT INTO DANHGIAYTE (BinhLuan, MucDoHaiLong, ThaiDoNhanVien, DiemChatLuongDichVu, MaHoaDon)
SELECT 
    -- 1. SINH BÌNH LUẬN (Bao bọc ISNULL để chặn tuyệt đối lỗi NULL)
    ISNULL(
        CASE 
            WHEN RandomScore = 5 THEN 
                -- Có 5 câu -> Chia dư cho 5 cộng 1 (Ra từ 1-5)
                CHOOSE(ABS(CHECKSUM(NEWID())) % 5 + 1, 
                    N'Tuyệt vời', N'Bác sĩ rất tận tâm', N'Rất hài lòng', N'Dịch vụ chuyên nghiệp', N'Sẽ quay lại')
            
            WHEN RandomScore = 4 THEN 
                -- Có 4 câu -> Chia dư cho 4 cộng 1 (Ra từ 1-4)
                CHOOSE(ABS(CHECKSUM(NEWID())) % 4 + 1, 
                    N'Khá ổn', N'Bác sĩ nhiệt tình', N'Sạch sẽ, tốt', N'Cần cải thiện thời gian chờ')
            
            WHEN RandomScore = 3 THEN 
                -- Có 3 câu
                CHOOSE(ABS(CHECKSUM(NEWID())) % 3 + 1, 
                    N'Tạm được', N'Hơi đông khách', N'Bình thường')
            
            ELSE -- Điểm 1, 2
                -- Có 3 câu
                CHOOSE(ABS(CHECKSUM(NEWID())) % 3 + 1, 
                    N'Thất vọng', N'Phục vụ chậm', N'Giá hơi cao')
        END, 
        N'Dịch vụ ổn' -- Giá trị Fallback (Dự phòng cuối cùng nếu vẫn bị NULL)
    ) AS BinhLuan,
    
    -- 2. ĐIỂM SỐ
    RandomScore AS MucDoHaiLong,
    
    -- Thái độ (Thường cao hơn hoặc bằng điểm hài lòng)
    CASE WHEN RandomScore < 5 THEN RandomScore + 1 ELSE 5 END AS ThaiDoNhanVien,
    
    -- Chất lượng
    RandomScore AS DiemChatLuongDichVu,
    
    MaHoaDon
FROM (
    -- Subquery lấy hóa đơn DV và sinh điểm ngẫu nhiên
    SELECT TOP 3000 
        MaHoaDon,
        CASE 
            WHEN RAND(CHECKSUM(NEWID())) < 0.6 THEN 5 -- 60% 5 sao
            WHEN RAND(CHECKSUM(NEWID())) < 0.9 THEN 4 -- 30% 4 sao
            ELSE CAST(RAND(CHECKSUM(NEWID())) * 3 AS INT) + 1 -- 10% 1-3 sao
        END AS RandomScore
    FROM THANHTOANDICHVUYTE
    ORDER BY NEWID()
) AS TempTable;

GO

PRINT '41. Insert DANHGIAMUAHANG...';

INSERT INTO DANHGIAMUAHANG (BinhLuan, MucDoHaiLong, ThaiDoNhanVien, MaHoaDon)
SELECT 
    -- 1. SINH BÌNH LUẬN (Có ISNULL bảo vệ)
    ISNULL(
        CASE 
            WHEN RandomScore = 5 THEN 
                CHOOSE(ABS(CHECKSUM(NEWID())) % 5 + 1, 
                    N'Hàng chất lượng', N'Giao hàng nhanh', N'Đóng gói kỹ', N'Rất ưng ý', N'Pet rất thích')
            WHEN RandomScore = 4 THEN 
                CHOOSE(ABS(CHECKSUM(NEWID())) % 3 + 1, 
                    N'Hàng ổn so với giá', N'Giao hơi chậm xíu', N'Tạm được')
            ELSE 
                CHOOSE(ABS(CHECKSUM(NEWID())) % 3 + 1, 
                    N'Hàng không giống hình', N'Chất lượng kém', N'Đóng gói sơ sài')
        END,
        N'Đã nhận hàng' -- Fallback text
    ),
    
    -- 2. ĐIỂM SỐ
    RandomScore,
    
    -- 3. THÁI ĐỘ (Thường >= Điểm hài lòng)
    CASE WHEN RandomScore < 5 THEN RandomScore + 1 ELSE 5 END,
    
    MaHoaDon
FROM (
    -- [FIX LỖI TẠI ĐÂY]:
    -- Thay vì SELECT DISTINCT TOP... ORDER BY NEWID() (Lỗi cú pháp)
    -- Ta dùng GROUP BY MaHoaDon để gom nhóm duy nhất, sau đó mới Random
    SELECT TOP 5000 
        MaHoaDon,
        CASE 
            WHEN RAND(CHECKSUM(NEWID())) < 0.7 THEN 5 -- 70% 5 sao
            WHEN RAND(CHECKSUM(NEWID())) < 0.9 THEN 4 -- 20% 4 sao
            ELSE CAST(RAND(CHECKSUM(NEWID())) * 3 AS INT) + 1 
        END AS RandomScore
    FROM HOADON_SANPHAM
    GROUP BY MaHoaDon -- <--- Thay thế cho DISTINCT
    ORDER BY NEWID()
) AS TempTable;

GO

PRINT '=== HOÀN TẤT TOÀN BỘ DỮ LIỆU ===';
GO

-- Cài đặt indexes
GO
DBCC FREEPROCCACHE
--CÀI INDEX
--1. Non-clustered Index với key column là TenSanPham để hỗ trợ lọc dữ liệu; các thuộc tính MaSanPham, GiaTienSanPham được include nhằm cover truy vấn và giảm truy cập bảng gốc.
CREATE NONCLUSTERED INDEX IDX_SANPHAM_TenSanPham
ON SANPHAM(TenSanPham)
INCLUDE (MaSanPham, GiaTienSanPham);

--2. Composite Non-clustered Index: NgayBatDau, NgayKetThuc (Lọc theo thời gian)
CREATE NONCLUSTERED INDEX IDX_LICHSUGIASANPHAM_MaSanPham_Ngay
ON LICHSUGIASANPHAM (MaSanPham, NgayBatDau, NgayKetThuc)
INCLUDE (Gia);

--3. Composite Non-clustered Index trên (MaSanPham, SoLuong DESC) của CHITIETTONKHO Include MaKho". 
CREATE NONCLUSTERED INDEX IDX_CHITIETTONKHO_MaSP_SoLuong
ON CHITIETTONKHO (MaSanPham ASC, SoLuong DESC)
INCLUDE (MaKho); 
GO

--4. Composite Non-clustered Index trên (MaKhachHang, NgayLap Desc)
CREATE NONCLUSTERED INDEX IDX_HOADON_MaKhachHang_NgayLap
ON HOADON (MaKhachHang, NgayLap DESC)
INCLUDE (MaHoaDon, TongTien);

--5. Index tìm kiếm Khách hàng theo SĐT 
CREATE NONCLUSTERED INDEX IDX_KHACHHANG_SoDienThoai
ON KHACHHANG(SoDienThoai)
INCLUDE (MaKhachHang);
--6. Index tìm kiếm Thú cưng (Composite: Lọc theo Chủ trước -> Tìm Tên sau)
CREATE NONCLUSTERED INDEX IDX_THUCUNG_MaKH_Ten
ON THUCUNG(MaKhachHang, TenThuCung)

-- 7. Index cho bảng LICHHEN: 
-- Giúp tìm nhanh các khung giờ đã đặt của một bác sĩ trong ngày cụ thể.
-- Đây là yếu tố then chốt để xử lý 10 triệu lượt truy xuất/ngày.
CREATE NONCLUSTERED INDEX IX_LICHHEN_MaBS_Ngay_Gio
ON LICHHEN (MaBacSi, NgayHen, GioHen);
GO

--8.
CREATE INDEX IX_NHANVIEN_BacSi ON NHANVIEN(LoaiNhanVien) INCLUDE (HoTen);
--9.
CREATE INDEX IX_GIAYKHAM_MaBacSi ON GIAYKHAMBENHCHUYENKHOA(MaBacSi);
--10.
CREATE INDEX IX_TOATHUOC_MaBacSi ON TOATHUOC(MaBacSi) INCLUDE (TongTien);

-- 11. Index cho bảng LICHLAMVIECBACSI: 
-- Giúp kiểm tra trạng thái 'Trống' của bác sĩ ngay lập tức.
CREATE NONCLUSTERED INDEX IX_LLVBS_Ngay_MaBS_TrangThai
ON LICHLAMVIECBACSI (Ngay, MaBacSi, TrangThai);
GO
--12. 
CREATE INDEX IX_HOADONSP_MaSP ON HOADON_SANPHAM(MaSanPham) INCLUDE (SoLuong);
--13.
CREATE INDEX IX_NHANVIEN_ChiNhanh ON NHANVIEN(MaChiNhanh, MaNhanVien);
--14.
CREATE INDEX IX_HOADON_MaNV ON HOADON(MaNhanVien) INCLUDE (TongTien);