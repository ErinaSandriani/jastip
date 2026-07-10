<?php
header("Content-Type: application/json");
include "db.php";

// Ambil user_id dari GET
$user_id = $_GET['user_id'] ?? null;

// Validasi
if (!$user_id) {
    echo json_encode([
        "status" => "error",
        "message" => "User ID wajib diisi"
    ]);
    exit;
}

// Ambil notif berdasarkan user
$sql = "SELECT * FROM notifications 
        WHERE user_id='$user_id' 
        ORDER BY id DESC";

$result = $conn->query($sql);

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "status" => "success",
    "data" => $data
]);
?>