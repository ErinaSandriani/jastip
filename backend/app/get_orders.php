<?php

header("Content-Type: application/json");

include "db.php";

$user_id = $_GET['user_id'] ?? null;
$traveler_id = $_GET['traveler_id'] ?? null;

$sql = "
SELECT
    orders.*,

    customer.nama AS customer_nama,

    traveler.nama AS nama_traveler,
    traveler.tanggal_pulang AS tanggal_kepulangan

FROM orders

LEFT JOIN users AS customer
ON customer.id = orders.user_id

LEFT JOIN users AS traveler
ON traveler.id = orders.traveler_id
";

$conditions = [];

// ======================
// FILTER CUSTOMER
// ======================
if (!empty($user_id)) {
    $conditions[] = "orders.user_id = '$user_id'";
}

// ======================
// FILTER TRAVELER
// ======================
if (!empty($traveler_id)) {
    $conditions[] = "
        orders.traveler_id = '$traveler_id'
        AND orders.status IN (
            'Diproses',
            'On Hold',
            'Tidak Ditemukan',
            'Dalam Pengiriman'
        )
    ";
}

// ======================
// GABUNGKAN FILTER
// ======================
if (!empty($conditions)) {
    $sql .= " WHERE " . implode(" AND ", $conditions);
}

$sql .= " ORDER BY orders.id DESC";

$result = $conn->query($sql);

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "status" => "success",
    "data" => $data
]);