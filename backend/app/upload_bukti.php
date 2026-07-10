<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");

include "db.php";

// DEBUG
file_put_contents(
    "upload_debug.txt",
    date("Y-m-d H:i:s") . "\n" .
    "POST: " . print_r($_POST, true) . "\n" .
    "FILES: " . print_r($_FILES, true) . "\n\n",
    FILE_APPEND
);

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

if ($image["error"] !== UPLOAD_ERR_OK) {

    echo json_encode([
        "status" => "error",
        "message" => "Upload error code: " . $image["error"]
    ]);

    exit;
}

$targetDir = "uploads/";

if (!file_exists($targetDir)) {

    if (!mkdir($targetDir, 0777, true)) {

        echo json_encode([
            "status" => "error",
            "message" => "Gagal membuat folder uploads"
        ]);

        exit;
    }
}

$fileName =
    time() . "_" .
    preg_replace(
        "/[^a-zA-Z0-9._-]/",
        "_",
        basename($image["name"])
    );

$targetPath =
    $targetDir . $fileName;

if (!move_uploaded_file(
    $image["tmp_name"],
    $targetPath
)) {

    echo json_encode([
        "status" => "error",
        "message" => "move_uploaded_file gagal"
    ]);

    exit;
}

$stmt = $conn->prepare(
    "UPDATE orders
     SET dp_bukti = ?,
         status = ?
     WHERE id = ?"
);

$status = "Menunggu Konfirmasi Admin";

$stmt->bind_param(
    "ssi",
    $targetPath,
    $status,
    $order_id
);

if (!$stmt->execute()) {

    echo json_encode([
        "status" => "error",
        "message" => "SQL Error: " . $stmt->error
    ]);

    exit;
}

$logStmt = $conn->prepare(
    "INSERT INTO order_status_log (
        order_id,
        status,
        keterangan
    )
    VALUES (?, ?, ?)"
);

$keterangan =
    "Customer upload bukti DP";

$logStmt->bind_param(
    "iss",
    $order_id,
    $status,
    $keterangan
);

$logStmt->execute();

echo json_encode([
    "status" => "success",
    "message" => "Upload berhasil",
    "image" => $targetPath,
    "order_id" => $order_id
]);