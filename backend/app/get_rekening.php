<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$sql = "SELECT
            id,
            metode_pembayaran,
            nomor_rekening,
            atas_nama
        FROM rekening_pembayaran
        WHERE is_active = 1
        ORDER BY id ASC";

$result = mysqli_query($conn, $sql);

$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode([
    "status" => "success",
    "data" => $data
]);