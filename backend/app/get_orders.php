<?php

header("Content-Type: application/json");

include "db.php";

$traveler_id =
    $_GET['traveler_id']
    ?? null;

$sql = "

SELECT
    orders.*,
    users.nama AS customer_nama

FROM orders

LEFT JOIN users
ON users.id = orders.user_id
";

// 🔥 FILTER TRAVELER
if($traveler_id){

    $sql .= "
    WHERE orders.traveler_id='$traveler_id'
    ";
}

$sql .= "
ORDER BY orders.id DESC
";

$result =
    $conn->query($sql);

$data = [];

while(
    $row =
        $result->fetch_assoc()
){

    $data[] = $row;
}

echo json_encode([

    "status" => "success",

    "data" => $data
]);
?>