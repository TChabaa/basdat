CREATE DATABASE PERADILAN;

USE PERADILAN;


-- Drop tables with foreign key constraints in the correct order
DROP TABLE IF EXISTS [MEREPRESENTASIKAN];
DROP TABLE IF EXISTS [MENJAKSAI];
DROP TABLE IF EXISTS [MENGURUSI];
DROP TABLE IF EXISTS [DIAJUKAN];
DROP TABLE IF EXISTS [DIGUGAT];
DROP TABLE IF EXISTS [MENUNTUT];
DROP TABLE IF EXISTS [NOTA_TANGGAPAN];
DROP TABLE IF EXISTS [NOTA_PEMBELAAN];
DROP TABLE IF EXISTS [SURAT_PELIMPAHAN];
DROP TABLE IF EXISTS [BARANG_BUKTI];
DROP TABLE IF EXISTS [BERKAS];
DROP TABLE IF EXISTS [MEDIASI];
DROP TABLE IF EXISTS [PUTUSAN_PERDATA];
DROP TABLE IF EXISTS [TERGUGAT];
DROP TABLE IF EXISTS [PENGGUGAT];
DROP TABLE IF EXISTS [TERDAKWA];
DROP TABLE IF EXISTS [TURUT_TERGUGAT];
DROP TABLE IF EXISTS [BADAN_HUKUM];
DROP TABLE IF EXISTS [PERSEORANGAN];
DROP TABLE IF EXISTS [SUBJEK_HUKUM];
DROP TABLE IF EXISTS [ADVOKAT];
DROP TABLE IF EXISTS [PUTUSAN_PIDANA];
DROP TABLE IF EXISTS [SAKSI];
DROP TABLE IF EXISTS [JAKSA_PENUNTUN_UMUM];
DROP TABLE IF EXISTS [PIDANA];
DROP TABLE IF EXISTS [PERDATA];
DROP TABLE IF EXISTS [RIWAYAT];
DROP TABLE IF EXISTS [SIDANG];
DROP TABLE IF EXISTS [PERKARA];
DROP TABLE IF EXISTS [HAKIM];
DROP TABLE IF EXISTS [PENGADILAN];


-- PENGADILAN
CREATE TABLE PENGADILAN (
    Id_Pengadilan NVARCHAR(128),
    Nama_Pengadilan NVARCHAR(128),
    Alamat_Pengadilan NVARCHAR(128),
    Kota_Pengadilan NVARCHAR(128),
    Tingkatan NVARCHAR(128),
    Notelp_Pengadilan NVARCHAR(128),

    CONSTRAINT [PK_PND] PRIMARY KEY ([Id_Pengadilan]),
);

-- HAKIM
CREATE TABLE HAKIM (
    NIP NVARCHAR(128),
    Nama NVARCHAR(128),
    Gol NVARCHAR(128),
    Id_Pengadilan NVARCHAR(128),

    CONSTRAINT [PK_H] PRIMARY KEY ([NIP]),
    CONSTRAINT [FK_H] FOREIGN KEY ([Id_Pengadilan]) REFERENCES [PENGADILAN] ([Id_Pengadilan]),
);

-- PERKARA
CREATE TABLE PERKARA (
    No_Perkara NVARCHAR(128),
    Klasifikasi_Perkara NVARCHAR(128),
    Tanggal_Register DATE,
    Jenis NVARCHAR(128),
    Id_Pengadilan_Asal NVARCHAR(128),
    Id_Pengadilan_Banding NVARCHAR(128),
    Id_Banding NVARCHAR(128),


    CONSTRAINT [PK_PR] PRIMARY KEY ([No_Perkara]),
    CONSTRAINT [FK_PR_AS] FOREIGN KEY ([Id_Pengadilan_Asal]) REFERENCES [PENGADILAN] ([Id_Pengadilan]),
    CONSTRAINT [FK_PR_BAN] FOREIGN KEY ([Id_Pengadilan_Banding]) REFERENCES [PENGADILAN] ([Id_Pengadilan])
);

-- SIDANG
CREATE TABLE SIDANG (
    No_Sidang NVARCHAR(128),
    Tanggal_Sidang DATE,
    Agenda NVARCHAR(128),
    Ruang NVARCHAR(128),
    Waktu TIME,
    No_Perkara NVARCHAR(128)

    CONSTRAINT [PK_SD] PRIMARY KEY ([No_Sidang]),
    CONSTRAINT [FK_SD] FOREIGN KEY ([No_Perkara]) REFERENCES [PERKARA] ([No_Perkara])
);

-- RIWAYAT
CREATE TABLE RIWAYAT (
    No_Surat NVARCHAR(128),
    Tanggal DATE,
    Tahapan NVARCHAR(128),
    Proses NVARCHAR(128),
    No_Perkara NVARCHAR(128)

    CONSTRAINT [PK_RW] PRIMARY KEY ([No_Surat]),
    CONSTRAINT [FK_RW] FOREIGN KEY ([No_Perkara]) REFERENCES [PERKARA] ([No_Perkara])
);


-- PIDANA
CREATE TABLE PIDANA (
    No_Perkara NVARCHAR(128),
    Tuntutan TEXT,
    Dakwaan TEXT,

    CONSTRAINT [PK_PD] PRIMARY KEY ([No_Perkara]),
    CONSTRAINT [FK_PD] FOREIGN KEY ([No_Perkara]) REFERENCES [PERKARA] ([No_Perkara])
);

-- JAKSA_PENUNTUN_UMUM
CREATE TABLE JAKSA_PENUNTUN_UMUM (
    NIP NVARCHAR(128),
    Nama NVARCHAR(128),
    NoTelp NVARCHAR(128),
    Kejaksaan NVARCHAR(128),

    CONSTRAINT [PK_JP] PRIMARY KEY ([NIP])
);

-- SAKSI
CREATE TABLE SAKSI (
    NIK NVARCHAR(128),
    Hubungan NVARCHAR(128),
    Alamat NVARCHAR(128),
    Nama NVARCHAR(128),
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK_SA] PRIMARY KEY ([NIK]),
    CONSTRAINT [FK_SA] FOREIGN KEY ([No_Perkara]) REFERENCES [PIDANA] ([No_Perkara])
);

-- PUTUSAN_PIDANA
CREATE TABLE PUTUSAN_PIDANA (
    No_Putusan NVARCHAR(128) PRIMARY KEY,
    Tanggal_Putusan DATE,
    Amar_Putusan TEXT,
    Status_Putusan NVARCHAR(128),
    No_Perkara NVARCHAR(128) REFERENCES PIDANA(No_Perkara),
    Id_SubjekHukum NVARCHAR(128)
);

-- ADVOKAT
CREATE TABLE ADVOKAT (
    NIA NVARCHAR(128),
    Nama NVARCHAR(128),
    Nama_Instansi NVARCHAR(128),
    NoTelp NVARCHAR(128),

    CONSTRAINT [PK_AD] PRIMARY KEY ([NIA])
);

-- SUBJEK_HUKUM
CREATE TABLE SUBJEK_HUKUM (
    Id_SubjekHukum NVARCHAR(128) ,
    Alamat NVARCHAR(128),
    Jenis NVARCHAR(128),

    CONSTRAINT [PK_SH] PRIMARY KEY ([Id_SubjekHukum])
);

-- PERSEORANGAN
CREATE TABLE PERSEORANGAN (
    NIK NVARCHAR(128) ,
    Nama NVARCHAR(128),
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_PS] PRIMARY KEY ([NIK]),
    CONSTRAINT [FK_PS] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);

-- BADAN_HUKUM
CREATE TABLE BADAN_HUKUM (
    NIB NVARCHAR(128) ,
    Nama NVARCHAR(128),
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_BH] PRIMARY KEY ([NIB]),
    CONSTRAINT [FK_BH] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);


-- TERDAKWA, PENGGUGAT, TERGUGAT
CREATE TABLE TERDAKWA (
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_TD] PRIMARY KEY ([Id_SubjekHukum]),
    CONSTRAINT [FK_TD] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);

CREATE TABLE PENGGUGAT (
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_PG] PRIMARY KEY ([Id_SubjekHukum]),
    CONSTRAINT [FK_PG] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);

CREATE TABLE TERGUGAT (
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_TG] PRIMARY KEY ([Id_SubjekHukum]),
    CONSTRAINT [FK_TG] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);

-- PERDATA
CREATE TABLE PERDATA (
    No_Perkara NVARCHAR(128),
    Petitum TEXT,
    Prodeo NVARCHAR(128),

    CONSTRAINT [PK_PRD] PRIMARY KEY ([No_Perkara]),
    CONSTRAINT [FK_PRD]  FOREIGN KEY ([No_Perkara]) REFERENCES [PERKARA] ([No_Perkara]),
);

-- PUTUSAN_PERDATA
CREATE TABLE PUTUSAN_PERDATA (
    No_Putusan NVARCHAR(128),
    Tanggal_Putusan DATE,
    Nilai_Ganti NVARCHAR(128),
    Amar_Putusan TEXT,
    Verstek NVARCHAR(128),
    Status_Putusan NVARCHAR(128),
    Tanggal_Minustasi DATE,
    Sumber_Hukum NVARCHAR,
    No_Perkara NVARCHAR(128) ,

    CONSTRAINT [PK_PPD] PRIMARY KEY ([No_Putusan]),
    CONSTRAINT [FK_PPD] FOREIGN KEY ([No_Perkara]) REFERENCES [PERDATA] ([No_Perkara])
);

-- MEDIASI
CREATE TABLE MEDIASI (
    No_Surat NVARCHAR(128) ,
    Nama_Mediator NVARCHAR(128),
    Hasil_Mediasi TEXT,
    Tanggal_Mulai DATE,
    Tanggal_Hasil DATE,
    Status_Mediator NVARCHAR(128),
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK_ME] PRIMARY KEY ([No_Surat]),
    CONSTRAINT [FK_ME]  FOREIGN KEY ([No_Perkara]) REFERENCES [PERDATA] ([No_Perkara]),
);

-- BERKAS
CREATE TABLE BERKAS (
    Kd_Berkas NVARCHAR(128) ,
    TanggalDiajukan DATE,
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK_BE] PRIMARY KEY ([Kd_Berkas]),
    CONSTRAINT [FK_BE] FOREIGN KEY ([No_Perkara]) REFERENCES [PIDANA] ([No_Perkara])
);

-- BARANG_BUKTI
CREATE TABLE BARANG_BUKTI (
    Kd_Berkas NVARCHAR(128),
    Deskripsi TEXT,
    Objek NVARCHAR(128),

    CONSTRAINT [PK_BB] PRIMARY KEY ([Kd_Berkas]),
    CONSTRAINT [FK_BB] FOREIGN KEY ([Kd_Berkas]) REFERENCES [BERKAS] ([Kd_Berkas]),
);

-- NOTA_PEMBELAAN
CREATE TABLE NOTA_PEMBELAAN (
    Kd_Berkas NVARCHAR(128),
    Isi TEXT,
    Argumen_Hukum NVARCHAR(128),

    CONSTRAINT [PK_NP] PRIMARY KEY ([Kd_Berkas]),
    CONSTRAINT [FK_NP] FOREIGN KEY ([Kd_Berkas]) REFERENCES [BERKAS] ([Kd_Berkas]),
);

-- NOTA_TANGGAPAN
CREATE TABLE NOTA_TANGGAPAN (
    Kd_Berkas NVARCHAR(128),
    Isi TEXT,
    Penilaian TEXT,

    CONSTRAINT [PK_NT] PRIMARY KEY ([Kd_Berkas]),
    CONSTRAINT [FK_NT] FOREIGN KEY ([Kd_Berkas]) REFERENCES [BERKAS] ([Kd_Berkas]),
);

-- SURAT_PELIMPAHAN
CREATE TABLE SURAT_PELIMPAHAN (
    Kd_Berkas NVARCHAR(128),
    Nomor_Surat NVARCHAR(128),
    Tanggal_Pelimpahan DATE,

    CONSTRAINT [PK_SPL] PRIMARY KEY ([Kd_Berkas]),
    CONSTRAINT [FK_SPL] FOREIGN KEY ([Kd_Berkas]) REFERENCES [BERKAS] ([Kd_Berkas]),
);

CREATE TABLE MENGURUSI (
    No_Perkara NVARCHAR(128) ,
    NIP NVARCHAR(128),
    Posisi_Hakim VARCHAR(128),

    CONSTRAINT [PK_MGS] PRIMARY KEY ([No_Perkara], [NIP]),
    CONSTRAINT [FK_MGS_NP] FOREIGN KEY ([No_Perkara]) REFERENCES [PERKARA] ([No_Perkara]),
    CONSTRAINT [FK_MGS_NIP] FOREIGN KEY ([NIP]) REFERENCES [HAKIM] ([NIP])
);

CREATE TABLE MENJAKSAI (
    NIP NVARCHAR(128),
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK_MJS] PRIMARY KEY ([NIP], [No_Perkara]),
    CONSTRAINT [FK_MJS_NIP] FOREIGN KEY ([NIP]) REFERENCES [JAKSA_PENUNTUN_UMUM] ([NIP]),
    CONSTRAINT [FK_MJS_NP] FOREIGN KEY ([No_Perkara]) REFERENCES [PIDANA] ([No_Perkara])
);


-- MENUNTUT
CREATE TABLE MENUNTUT (
    No_Perkara NVARCHAR(128) ,
    Id_SubjekHukum NVARCHAR(128),

    CONSTRAINT [PK_MN] PRIMARY KEY ([No_Perkara], [Id_SubjekHukum]),
    CONSTRAINT [FK_MN_NP] FOREIGN KEY ([No_Perkara]) REFERENCES [PIDANA] ([No_Perkara]),
    CONSTRAINT [FK_MN_IDS] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [TERDAKWA] ([Id_SubjekHukum])
);

-- MEREPRESENTASIKAN
CREATE TABLE MEREPRESENTASIKAN (
    NIA NVARCHAR(128),
    Id_SubjekHukum NVARCHAR(128)

    CONSTRAINT [PK_MR] PRIMARY KEY ([NIA], [Id_SubjekHukum]),
    CONSTRAINT [FK_MR_NIA] FOREIGN KEY ([NIA]) REFERENCES [ADVOKAT] ([NIA]),
    CONSTRAINT [FK_MR_IDS] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [SUBJEK_HUKUM] ([Id_SubjekHukum])
);

-- DIAJUKAN
CREATE TABLE DIAJUKAN (
    Id_SubjekHukum NVARCHAR(128),
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK] PRIMARY KEY ([Id_SubjekHukum], [No_Perkara]),
    CONSTRAINT [FK_DIA_IDS] FOREIGN KEY ([Id_SubjekHukum]) REFERENCES [PENGGUGAT] ([Id_SubjekHukum]),
    CONSTRAINT [FK_DIA_NP] FOREIGN KEY ([No_Perkara]) REFERENCES [PERDATA] ([No_Perkara])
    
);

-- DIGUGAT
CREATE TABLE DIGUGAT (
    Id_SubjekHukum_Tergugat NVARCHAR(128),
    No_Perkara NVARCHAR(128),

    CONSTRAINT [PK_DG] PRIMARY KEY ([No_Perkara], [Id_SubjekHukum_Tergugat]),
    CONSTRAINT [FK_DG_NP] FOREIGN KEY ([No_Perkara]) REFERENCES [PERDATA] ([No_Perkara]),
    CONSTRAINT [FK_DG_IDS] FOREIGN KEY ([Id_SubjekHukum_Tergugat]) REFERENCES [TERGUGAT] ([Id_SubjekHukum]),
);
