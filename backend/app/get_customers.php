<?php

header("Content-Type: application/json");

include "db.php";

$sql = "SELECT 

            id,
            nama,
            email

        FROM users

        WHERE role='customer'

        ORDER BY id DESC";

$result = $conn->query($sql);

$data = [];

while ($row = $result->fetch_assoc()) {

    $data[] = [

        "id" => (int)$row["id"],

        "nama" => $row["nama"],

        "email" => $row["email"]
    ];
}

echo json_encode([

    "status" => "success",

    "data" => $data
]);
?>