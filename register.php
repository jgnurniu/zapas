<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$name = trim($data['name'] ?? '');
$email = trim(strtolower($data['email'] ?? ''));
$password = $data['password'] ?? '';
if ($name === '' || $email === '' || strlen($password) < 6) {
    json_response(['message' => 'Nombre, email y password de al menos 6 caracteres son requeridos'], 422);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    json_response(['message' => 'Email inválido'], 422);
}
$stmt = $pdo->prepare('SELECT id FROM users WHERE email = ? LIMIT 1');
$stmt->execute([$email]);
if ($stmt->fetch()) {
    json_response(['message' => 'El email ya está registrado'], 409);
}
$hash = password_hash($password, PASSWORD_DEFAULT);
$stmt = $pdo->prepare('INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)');
$stmt->execute([$name, $email, $hash]);
json_response(['message' => 'Cuenta creada correctamente']);
?>
