<?php

header("Content-Type: application/json");

include "db.php";

$order_id = $_POST['order_id'] ?? null;
$status   = $_POST['status'] ?? null;

if (!$order_id || !$status) {
    echo json_encode([
        "status" => "error",
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

// Daftar status yang diperbolehkan
$allowedStatus = [
    "Menunggu Konfirmasi Admin",
    "Diproses",
    "On Hold",
    "Tidak Ditemukan",
    "Dalam Pengiriman",
    "Menunggu Pelunasan",
    "Dikirim ke Rumah Customer",
    "Selesai",
    "Dibatalkan"
];

if (!in_array($status, $allowedStatus)) {
    echo json_encode([
        "status" => "error",
        "message" => "Status tidak valid"
    ]);
    exit;
}

$sql = "
UPDATE orders
SET status='$status'
WHERE id='$order_id'
";

if ($conn->query($sql)) {
    echo json_encode([
        "status" => "success"
    ]);
} else {
    echo json_encode([
        "status" => "error"
    ]);
}
?>