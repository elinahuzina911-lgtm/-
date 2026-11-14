# База данных

## Файлы

- `create_v1.sql` — DDL: создание схемы, 10 таблиц, типы данных, первичные и внешние ключи (3НФ, ссылочная целостность).
- `import/` — 10 CSV-файлов с тестовыми данными (разделитель `;`, кодировка UTF-8).
- `seed_v1.sql` — те же данные в виде INSERT (альтернатива импорту CSV).
- `queries.sql` — примеры запросов: каталог, поиск, фильтры, сортировка, остатки, заказы.
- `магазин_обуви.mwb` — ER-модель MySQL Workbench (генерируется в Workbench, см. ниже).

## Порядок развёртывания

1. В MySQL Workbench: `Create Schema…` → имя `shoe_shop`.
2. Выполнить `create_v1.sql` (создаст таблицы).
3. Загрузить данные одним из способов:
   - импортировать CSV мастером `Table Data Import Wizard` в порядке: `categories` → `manufacturers` → `suppliers` → `roles` → `orderstatus` → `products` → `users` → `pvz` → `orders` → `prodorders` (сначала справочники, потом таблицы со ссылками);
   - или выполнить `seed_v1.sql`.
4. Проверить типы (`Alter Table…`) и количество строк (`SELECT COUNT(*)`).
5. Выполнить запросы из `queries.sql`.

Тестовые пользователи (пароли хранятся как SHA-256): `admin1`, `seller1`, `client1`; пароль совпадает с логином.

## ER-модель (.mwb)

Файл `магазин_обуви.mwb` создаётся в MySQL Workbench:

1. `Database → Reverse Engineer…` — построить модель из готовой схемы.
2. `Arrange → Autolayout` — выровнять таблицы.
3. `File → Export → Export as PNG…` → `docs/diagrams/erd.png`.
4. `File → Export → Export as Single Page PDF…` → `docs/erd.pdf`.
5. `File → Save Model As…` → `магазин_обуви.mwb`.

> PNG и PDF уже сформированы и лежат в `docs/diagrams/erd.png` и `docs/erd.pdf`; файл `.mwb` генерируется в Workbench на своём компьютере (бинарный формат Workbench).
