<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$sql = "SELECT

id,

nama,

email,

no_hp,

alamat,

tanggal_pulang,

status_verifikasi

FROM users

WHERE role='traveler'";

$result = $conn->query($sql);

$data = [];

if ($result && $result->num_rows > 0) {

    while ($row = $result->fetch_assoc()) {

        $data[] = $row;
    }

    echo json_encode([
        "status" => "success",
        "data" => $data
    ]);

} else {

    echo json_encode([
        "status" => "success",
        "data" => []
    ]);
}