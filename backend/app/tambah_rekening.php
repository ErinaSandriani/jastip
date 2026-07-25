<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include "db.php";

$metode = trim($_POST['metode_pembayaran']);
$nomor = trim($_POST['nomor_rekening']);
$atasNama = trim($_POST['atas_nama']);

$cek = mysqli_prepare(
    $conn,
    "SELECT id
     FROM rekening_pembayaran
     WHERE metode_pembayaran = ?
     AND is_active = 1"
);

mysqli_stmt_bind_param($cek, "s", $metode);
mysqli_stmt_execute($cek);
mysqli_stmt_store_result($cek);

if (mysqli_stmt_num_rows($cek) > 0) {

    echo json_encode([
        "status"=>"error",
        "message"=>"Metode pembayaran sudah tersedia."
    ]);
    exit;
}

$stmt = mysqli_prepare(
    $conn,
    "INSERT INTO rekening_pembayaran
    (metode_pembayaran,nomor_rekening,atas_nama)
    VALUES(?,?,?)"
);

mysqli_stmt_bind_param(
    $stmt,
    "sss",
    $metode,
    $nomor,
    $atasNama
);

if(mysqli_stmt_execute($stmt)){

    echo json_encode([
        "status"=>"success",
        "message"=>"Berhasil menambahkan rekening."
    ]);

}else{

    echo json_encode([
        "status"=>"error",
        "message"=>"Gagal menambahkan rekening."
    ]);

}