<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$order_id = $_POST['order_id'] ?? '';
$harga_barang = $_POST['harga_barang'] ?? 0;
$fee_jastip = $_POST['fee_jastip'] ?? 0;
$ongkir = $_POST['ongkir_indonesia'] ?? 0;
$total = $_POST['total_bayar'] ?? 0;
$deadline = $_POST['deadline_pelunasan'] ?? '';

if ($order_id == "" || $deadline == "") {
    echo json_encode([
        "status" => "error",
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

$status = "Menunggu Pelunasan";

/* ==========================
   UPDATE ORDERS
========================== */

$stmt = $conn->prepare("
UPDATE orders
SET
harga_barang=?,
fee_jastip=?,
ongkir_indonesia=?,
total_bayar=?,
deadline_pelunasan=?,
status=?
WHERE id=?
");

$stmt->bind_param(
    "iiiissi",
    $harga_barang,
    $fee_jastip,
    $ongkir,
    $total,
    $deadline,
    $status,
    $order_id
);

if(!$stmt->execute()){

    echo json_encode([
        "status"=>"error",
        "message"=>$stmt->error
    ]);

    exit;
}

/* ==========================
   AMBIL USER CUSTOMER
========================== */

$getUser = $conn->prepare("
SELECT user_id
FROM orders
WHERE id=?
");

$getUser->bind_param("i",$order_id);
$getUser->execute();

$result = $getUser->get_result();

$data = $result->fetch_assoc();

$userId = $data['user_id'];

/* ==========================
   LOG STATUS
========================== */

$log = $conn->prepare("
INSERT INTO order_status_log
(order_id,status,keterangan)
VALUES(?,?,?)
");

$ket = "Admin telah mengonfirmasi barang tiba dan menunggu pelunasan.";

$log->bind_param(
    "iss",
    $order_id,
    $status,
    $ket
);

$log->execute();

/* ==========================
   NOTIFIKASI CUSTOMER
========================== */

$notif = $conn->prepare("
INSERT INTO notifications
(user_id,pesan)
VALUES(?,?)
");

$pesan = "Barang Anda telah tiba. Silakan lakukan pelunasan sebelum $deadline.";

$notif->bind_param(
    "is",
    $userId,
    $pesan
);

$notif->execute();

/* ==========================
   SUCCESS
========================== */

echo json_encode([
    "status"=>"success",
    "message"=>"Data berhasil disimpan."
]);