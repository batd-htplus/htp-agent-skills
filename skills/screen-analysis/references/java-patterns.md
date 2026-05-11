# Tham chiếu pattern Java

## Cấu trúc class

```java
package tvmk.tscrum.{MODULE};

public class {SCREEN_ID} extends AppServlet implements TextTemplateListener {
    private boolean sortKey1Asc = true;

    public void service(HttpServletRequest request, HttpServletResponse response) {
        AppLogic logic = initServlet(request, response);
        AppParameters param = new AppParameters(request);
        String event = param.get("event", "{SCREEN_ID}00");

        FieldSetHTML fs = new FieldSetHTML();
        // ... field registration ...
        // ... event dispatch ...

        template.writeTo(response.getWriter());
    }

    public void replaceKeyword(String keyword, PrintWriter writer, Object parameter) {
        if (keyword.equals("list")) { writeList(...); }
    }
}
```

## Event dispatch

```java
// if-else chain
if (event.equals("AB101100")) { search(...); }
else if (event.equals("AB101102")) { sort(...); }
```

## DB access

```java
TextTemplate sql = logic.getLocalTemplate("AB101101.sql");
String sqlStr = sql.replace();
PreparedStatement st = logic.getDBAccessor().prepareStatement(sqlStr);
st.setString(1, fs.getString("psonCd"));
ResultSet rs = st.executeQuery();
List<Map<String, String>> list = logic.getDBAccessor().resultSetToList(rs);
logic.close(rs);
logic.close(st);
logic.close();
```

## Field registration

```java
fs.add(new FieldHidden("sortKeySws", value));
fs.add(new FieldHidden("sortNo", "0"));
fs.add(new FieldButton("AB101101", ...));
fs.add(new FieldText("psonCd", 10, 10));

// Trong writeList (data display)
fs.add(new FieldText("DEN_NO", row.get("DEN_NO")));
```

## Master data access

```java
MstTMS00050 mst = new MstTMS00050(logic);
mst.select("A16", key);
String name = mst.getString("DATA_NAME");
```
