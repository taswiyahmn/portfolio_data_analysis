SET SQL_SAFE_UPDATES = 0;

UPDATE performa_produk
SET
    `Tingkat Konversi Produk Dimasukkan ke Keranjang` = REPLACE(`Tingkat Konversi Produk Dimasukkan ke Keranjang`, '%', ''),
    `Tingkat Konversi (Pesanan yang Dibuat)` = REPLACE(`Tingkat Konversi (Pesanan yang Dibuat)`, '%', ''),
    `Tingkat Konversi (Pesanan Siap Dikirim)` = REPLACE(`Tingkat Konversi (Pesanan Siap Dikirim)`, '%', ''),
    `Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)` = REPLACE(`Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)`, '%', ''),
    `% Pembelian Ulang (Pesanan Siap Dikirim)` = REPLACE(`% Pembelian Ulang (Pesanan Siap Dikirim)`, '%', '');
    
UPDATE performa_produk SET `Tingkat Pengunjung Melihat Tanpa Membeli` = REPLACE(`Tingkat Pengunjung Melihat Tanpa Membeli`, '%', '');

UPDATE performa_produk
SET 
	`Tingkat Konversi Produk Dimasukkan ke Keranjang` = REPLACE(`Tingkat Konversi Produk Dimasukkan ke Keranjang`, ',', '.'),
    `Tingkat Konversi (Pesanan yang Dibuat)` = REPLACE(`Tingkat Konversi (Pesanan yang Dibuat)`, ',', '.'),
    `Tingkat Konversi (Pesanan Siap Dikirim)` = REPLACE(`Tingkat Konversi (Pesanan Siap Dikirim)`, ',', '.'),
    `Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)` = REPLACE(`Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)`, ',', '.'),
    `% Pembelian Ulang (Pesanan Siap Dikirim)` = REPLACE(`% Pembelian Ulang (Pesanan Siap Dikirim)`, ',', '.'),
	`Tingkat Pengunjung Melihat Tanpa Membeli` = REPLACE(`Tingkat Pengunjung Melihat Tanpa Membeli`, ',', '.');

ALTER TABLE performa_produk
MODIFY COLUMN `Tingkat Konversi Produk Dimasukkan ke Keranjang` DECIMAL(5, 2),
MODIFY COLUMN `Tingkat Konversi (Pesanan yang Dibuat)` DECIMAL(5, 2),
MODIFY COLUMN `Tingkat Konversi (Pesanan Siap Dikirim)` DECIMAL(5, 2),
MODIFY COLUMN `Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)` DECIMAL(5, 2),
MODIFY COLUMN `% Pembelian Ulang (Pesanan Siap Dikirim)` DECIMAL(5, 2),
MODIFY COLUMN `Tingkat Pengunjung Melihat Tanpa Membeli` DECIMAL(5, 2);    

UPDATE performa_produk
SET 
	`Total Penjualan (Pesanan Dibuat) (IDR)` = CAST(REPLACE(`Total Penjualan (Pesanan Dibuat) (IDR)`, '.', '') AS UNSIGNED),
	`Penjualan (Pesanan Siap Dikirim) (IDR)` = CAST(REPLACE(`Penjualan (Pesanan Siap Dikirim) (IDR)`, '.', '') AS UNSIGNED);

UPDATE performa_produk
SET 
	`Nama Variasi` = REPLACE(`Nama Variasi`, '-', 'Tidak ada variasi');
    
ALTER TABLE performa_produk
MODIFY COLUMN `Total Penjualan (Pesanan Dibuat) (IDR)` DECIMAL(10, 2),
MODIFY COLUMN `Penjualan (Pesanan Siap Dikirim) (IDR)` DECIMAL(10, 2);

ALTER TABLE performa_produk
DROP COLUMN `MyUnknownColumn`,
DROP COLUMN `Status Variasi Saat Ini`,
DROP COLUMN `Kode Variasi.1`,
DROP COLUMN `SKU Induk`,
DROP COLUMN `Rata-rata Hari Pembelian Terulang (Pesanan Siap Dikirim)`;

ALTER TABLE performa_produk
DROP COLUMN `Nama Variasi`,
DROP COLUMN Nama_Variasi;

SELECT * FROM performa_produk
WHERE `Kode Produk` = '' OR `Produk` = '' OR `Status Produk Saat Ini` = '' OR `Kode Variasi` = '' OR `Nama Variasi` = '' OR `Pengunjung Produk (Kunjungan)` = '' OR `Halaman Produk Dilihat` = '' OR `Pengunjung Melihat Tanpa Membeli` = '' OR `Tingkat Pengunjung Melihat Tanpa Membeli` = '' OR `Klik Pencarian` = '' OR `Suka` = '' OR `Pengunjung Produk (Menambahkan Produk ke Keranjang)` = '' OR `Dimasukkan ke Keranjang (Produk)` = '' OR `Tingkat Konversi Produk Dimasukkan ke Keranjang` = '' OR `Total Pembeli (Pesanan Dibuat)` = '' OR `Produk (Pesanan Dibuat)` = '' OR `Total Penjualan (Pesanan Dibuat) (IDR)` = '' OR `Tingkat Konversi (Pesanan yang Dibuat)` = '' OR `Total Pembeli (Pesanan Siap Dikirim)` = '' OR `Total Pembeli (Pesanan Siap Dikirim)` = '' OR `Produk (Pesanan Siap Dikirim)` = '' OR `Penjualan (Pesanan Siap Dikirim) (IDR)` = '' OR `Tingkat Konversi (Pesanan Siap Dikirim)` = '' OR `Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)` = '' OR `% Pembelian Ulang (Pesanan Siap Dikirim)` = '';

UPDATE performa_produk
SET 
	`Kode Variasi` = REPLACE(`Kode Variasi`, '-', 'Tidak ada kode variasi');

ALTER TABLE performa_produk
ADD Kode_Produk BIGINT,
ADD Nama_Produk varchar(100),
ADD Status_Produk_Saat_Ini varchar(15),
ADD Kode_Variasi BIGINT,
ADD Nama_Variasi varchar(50),
ADD Pengunjung_Produk_Kunjungan INT(5),
ADD Halaman_Produk_Dilihat INT(5),
ADD Pengunjung_Melihat_Tanpa_Membeli INT(5),
ADD Klik_Pencarian INT(5),
ADD Klik_Suka INT(5),
ADD Pengunjung_Produk_Menambahkan_Produk_ke_Keranjang INT(5),
ADD Dimasukkan_ke_Keranjang_Produk INT(5),
ADD Total_Pembeli_Pesanan_Dibuat INT(5),
ADD Produk_Pesanan_Dibuat INT(5),    
ADD Total_Penjualan_Pesanan_Dibuat_IDR DECIMAL(10,2),
ADD Total_Pembeli_Pesanan_Siap_Dikirim INT(5), 
ADD Produk_Pesanan_Siap_Dikirim INT(5), 
ADD Penjualan_Pesanan_Siap_Dikirim_IDR DECIMAL(10,2); 

UPDATE performa_produk
SET Kode_Produk = `Kode Produk`,
	Nama_Produk = `Produk`,
	Status_Produk_Saat_Ini= `Status Produk Saat Ini`,
	Kode_Variasi= `Kode Variasi`,
    Nama_Variasi = `Nama Variasi`;

 UPDATE performa_produk p
JOIN (
    SELECT
        `Produk`,
        SUM(`Pengunjung Produk (Kunjungan)`) AS pengunjung_produk_kunjungan,
        SUM(`Halaman Produk Dilihat`) AS halaman_produk_dilihat,
        SUM(`Pengunjung Melihat Tanpa Membeli`) AS pengunjung_melihat_tanpa_membeli,
        SUM(`Klik Pencarian`) AS klik_pencarian,
        SUM(`Suka`) AS suka,
        SUM(`Pengunjung Produk (Menambahkan Produk ke Keranjang)`) AS pengunjung_produk_menambahkan_produk_ke_keranjang,
        SUM(`Dimasukkan ke Keranjang (Produk)`) AS dimasukkan_ke_keranjang_produk,
        SUM(`Total Pembeli (Pesanan Dibuat)`) AS total_pembeli_pesanan_dibuat,
        SUM(`Produk (Pesanan Dibuat)`) AS produk_pesanan_dibuat,
        SUM(`Total Penjualan (Pesanan Dibuat) (IDR)`) AS total_penjualan_pesanan_dibuat_IDR,
        SUM(`Total Pembeli (Pesanan Siap Dikirim)`) AS total_pembeli_pesanan_siap_dikirim,
        SUM(`Produk (Pesanan Siap Dikirim)`) AS produk_pesanan_siap_dikirim,
        SUM(`Penjualan (Pesanan Siap Dikirim) (IDR)`) AS penjualan_pesanan_siap_dikirim_IDR
    FROM performa_produk
    GROUP BY `Produk`
) AS aggregated_data
ON p.`Produk` = aggregated_data.`Produk`
SET 
    p.Pengunjung_Produk_Kunjungan = aggregated_data.`pengunjung_produk_kunjungan`,
    p.Halaman_Produk_Dilihat = aggregated_data.`halaman_produk_dilihat`,
    p.Pengunjung_Melihat_Tanpa_Membeli = aggregated_data.`pengunjung_melihat_tanpa_membeli`,
    p.Klik_Pencarian = aggregated_data.`klik_pencarian`,
    p.Klik_Suka = aggregated_data.`suka`,
    p.Pengunjung_Produk_Menambahkan_Produk_ke_Keranjang = aggregated_data.`pengunjung_produk_menambahkan_produk_ke_keranjang`,
    p.Dimasukkan_ke_Keranjang_Produk = aggregated_data.`dimasukkan_ke_keranjang_produk`,
    p.Total_Pembeli_Pesanan_Dibuat = aggregated_data.`total_pembeli_pesanan_dibuat`,
    p.Produk_Pesanan_Dibuat = aggregated_data.`produk_pesanan_dibuat`,
    p.Total_Penjualan_Pesanan_Dibuat_IDR = aggregated_data.`total_penjualan_pesanan_dibuat_IDR`,
    p.Total_Pembeli_Pesanan_Siap_Dikirim = aggregated_data.`total_pembeli_pesanan_siap_dikirim`,
    p.Produk_Pesanan_Siap_Dikirim = aggregated_data.`produk_pesanan_siap_dikirim`,
    p.Penjualan_Pesanan_Siap_Dikirim_IDR = aggregated_data.`penjualan_pesanan_siap_dikirim_IDR`;
   
SELECT a.Nama_Produk, COUNT(*) AS occurrences
FROM performa_produk a
GROUP BY a.Nama_Produk
HAVING COUNT(*) > 1;

DELETE p1
FROM performa_produk p1
JOIN performa_produk p2
ON p1.Nama_Produk = p2.Nama_Produk
WHERE p1.row_id > p2.row_id;

ALTER TABLE performa_produk
DROP COLUMN `Kode Produk`,
DROP COLUMN `Produk`,
DROP COLUMN `Status Produk Saat Ini`,
DROP COLUMN `Pengunjung Produk (Kunjungan)`,
DROP COLUMN `Halaman Produk Dilihat`,
DROP COLUMN `Pengunjung Melihat Tanpa Membeli`,
DROP COLUMN `Tingkat Pengunjung Melihat Tanpa Membeli`,
DROP COLUMN `Klik Pencarian`,
DROP COLUMN `Suka`,
DROP COLUMN `Pengunjung Produk (Menambahkan Produk ke Keranjang)`,
DROP COLUMN `Dimasukkan ke Keranjang (Produk)`,
DROP COLUMN `Tingkat Konversi Produk Dimasukkan ke Keranjang`,
DROP COLUMN `Total Pembeli (Pesanan Dibuat)`,
DROP COLUMN `Produk (Pesanan Dibuat)`,
DROP COLUMN `Total Penjualan (Pesanan Dibuat) (IDR)`,
DROP COLUMN `Tingkat Konversi (Pesanan yang Dibuat)`,
DROP COLUMN `Total Pembeli (Pesanan Siap Dikirim)`,
DROP COLUMN `Produk (Pesanan Siap Dikirim)`,
DROP COLUMN `Penjualan (Pesanan Siap Dikirim) (IDR)`,
DROP COLUMN `Tingkat Konversi (Pesanan Siap Dikirim)`,
DROP COLUMN `Tingkat Konversi (Pesanan Siap Dikirim dibagi Pesanan Dibuat)`,
DROP COLUMN `% Pembelian Ulang (Pesanan Siap Dikirim)`;

-- DELETE FROM performa_produk
-- WHERE `Produk` LIKE '%Tidak dapat memperoleh informasi produk karena penghapusan%';

 SELECT * 
FROM performa_produk
ORDER BY `Produk` ASC;
   
SELECT * FROM performa_produk;

-- DESCRIBE performa_produk;
