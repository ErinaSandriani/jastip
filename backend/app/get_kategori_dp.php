<?php

header("Content-Type: application/json");
include "db.php";

$data = [];

$result = $conn->query("
SELECT *
FROM kategori_dp
ORDER BY id ASC
");

while($row = $result->fetch_assoc()){
    $data[] = $row;
}

echo json_encode([
    "status"=>"success",
    "data"=>$data
]);