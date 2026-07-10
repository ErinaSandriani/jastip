<?php
header("Content-Type: application/json");
include "db.php";

// Ambil data JSON
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

// Update status order
$update = $conn->query("UPDATE orders 
                        SET status='diproses' 
                        WHERE id='$order_id'");

if ($update) {

    // Ambil user_id & traveler_id
    $getData = $conn->query("SELECT user_id, traveler_id FROM orders WHERE id='$order_id'");
    $row = $getData->fetch_assoc();

    $user_id = $row['user_id'];
    $traveler_id = $row['traveler_id'];

    // Simpan log
    $conn->query("INSERT INTO order_status_log (order_id, status, keterangan)
                  VALUES ('$order_id', 'diproses', 'Admin mengkonfirmasi DP')");

    // Notif ke customer
    $conn->query("INSERT INTO notifications (user_id, pesan)
                  VALUES ('$user_id', 'Pembayaran DP telah dikonfirmasi, pesanan sedang diproses')");

    // Notif ke traveler
    $conn->query("INSERT INTO notifications (user_id, pesan)
                  VALUES ('$traveler_id', 'Ada pesanan baru yang perlu diproses')");

    echo json_encode([
        "status" => "success",
        "message" => "DP berhasil dikonfirmasi"
    ]);

} else {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal konfirmasi DP"
    ]);
}
?>