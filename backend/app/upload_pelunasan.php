<?php

header("Content-Type: application/json");

include "db.php";

// ======================
// VALIDASI INPUT
// ======================

$order_id = $_POST['order_id'] ?? null;

if (!$order_id || !isset($_FILES['image'])) {
    echo json_encode([
        "status" => "error",
        "message" => "Order ID dan bukti pelunasan wajib diisi."
    ]);
    exit;
}

// ======================
// CEK ORDER
// ======================

$getOrder = $conn->query("
SELECT
    user_id,
    status
FROM orders
WHERE id='$order_id'
");

if (!$getOrder || $getOrder->num_rows == 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Order tidak ditemukan."
    ]);
    exit;
}

$order = $getOrder->fetch_assoc();

// ======================
// VALIDASI STATUS
// ======================

if ($order['status'] != "Menunggu Pelunasan") {
    echo json_encode([
        "status" => "error",
        "message" => "Pesanan belum dapat melakukan pelunasan."
    ]);
    exit;
}

// ======================
// UPLOAD FILE
// ======================

$uploadDir = "uploads/";

if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

$fileName = time() . "_" . basename($_FILES["image"]["name"]);
$target = $uploadDir . $fileName;

if (!move_uploaded_file($_FILES["image"]["tmp_name"], $target)) {

    echo json_encode([
        "status" => "error",
        "message" => "Upload gambar gagal."
    ]);
    exit;
}

// ======================
// UPDATE ORDER
// ======================

$update = $conn->query("
UPDATE orders
SET
    pelunasan_bukti = '$target',
    status = 'Menunggu Verifikasi Pelunasan'
WHERE id = '$order_id'
");

if (!$update) {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal mengupdate data."
    ]);
    exit;
}

// ======================
// SIMPAN HISTORY STATUS
// ======================

$conn->query("
INSERT INTO order_status_log
(
    order_id,
    status,
    keterangan
)
VALUES
(
    '$order_id',
    'Menunggu Verifikasi Pelunasan',
    'Customer telah mengunggah bukti pelunasan.'
)
");

// ======================
// NOTIFIKASI ADMIN
// ======================

$getAdmin = $conn->query("
SELECT id
FROM users
WHERE role='admin'
LIMIT 1
");

if ($getAdmin && $getAdmin->num_rows > 0) {

    $admin = $getAdmin->fetch_assoc();

    $conn->query("
    INSERT INTO notifications
    (
        user_id,
        pesan
    )
    VALUES
    (
        '{$admin['id']}',
        'Customer telah mengunggah bukti pelunasan.'
    )
    ");
}

// ======================
// RESPONSE
// ======================

echo json_encode([
    "status" => "success",
    "message" => "Bukti pelunasan berhasil diunggah.",
    "image" => $target
]);

$conn->close();

?>