CREATE DATABASE IF NOT EXISTS leonardise CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE leonardise;

CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  model VARCHAR(160) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  badge VARCHAR(40) DEFAULT NULL,
  badge_class VARCHAR(60) DEFAULT NULL,
  stock INT UNSIGNED NOT NULL DEFAULT 0,
  description TEXT NOT NULL,
  material TEXT NOT NULL,
  shipping TEXT NOT NULL,
  returns_policy TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_sizes (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id INT UNSIGNED NOT NULL,
  size_label VARCHAR(10) NOT NULL,
  available TINYINT(1) NOT NULL DEFAULT 1,
  UNIQUE KEY unique_product_size (product_id, size_label),
  CONSTRAINT fk_product_sizes_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS contact_messages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO products (id, name, model, price, badge, badge_class, stock, description, material, shipping, returns_policy) VALUES
(1, 'Nike Airmax 270', 'Black Motion', 199.00, 'New', 'badge-new', 3, 'Una silueta urbana con cámara Air visible, upper respirable y una transición visual inspirada en configuradores de lujo.', 'Mesh técnico, overlays sintéticos premium, unidad Air 270 y suela de goma de alto agarre.', 'Envío express en 24–48 horas con packaging premium Leonardise.', 'Devoluciones gratuitas durante 30 días si el producto está sin uso.'),
(2, 'Nike Airmax 270', 'Crimson Shift', 219.00, 'Hot', 'badge-hot', 5, 'Colorway rojo profundo con reflejos iridiscentes y presencia escultural para una pisada dominante.', 'Upper técnico con acabado reflectivo, talonera reforzada, air unit rojo y plantilla acolchada.', 'Envío asegurado con tracking y entrega prioritaria en ciudades principales.', 'Cambios por talle sin costo dentro de los primeros 15 días.'),
(3, 'Nike Airmax 270', 'Noir Pulse', 189.00, '-20%', 'badge-sale', 2, 'Una versión oscura y precisa, pensada para looks monocromáticos con detalles de alto contraste.', 'Textil respirable, detalles termo-sellados, suela flexible y amortiguación de gran recorrido.', 'Despacho el mismo día en compras antes de las 14:00.', 'Reembolso completo disponible bajo condiciones estándar de compra.'),
(4, 'Nike Airmax 270', 'Red Voltage', 229.00, 'Limited', 'badge-limited', 7, 'Diseño de alto impacto con gradiente rojo-negro, ideal para quienes quieren que el producto sea el centro del outfit.', 'Mesh elástico, refuerzos sintéticos, loop de talón y cámara Air con acabado rojo translúcido.', 'Envío premium incluido en compras superiores a $200.', 'Cambios rápidos por crédito de tienda o talle disponible.'),
(5, 'Nike Airmax 270', 'Shadow Core', 205.00, 'New', 'badge-new', 4, 'Perfil minimalista con sombras profundas y líneas limpias para una experiencia de producto sofisticada.', 'Capas técnicas ligeras, cuello acolchado, suela exterior de goma y cámara visible de gran volumen.', 'Entrega estimada en 2–4 días hábiles.', 'Devoluciones simples desde tu panel de compra.'),
(6, 'Nike Airmax 270', 'Infrared Halo', 235.00, 'Hot', 'badge-hot', 3, 'Una variante energética con brillo cálido, pensada para capturar atención desde cualquier ángulo.', 'Textil premium, detalles reflectivos, lengüeta suave y amortiguación Air de respuesta prolongada.', 'Envío express disponible con confirmación inmediata.', 'Puedes devolver o cambiar el producto sin fricción durante 30 días.')
ON DUPLICATE KEY UPDATE name = VALUES(name), model = VALUES(model), price = VALUES(price), badge = VALUES(badge), badge_class = VALUES(badge_class), stock = VALUES(stock), description = VALUES(description), material = VALUES(material), shipping = VALUES(shipping), returns_policy = VALUES(returns_policy);

INSERT INTO product_sizes (product_id, size_label, available) VALUES
(1,'38',1),(1,'39',1),(1,'40',1),(1,'41',0),(1,'42',1),(1,'43',1),
(2,'38',1),(2,'39',0),(2,'40',1),(2,'41',1),(2,'42',1),(2,'43',0),
(3,'38',0),(3,'39',1),(3,'40',1),(3,'41',1),(3,'42',0),(3,'43',1),
(4,'38',1),(4,'39',1),(4,'40',0),(4,'41',1),(4,'42',1),(4,'43',1),
(5,'38',1),(5,'39',1),(5,'40',1),(5,'41',0),(5,'42',1),(5,'43',0),
(6,'38',1),(6,'39',0),(6,'40',1),(6,'41',1),(6,'42',1),(6,'43',1)
ON DUPLICATE KEY UPDATE available = VALUES(available);

INSERT INTO users (name, email, password_hash) VALUES
('Demo User', 'demo@leonardise.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC2P4JpJW4B2m69eL2Ce')
ON DUPLICATE KEY UPDATE name = VALUES(name);
