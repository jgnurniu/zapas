<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$name = trim($data['name'] ?? '');
$model = trim($data['model'] ?? '');
$price = (float)($data['price'] ?? 0);
$stock = (int)($data['stock'] ?? 0);
if ($name === '' || $model === '' || $price <= 0) {
    json_response(['message' => 'Nombre, modelo y precio son requeridos'], 422);
}
$stmt = $pdo->prepare('INSERT INTO products (name, model, price, badge, badge_class, stock, description, material, shipping, returns_policy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
$stmt->execute([
    $name,
    $model,
    $price,
    trim($data['badge'] ?? 'New'),
    trim($data['badge_class'] ?? 'badge-new'),
    $stock,
    trim($data['description'] ?? ''),
    trim($data['material'] ?? ''),
    trim($data['shipping'] ?? ''),
    trim($data['returns'] ?? '')
]);
json_response(['message' => 'Producto creado correctamente', 'id' => $pdo->lastInsertId()], 201);
?>
