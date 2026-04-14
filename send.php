<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$name = trim($data['name'] ?? '');
$email = trim($data['email'] ?? '');
$message = trim($data['message'] ?? '');
if ($name === '' || $email === '' || $message === '') {
    json_response(['message' => 'Todos los campos son requeridos'], 422);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    json_response(['message' => 'Email inválido'], 422);
}
$stmt = $pdo->prepare('INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)');
$stmt->execute([$name, $email, $message]);
json_response(['message' => 'Mensaje enviado correctamente']);
?>
