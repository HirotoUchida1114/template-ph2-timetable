-- W2 POSSE課題：index.html の区画7〜11と同じ結果を返す SQL を書く
-- 書いた SQL は db コンテナの psql（docker compose exec db psql -U posse -d timetable）で実行し、
-- 表示が index.html の区画と一致することを確かめてから書くこと
-- 曜日（day）は数字のまま返してよい

-- 区画7：すべての授業と教室の情報（科目コードの順）
SELECT * FROM courses 

-- 区画8：曜日ごとの授業数（曜日の順）
SELECT 
  CASE day
    WHEN 1 THEN '月'
    WHEN 2 THEN '火'
    WHEN 3 THEN '水'
    WHEN 4 THEN '木'
    WHEN 5 THEN '金'
  END AS 曜日,
  COUNT(*) AS 授業数
FROM courses
GROUP BY day
ORDER BY day ASC;

-- 区画9：建物ごとの授業数と合計単位（建物名の順）
SELECT 
  SUBSTRING(room FROM 1 FOR 1) || '棟' AS 建物,
  COUNT(*) AS 授業数,
  COUNT(*) * 2 AS 合計単位
FROM courses
WHERE room IS NOT NULL 
  AND room <> '体育館'
GROUP BY SUBSTRING(room FROM 1 FOR 1)
ORDER BY 建物 ASC;


-- 区画10：授業を3つ以上担当している教員（授業数の多い順、同数なら名前の順）
SELECT 
  teacher AS 教員,
  COUNT(*) AS 授業数
FROM courses
WHERE teacher IS NOT NULL
GROUP BY teacher
HAVING COUNT(*) >= 3
ORDER BY 授業数 DESC, 教員 ASC;


-- 区画11：授業が1つも入っていない教室（教室コードの順）
SELECT room_code, room_name
FROM room
WHERE room_code NOT IN (
    SELECT DISTINCT room_code 
    FROM classes 
    WHERE room_code IS NOT NULL
)
ORDER BY room_code ASC;