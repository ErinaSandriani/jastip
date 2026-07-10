<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");

include "db.php";

$traveler_id = $_POST['traveler_id'] ?? "";
$tanggal_pulang = $_POST['tanggal_pulang'] ?? "";

if (
    empty($traveler_id) ||
    empty($tanggal_pulang)
) {

    echo json_encode([
        "status" => "error",
        "message" => "Data tidak lengkap"
    ]);

    exit;
}

$sql = "
UPDATE users
SET tanggal_pulang=?
WHERE id=?
";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "si",
    $tanggal_pulang,
    $traveler_id
);

if ($stmt->execute()) {

    echo json_encode([
        "status"=>"success"
    ]);

} else {

    echo json_encode([
        "status"=>"error",
        "message"=>$conn->error
    ]);
}

$stmt->close();
$conn->close();

?>