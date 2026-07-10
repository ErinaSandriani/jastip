<?php
header("Content-Type: application/json");
include "db.php";

$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? null;

if (!$id) {
    echo json_encode([
        "status" => "error",
        "message" => "ID wajib diisi"
    ]);
    exit;
}

$update = $conn->query("UPDATE notifications SET is_read=1 WHERE id='$id'");

if ($update) {
    echo json_encode([
        "status" => "success",
        "message" => "Notif sudah dibaca"
    ]);
} else {
    echo json_encode([
        "status" => "error"
    ]);
}
?>