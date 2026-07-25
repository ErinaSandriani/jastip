<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$id = $_POST['id'];

$stmt = mysqli_prepare(
    $conn,
    "UPDATE rekening_pembayaran
    SET is_active=0
    WHERE id=?"
);

mysqli_stmt_bind_param(
    $stmt,
    "i",
    $id
);

if(mysqli_stmt_execute($stmt)){

    echo json_encode([
        "status"=>"success",
        "message"=>"Metode pembayaran berhasil dihapus."
    ]);

}else{

    echo json_encode([
        "status"=>"error",
        "message"=>"Gagal menghapus metode pembayaran."
    ]);

}