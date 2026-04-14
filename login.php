<?php
require_once __DIR__ . '/../config/db.php';
$data = request_json();
$email = trim(strtolower($data['email'] ?? ''));
$password = $data['password'] ?? '';
if ($email === '' || $password === '') {
    json_response(['message' => 'Email y password son requeridos'], 422);
}
$stmt = $pdo->prepare('SELECT id, name, email, password_hash FROM users WHERE email = ? LIMIT 1');
$stmt->execute([$email]);
$user = $stmt->fetch();
if (!$user || !password_verify($password, $user['password_hash'])) {
    json_response(['message' => 'Credenciales incorrectas'], 401);
}
$_SESSION['user_id'] = $user['id'];
$_SESSION['user_name'] = $user['name'];
json_response(['message' => 'Login correcto', 'user' => ['id' => $user['id'], 'name' => $user['name'], 'email' => $user['email']]]);
?>
