<?php

header("Content-Type: application/json");

include "db.php";

// TOTAL PESANAN
$orderQuery = mysqli_query(

    $conn,

    "SELECT COUNT(*) as total_orders FROM orders"
);

$totalOrders =
    mysqli_fetch_assoc($orderQuery)["total_orders"];

// TOTAL CUSTOMER
$customerQuery = mysqli_query(

    $conn,

    "SELECT COUNT(*) as total_customer

     FROM users

     WHERE role='customer'"
);

$totalCustomer =
    mysqli_fetch_assoc($customerQuery)["total_customer"];

// TOTAL TRAVELER
$travelerQuery = mysqli_query(

    $conn,

    "SELECT COUNT(*) as total_traveler

     FROM users

     WHERE role='traveler'"
);

$totalTraveler =
    mysqli_fetch_assoc($travelerQuery)["total_traveler"];

// TOTAL TRANSAKSI
$transaksiQuery = mysqli_query(

    $conn,

    "SELECT COUNT(*) as total_transaksi

     FROM orders

     WHERE status='Selesai'"
);

$totalTransaksi =
    mysqli_fetch_assoc($transaksiQuery)["total_transaksi"];

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
            (int)$totalTransaksi
    ]
]);
?>