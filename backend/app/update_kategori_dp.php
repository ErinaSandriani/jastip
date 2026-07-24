<?php

header("Content-Type: application/json");
include "db.php";

$id = $_POST['id'] ?? '';
$nominal_dp = $_POST['nominal_dp'] ?? '';

if($id=='' || $nominal_dp==''){
    echo json_encode([
        "status"=>"error",
        "message"=>"Data tidak lengkap"
    ]);
    exit;
}

$stmt = $conn->prepare("
UPDATE kategori_dp
SET nominal_dp=?
WHERE id=?
");

$stmt->bind_param("ii",$nominal_dp,$id);

if($stmt->execute()){

    echo json_encode([
        "status"=>"success"
    ]);

}else{

    echo json_encode([
        "status"=>"error"
    ]);

}