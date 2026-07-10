<?php

header("Content-Type: application/json");

include "db.php";

$user_id = $_GET["user_id"] ?? "";

$sql = "SELECT *

        FROM orders

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