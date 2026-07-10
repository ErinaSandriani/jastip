<?php

header("Content-Type: application/json");

include "db.php";

$id = $_POST["id"] ?? "";

if (empty($id)) {

    echo json_encode([

        "status" => "error",

        "message" => "ID tidak ditemukan"
    ]);

    exit;
}

$sql = "DELETE FROM users

        WHERE id='$id'

        AND role='traveler'";

if ($conn->query($sql)) {

    echo json_encode([

        "status" => "success",

        "message" => "Traveler berhasil dihapus"
    ]);

} else {

    echo json_encode([

        "status" => "error",

        "message" => $conn->error
    ]);
}
?>