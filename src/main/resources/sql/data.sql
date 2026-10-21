-- Lohas 最小可登入種子資料
-- 登入查詢：member JOIN status(mailStatus) WHERE usermail=? AND userpassword=? AND stutype='validated' AND usagetable='member'
-- 密碼為明文比對
INSERT INTO status (id, stucode, stutype, usagetable, studesc, usercreated)
VALUES (1, 0, 'validated', 'member', '已驗證會員', 'seed')
ON CONFLICT (id) DO NOTHING;

INSERT INTO member (id, usermail, username, userpassword, mailstatus, userstatus, zipcode, usercreated)
VALUES (1, 'admin@lohas.local', 'admin', 'admin123', 1, 1, 0, 'seed')
ON CONFLICT (id) DO NOTHING;

-- 登入後首頁 /overview 需要至少一筆選單
-- searchMenus 查詢：Menus JOIN status WHERE stutype='enabled' AND usagetable='menus'
INSERT INTO status (id, stucode, stutype, usagetable, studesc, usercreated)
VALUES (2, 0, 'enabled', 'menus', '啟用的選單', 'seed')
ON CONFLICT (id) DO NOTHING;

INSERT INTO menus (id, status, label, name, path, usercreated)
VALUES (1, 2, '總覽', 'overview', 'overview', 'seed')
ON CONFLICT (id) DO NOTHING;
