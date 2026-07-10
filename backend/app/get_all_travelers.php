<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET");

include "db.php";

$sql = "
SELECT
    id,
    nama,
    email,
    tanggal_pulang
FROM users
WHERE role = 'traveler'
AND status_verifikasi = 'approved'
AND tanggal_pulang IS NOT NULL
ORDER BY tanggal_pulang ASC
";

$result = $conn->query($sql);

$data = [];

if ($result) {

    while ($row = $result->fetch_assoc()) {

        $data[] = $row;
    }

    echo json_encode([
        "status" => "success",
        "data" => $data
    ]);

} else {

    echo json_encode([
        "status" => "error",
        "message" => $conn->error
    ]);
}

$conn->close();

?>