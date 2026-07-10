<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");

include "db.php";

$traveler_id = $_POST['traveler_id'] ?? "";

if (empty($traveler_id)) {

    echo json_encode([
        "status"=>"error",
        "message"=>"Traveler tidak ditemukan"
    ]);

    exit;
}

$sql="

UPDATE users

SET tanggal_pulang=NULL

WHERE id=?

";

$stmt=$conn->prepare($sql);

$stmt->bind_param(

"i",

$traveler_id

);

if($stmt->execute()){

echo json_encode([

"status"=>"success"

]);

}else{

echo json_encode([

"status"=>"error",

"message"=>$conn->error

]);

}

$stmt->close();

$conn->close();

?>