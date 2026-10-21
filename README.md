# Lohas
spring mvc project by Lohas

> **狀態：已封存（Archived，唯讀）。** 2018 年獨立開發的後台系統，2026 年現代化遷移至 Spring Boot 4 / Java 25 / PostgreSQL，作為作品與技術參考保存，不再維護。因含早期設計（如明文密碼比對），請勿直接用於正式環境。

## history
- 榮總 RFID card track client platform on 2018.

## technology
- UI/UX: kendo JS
- JAVA base:
	- Spring MVC
	- JPA Model
	- Hibernate
- DataBase: PostgreSQL（2026/10 由 MySQL 遷移）

## 資料庫（PostgreSQL）

原本使用 MySQL，已於 2026/10 遷移至 PostgreSQL。原始 MySQL 的 schema 與資料均已遺失，
現有的 `src/main/resources/sql/schema.sql` 是由 JPA Entity 以 Hibernate 反推產生（欄位採小寫），
`data.sql` 為最小可登入種子資料。

> 注意：`event_view`、`history_view`、`resident_view` 原本是 MySQL 的資料庫 View，
> 其定義（跨多表 JOIN 與計算欄位）已遺失，目前暫以空的資料表重建，待日後補回。

### 建立資料庫與帳號

以超級使用者連線後執行：

```sql
CREATE ROLE lohas LOGIN PASSWORD 'lohas';
CREATE DATABASE lohas OWNER lohas ENCODING 'UTF8';
```

### 建表與種子資料

```powershell
$pg='D:\Development\tools\pgsql\bin'
$env:PGPASSWORD='lohas'
& "$pg\psql.exe" -U lohas -h localhost -d lohas -f src\main\resources\sql\schema.sql
& "$pg\psql.exe" -U lohas -h localhost -d lohas -f src\main\resources\sql\data.sql
```

連線資訊預設寫在 `application.properties`，可用環境變數 `DB_URL` / `DB_USER` / `DB_PASSWORD` 覆寫。

### 預設登入帳號（種子資料）

| 項目 | 值 |
| --- | --- |
| 帳號（Email） | `admin@lohas.local` |
| 密碼 | `admin123` |

> 密碼為明文比對（原程式前後端皆未雜湊）。