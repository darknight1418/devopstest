import org.junit.Test;

public class ParseSimpleJsonTest {

    @Test
    public void ParseSimpleJsonTest(){

        String json = "{\"person\": {\"firstname\": \"adnan\",\"lastname\": \"ajmi\",\"company\": \"kpmg\",\"city\": \"london\",\"country\": \"UK\"}}";
        String key = "lastname";
        NestedString nestedString = new NestedString();
        nestedString.processString(json,key);

    }
}
