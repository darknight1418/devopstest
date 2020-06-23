import org.json.JSONObject;
import org.json.JSONArray;

public class NestedString {

    public void processString(String jsonObj, String keyValue) {

        JSONObject jsonObject = new JSONObject(jsonObj);
        JSONArray key = jsonObject.names();

        for (int i = 0; i < key.length(); ++i) {
            String keys = key.getString(i);

            if (!jsonObject.getJSONObject(keys).getString(keyValue).isEmpty()) {
                String requiredValue = jsonObject.getJSONObject(keys).getString(keyValue);
                System.out.println("The value of key " + keyValue + " is " + requiredValue);
            }
        }
    }
}

