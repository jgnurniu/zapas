<?php
require_once __DIR__ . '/../config/db.php';
$id = (int)($_GET['id'] ?? 0);
if ($id <= 0) {
    json_response(['message' => 'Producto inválido'], 422);
}
$stmt = $pdo->prepare('SELECT id, name, model, price, badge, badge_class, stock, description, material, shipping, returns_policy AS returns FROM products WHERE id = ? LIMIT 1');
$stmt->execute([$id]);
$product = $stmt->fetch();
if (!$product) {
    json_response(['message' => 'Producto no encontrado'], 404);
}
$product['price'] = '$' . number_format((float)$product['price'], 0);
$sizes = $pdo->prepare('SELECT size_label AS label, available FROM product_sizes WHERE product_id = ? ORDER BY CAST(size_label AS UNSIGNED) ASC');
$sizes->execute([$id]);
$product['sizes'] = array_map(function ($size) {
    return ['label' => $size['label'], 'available' => (bool)$size['available']];
}, $sizes->fetchAll());
json_response(['product' => $product]);
?>
