<?php

header("Content-Type: application/json");

include "db.php";

// ==============================
// TOTAL PESANAN
// ==============================

$orderQuery = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS total_orders FROM orders"
);

$totalOrders =
    mysqli_fetch_assoc($orderQuery)["total_orders"];

// ==============================
// TOTAL CUSTOMER
// ==============================

$customerQuery = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS total_customer
     FROM users
     WHERE role='customer'"
);

$totalCustomer =
    mysqli_fetch_assoc($customerQuery)["total_customer"];

// ==============================
// TOTAL TRAVELER
// ==============================

$travelerQuery = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS total_traveler
     FROM users
     WHERE role='traveler'"
);

$totalTraveler =
    mysqli_fetch_assoc($travelerQuery)["total_traveler"];

// ==============================
// TOTAL TRANSAKSI
// ==============================

$transaksiQuery = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS total_transaksi
     FROM orders
     WHERE status='Selesai'"
);

$totalTransaksi =
    mysqli_fetch_assoc($transaksiQuery)["total_transaksi"];

// ==============================
// REMINDER PELUNASAN
// ==============================

$reminderQuery = mysqli_query(

    $conn,

    "SELECT
        o.id,
        u.nama AS customer,
        o.nama_barang,
        o.deadline_pelunasan,
        DATEDIFF(
            o.deadline_pelunasan,
            CURDATE()
        ) AS sisa_hari

     FROM orders o

     JOIN users u
        ON o.user_id = u.id

     WHERE
        o.status = 'Menunggu Pelunasan'
        AND DATEDIFF(
            o.deadline_pelunasan,
            CURDATE()
        ) <= 3

     ORDER BY
        o.deadline_pelunasan ASC"
);

$reminder = [];

while ($row = mysqli_fetch_assoc($reminderQuery)) {

    $reminder[] = [

        "id" => (int)$row["id"],

        "customer" =>
            $row["customer"],

        "nama_barang" =>
            $row["nama_barang"],

        "deadline_pelunasan" =>
            $row["deadline_pelunasan"],

        "sisa_hari" =>
            (int)$row["sisa_hari"]

    ];

}

$reminderCount =
    count($reminder);

// ==============================
// RESPONSE
// ==============================

echo json_encode([

    "status" => "success",

    "data" => [

        "total_orders" =>
            (int)$totalOrders,

        "total_customer" =>
            (int)$totalCustomer,

        "total_traveler" =>
            (int)$totalTraveler,

        "total_transaksi" =>
            (int)$totalTransaksi,

        "reminder_count" =>
            $reminderCount,

        "reminder" =>
            $reminder

    ]

]);

?>