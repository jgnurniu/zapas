<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$id = (int)($data['id'] ?? ($_GET['id'] ?? 0));
if ($id <= 0) {
    json_response(['message' => 'ID requerido'], 422);
}
$stmt = $pdo->prepare('DELETE FROM products WHERE id = ?');
$stmt->execute([$id]);
json_response(['message' => 'Producto eliminado correctamente']);
?>
