<?php
require_once __DIR__ . '/../config/db.php';
$stmt = $pdo->query('SELECT id, name, model, price, badge, badge_class, stock, description, material, shipping, returns_policy AS returns FROM products ORDER BY id ASC');
$products = $stmt->fetchAll();
foreach ($products as &$product) {
    $product['price'] = '$' . number_format((float)$product['price'], 0);
}
json_response(['products' => $products]);
?>
