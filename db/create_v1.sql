-- ============================================================
-- Магазин обуви «Шаг» — база данных, версия 1 (DDL)
-- СУБД: MySQL 8.0+, движок InnoDB, кодировка utf8mb4
-- Таблицы: 10, нормализация до 3НФ, ссылочная целостность через FK
-- ============================================================

CREATE DATABASE IF NOT EXISTS shoe_shop
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE shoe_shop;

-- ---------- Справочники ----------

CREATE TABLE categories (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_categories_name (name)
) ENGINE=InnoDB;

CREATE TABLE manufacturers (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_manufacturers_name (name)
) ENGINE=InnoDB;

CREATE TABLE suppliers (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_suppliers_name (name)
) ENGINE=InnoDB;

CREATE TABLE roles (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_roles_name (name)
) ENGINE=InnoDB;

CREATE TABLE orderstatus (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_orderstatus_name (name)
) ENGINE=InnoDB;

-- ---------- Товары ----------

CREATE TABLE products (
  id              INT           NOT NULL AUTO_INCREMENT,
  article         VARCHAR(20)   NOT NULL,                 -- артикул
  name            VARCHAR(150)  NOT NULL,
  unit            VARCHAR(10)   NOT NULL DEFAULT 'шт.',   -- единица измерения
  price           DECIMAL(10,2) NOT NULL,
  supplier_id     INT           NOT NULL,
  manufacturer_id INT           NOT NULL,
  category_id     INT           NOT NULL,
  discount        TINYINT UNSIGNED NOT NULL DEFAULT 0,    -- скидка, %
  stock           INT           NOT NULL DEFAULT 0,       -- остаток на складе
  description     TEXT          NULL,
  photo           VARCHAR(255)  NULL,                     -- путь к фото
  PRIMARY KEY (id),
  UNIQUE KEY uq_products_article (article),
  KEY ix_products_name (name),
  KEY ix_products_category (category_id),
  KEY ix_products_manufacturer (manufacturer_id),
  KEY ix_products_supplier (supplier_id),
  CONSTRAINT fk_products_supplier     FOREIGN KEY (supplier_id)     REFERENCES suppliers (id),
  CONSTRAINT fk_products_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (id),
  CONSTRAINT fk_products_category     FOREIGN KEY (category_id)     REFERENCES categories (id),
  CONSTRAINT ck_products_price    CHECK (price >= 0),
  CONSTRAINT ck_products_discount CHECK (discount BETWEEN 0 AND 100),
  CONSTRAINT ck_products_stock    CHECK (stock >= 0)
) ENGINE=InnoDB;

-- ---------- Пользователи ----------

CREATE TABLE users (
  id            INT          NOT NULL AUTO_INCREMENT,
  role_id       INT          NOT NULL,
  full_name     VARCHAR(150) NOT NULL,
  login         VARCHAR(50)  NOT NULL,
  password_hash CHAR(64)     NOT NULL,                    -- SHA-256 (hex)
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_login (login),
  KEY ix_users_role (role_id),
  CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles (id)
) ENGINE=InnoDB;

-- ---------- Пункты выдачи ----------

CREATE TABLE pvz (
  id      INT          NOT NULL AUTO_INCREMENT,
  address VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_pvz_address (address)
) ENGINE=InnoDB;

-- ---------- Заказы ----------

CREATE TABLE orders (
  id            INT         NOT NULL AUTO_INCREMENT,
  order_date    DATE        NOT NULL,
  delivery_date DATE        NULL,
  pvz_id        INT         NOT NULL,
  user_id       INT         NOT NULL,                     -- клиент, оформивший заказ
  pickup_code   VARCHAR(10) NOT NULL,                     -- код получения
  status_id     INT         NOT NULL,
  PRIMARY KEY (id),
  KEY ix_orders_pvz (pvz_id),
  KEY ix_orders_user (user_id),
  KEY ix_orders_status (status_id),
  KEY ix_orders_date (order_date),
  CONSTRAINT fk_orders_pvz    FOREIGN KEY (pvz_id)    REFERENCES pvz (id),
  CONSTRAINT fk_orders_user   FOREIGN KEY (user_id)   REFERENCES users (id),
  CONSTRAINT fk_orders_status FOREIGN KEY (status_id) REFERENCES orderstatus (id),
  CONSTRAINT ck_orders_dates  CHECK (delivery_date IS NULL OR delivery_date >= order_date)
) ENGINE=InnoDB;

-- ---------- Состав заказа ----------

CREATE TABLE prodorders (
  id         INT NOT NULL AUTO_INCREMENT,
  order_id   INT NOT NULL,
  product_id INT NOT NULL,
  quantity   INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_prodorders_order_product (order_id, product_id),
  KEY ix_prodorders_product (product_id),
  CONSTRAINT fk_prodorders_order   FOREIGN KEY (order_id)   REFERENCES orders (id) ON DELETE CASCADE,
  CONSTRAINT fk_prodorders_product FOREIGN KEY (product_id) REFERENCES products (id),
  CONSTRAINT ck_prodorders_qty CHECK (quantity > 0)
) ENGINE=InnoDB;
