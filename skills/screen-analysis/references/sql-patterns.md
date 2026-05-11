# Tham chiếu pattern SQL

## Placeholder system

| Placeholder | Được thay bởi | Ví dụ |
|------------|--------------|-------|
| `$$rows$$` | Row limit | `SELECT TOP 50` |
| `$$sortKeyFirst$$` | ORDER BY clause | `ORDER BY APL_DAY ASC` |
| `$$range.xxx$$` | Conditional block | `$$range.denNo$$ AND DEN_NO like ? $$range.denNo$$` |

## Parameter binding

JDBC-style `?` — thứ tự quan trọng:
```sql
WHERE APL_PERSON_NO = ?      -- st.setString(1, value)
  AND FLG_DELETE = '0'       -- hard-coded
```

## Bảng transaction (TTAxxxxx)
```sql
FROM TTA00100 A              -- Bảng chính, alias = A
LEFT JOIN TTA00110 B ON ...  -- Bảng phụ, alias = B
```

## Bảng master code (TMSxxxxx)
```sql
LEFT JOIN TMS00050 M50A 
  ON M50A.KEY1 = A.BT_STS_KBN 
  AND M50A.CTRL_CL = 'A16'   -- Ctrl class = module code
```

## Soft delete
```sql
AND A.FLG_DELETE = '0'       -- '0' = active, '1' = deleted
```

## SQL file naming

```
{SCREEN_ID}{NN}.sql
AB101101.sql  → Screen AB1011, query #01
AB101102.sql  → Screen AB1011, query #02
```
