<?php

header("Content-Type: application/json");

include "db.php";

$order_id = $_POST["order_id"] ?? "";

$traveler_id = $_POST["traveler_id"] ?? "";

if (

    empty($order_id) ||
    empty($traveler_id)

) {

    echo json_encode([

        "status" => "error",

        "message" => "Data tidak lengkap"
    ]);

    exit;
}

$sql = "UPDATE orders

        SET traveler_id='$traveler_id'

        WHERE id='$order_id'";

if ($conn->query($sql) === TRUE) {

    echo json_encode([

        "status" => "success",

        "message" => "Traveler berhasil dipilih"
    ]);

} else {

    echo json_encode([

        "status" => "error",

        "message" => $conn->error
    ]);
}
?>