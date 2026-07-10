<?php

header("Content-Type: application/json");
error_reporting(E_ALL);
ini_set("display_errors", 1);

include "db.php";

$order_id = $_POST["order_id"] ?? "";

if (empty($order_id)) {
    echo json_encode([
        "status" => "error",
        "message" => "Order ID kosong"
    ]);
    exit;
}

if (!isset($_FILES["image"])) {
    echo json_encode([
        "status" => "error",
        "message" => "File gambar tidak ditemukan"
    ]);
    exit;
}

$image = $_FILES["image"];

// DEBUG
if ($image["error"] != UPLOAD_ERR_OK) {
    echo json_encode([
        "status" => "error",
        "message" => "Upload Error Code: " . $image["error"]
    ]);
    exit;
}

$fileName = time() . "_" . basename($image["name"]);

$targetDir = __DIR__ . "/uploads/";
$dbPath = "uploads/" . $fileName;

if (!is_dir($targetDir)) {
    echo json_encode([
        "status" => "error",
        "message" => "Folder uploads tidak ditemukan"
    ]);
    exit;
}

$targetPath = $targetDir . $fileName;

if (!move_uploaded_file($image["tmp_name"], $targetPath)) {

    echo json_encode([
        "status" => "error",
        "message" => "move_uploaded_file gagal",
        "tmp_name" => $image["tmp_name"],
        "target" => $targetPath,
        "is_uploaded_file" => is_uploaded_file($image["tmp_name"])
    ]);

    exit;
}

$status = "Menunggu Konfirmasi Admin";

$stmt = $conn->prepare(
    "UPDATE orders
     SET dp_bukti = ?, status = ?
     WHERE id = ?"
);

$stmt->bind_param(
    "ssi",
    $dbPath,
    $status,
    $order_id
);

if (!$stmt->execute()) {
    echo json_encode([
        "status" => "error",
        "message" => $stmt->error
    ]);
    exit;
}

$conn->query("
INSERT INTO order_status_log(
order_id,
status,
keterangan
)
VALUES(
'$order_id',
'$status',
'Customer upload bukti DP'
)");

echo json_encode([
    "status" => "success",
    "image" => $dbPath
]);