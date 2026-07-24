<?php

header("Content-Type: application/json");

include "db.php";

$user_id = $_POST["user_id"] ?? "";

$traveler_id = $_POST["traveler_id"] ?? "";

$kategori = $_POST["kategori"] ?? "";

$notes = $_POST["notes"] ?? "";

$alamat = $_POST["alamat"] ?? "";

$nama_penerima =
    $_POST["nama_penerima"] ?? "";

$nomor_hp =
    $_POST["nomor_hp"] ?? "";

// VALIDASI
if (

    empty($user_id) ||
    empty($traveler_id) ||
    empty($kategori) ||
    empty($notes) ||
    empty($alamat) ||
    empty($nama_penerima) ||
    empty($nomor_hp)

) {

    echo json_encode([

        "status" => "error",

        "message" =>
            "Semua field wajib diisi"
    ]);

    exit;
}

// AMBIL NOMINAL DP DARI DATABASE
$stmt = $conn->prepare("
SELECT nominal_dp
FROM kategori_dp
WHERE kategori = ?
LIMIT 1
");

$stmt->bind_param("s", $kategori);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows == 0) {

    echo json_encode([
        "status" => "error",
        "message" => "Kategori tidak ditemukan"
    ]);
    exit;
}

$row = $result->fetch_assoc();

$nominal_dp = $row["nominal_dp"];

$status = "Menunggu Konfirmasi Admin";

// INSERT
$sql = "INSERT INTO orders (

            user_id,
            traveler_id,
            kategori,
            notes,
            alamat,
            nama_penerima,
            nomor_hp,
            nominal_dp,
            status

        )

        VALUES (

            '$user_id',
            '$traveler_id',
            '$kategori',
            '$notes',
            '$alamat',
            '$nama_penerima',
            '$nomor_hp',
            '$nominal_dp',
            '$status'
        )";

if ($conn->query($sql)) {

    $order_id = $conn->insert_id;

    $log = "INSERT INTO order_status_log (

                order_id,
                status,
                keterangan

            )

            VALUES (

                '$order_id',
                '$status',
                'Pesanan berhasil dibuat'
            )";

    $conn->query($log);

    echo json_encode([

        "status" => "success",

        "message" =>
            "Pesanan berhasil dibuat",

        "nominal_dp" =>
            $nominal_dp,

        "order_id" =>
            $order_id
    ]);

} else {

    echo json_encode([

        "status" => "error",

        "message" =>
            $conn->error
    ]);
}
?>