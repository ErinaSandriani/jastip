<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$id = $_POST["id"] ?? "";

if (empty($id)) {

    echo json_encode([
        "status" => "error",
        "message" => "ID traveler tidak ditemukan."
    ]);

    exit;
}

$stmt = $conn->prepare(

"UPDATE users

SET status_verifikasi='approved'

WHERE id=?"

);

$stmt->bind_param("i", $id);

if($stmt->execute()){

    echo json_encode([

        "status"=>"success",

        "message"=>"Traveler berhasil disetujui."
    ]);

}else{

    echo json_encode([

        "status"=>"error",

        "message"=>"Gagal approve traveler."
    ]);
}