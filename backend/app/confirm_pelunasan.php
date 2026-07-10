<?php
header("Content-Type: application/json");
include "db.php";

// Ambil JSON
$data = json_decode(file_get_contents("php://input"), true);

$order_id = $data['order_id'] ?? null;

// Validasi
if (!$order_id) {
    echo json_encode([
        "status" => "error",
        "message" => "Order ID wajib diisi"
    ]);
    exit;
}

// Update status selesai
$update = $conn->query("UPDATE orders 
                        SET status='selesai'
                        WHERE id='$order_id'");

if ($update) {

    // Ambil user
    $getUser = $conn->query("SELECT user_id FROM orders WHERE id='$order_id'");
    $user = $getUser->fetch_assoc();
    $user_id = $user['user_id'];

    // Log
    $conn->query("INSERT INTO order_status_log (order_id, status, keterangan)
                  VALUES (
                    '$order_id',
                    'selesai',
                    'Pelunasan telah dikonfirmasi admin'
                  )");

    // Notif
    $conn->query("INSERT INTO notifications (user_id, pesan)
                  VALUES (
                    '$user_id',
                    'Pelunasan berhasil dikonfirmasi, pesanan selesai'
                  )");

    echo json_encode([
        "status" => "success",
        "message" => "Pelunasan berhasil dikonfirmasi"
    ]);

} else {

    echo json_encode([
        "status" => "error",
        "message" => "Gagal konfirmasi pelunasan"
    ]);
}
?>