<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$user_id = $_GET["user_id"] ?? "";

if (empty($user_id)) {

    echo json_encode([
        "status" => "error",
        "message" => "User ID wajib diisi."
    ]);

    exit;
}

$sql = "
SELECT *
FROM notifications
WHERE user_id=?
ORDER BY created_at DESC
";

$stmt = $conn->prepare($sql);

$stmt->bind_param("i", $user_id);

$stmt->execute();

$result = $stmt->get_result();

$data = [];

while ($row = $result->fetch_assoc()) {

    $data[] = $row;
}

echo json_encode([
    "status" => "success",
    "data" => $data
]);

$stmt->close();
$conn->close();