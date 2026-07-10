<?php
header("Content-Type: application/json");
include "db.php";

// Ambil JSON
$data = json_decode(file_get_contents("php://input"), true);

$order_id = $data['order_id'] ?? null;
$pelunasan_bukti = $data['pelunasan_bukti'] ?? null;

// Validasi
if (!$order_id || !$pelunasan_bukti) {
    echo json_encode([
        "status" => "error",
        "message" => "Order ID dan bukti pelunasan wajib diisi"
    ]);
    exit;
}

// Ambil status sekarang
$getOrder = $conn->query("SELECT status FROM orders WHERE id='$order_id'");

if ($getOrder->num_rows == 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Order tidak ditemukan"
    ]);
    exit;
}

$order = $getOrder->fetch_assoc();

// ❌ hanya boleh upload jika sudah sampai Indonesia
if ($order['status'] != 'sampai_indonesia') {
    echo json_encode([
        "status" => "error",
        "message" => "Pelunasan hanya bisa dilakukan setelah barang sampai Indonesia"
    ]);
    exit;
}

// Update DB
$update = $conn->query("UPDATE orders 
                        SET pelunasan_bukti='$pelunasan_bukti',
                            status='menunggu_konfirmasi_pelunasan'
                        WHERE id='$order_id'");

if ($update) {

    // Simpan log
    $conn->query("INSERT INTO order_status_log (order_id, status, keterangan)
                  VALUES (
                    '$order_id',
                    'menunggu_konfirmasi_pelunasan',
                    'Customer upload bukti pelunasan'
                  )");

    echo json_encode([
        "status" => "success",
        "message" => "Bukti pelunasan berhasil diupload"
    ]);

} else {

    echo json_encode([
        "status" => "error",
        "message" => "Gagal upload pelunasan"
    ]);
}
?>