-- Lohas 最小可登入種子資料
-- 登入查詢：member JOIN status(mailStatus) WHERE usermail=? AND userpassword=? AND stutype='validated' AND usagetable='member'
-- 密碼為明文比對
INSERT INTO status (id, stucode, stutype, usagetable, studesc, usercreated)
VALUES (1, 0, 'validated', 'member', '已驗證會員', 'seed')
ON CONFLICT (id) DO NOTHING;

INSERT INTO member (id, usermail, username, userpassword, mailstatus, userstatus, zipcode, usercreated)
VALUES (1, 'admin@lohas.local', 'admin', 'admin123', 1, 1, 0, 'seed')
ON CONFLICT (id) DO NOTHING;
