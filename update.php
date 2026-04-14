<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$id = (int)($data['id'] ?? 0);
if ($id <= 0) {
    json_response(['message' => 'ID requerido'], 422);
}
$stmt = $pdo->prepare('UPDATE products SET name = ?, model = ?, price = ?, badge = ?, badge_class = ?, stock = ?, description = ?, material = ?, shipping = ?, returns_policy = ? WHERE id = ?');
$stmt->execute([
    trim($data['name'] ?? ''),
    trim($data['model'] ?? ''),
    (float)($data['price'] ?? 0),
    trim($data['badge'] ?? ''),
    trim($data['badge_class'] ?? ''),
    (int)($data['stock'] ?? 0),
    trim($data['description'] ?? ''),
    trim($data['material'] ?? ''),
    trim($data['shipping'] ?? ''),
    trim($data['returns'] ?? ''),
    $id
]);
json_response(['message' => 'Producto actualizado correctamente']);
?>
