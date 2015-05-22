import static spark.Spark.*;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mongodb.*;
import groovy.lang.Binding;
import groovy.lang.GroovyClassLoader;
import groovy.lang.GroovyObject;
import groovy.util.GroovyScriptEngine;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import spark.*;
import spark.template.freemarker.FreeMarkerRoute;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Main {
    private static String LOCAL_PORT = "4567";
    public static void main(String[] args) {
        staticFileLocation("/public");
        String port = System.getenv("PORT");
        if (StringUtils.isBlank(port)) {
            port = LOCAL_PORT;
        }
        MongoCredential credential = MongoCredential.createCredential(Conf.MONGODB_USER, Conf.MONGODB_DB, Conf.MONGODB_PASS);

        MongoClient mongoClient = new MongoClient(new ServerAddress(Conf.MONGODB_URL, Conf.MONGODB_PORT), Arrays.asList(credential));
        final DB db = mongoClient.getDB(Conf.MONGODB_DB);
        setPort(Integer.parseInt(port));
        get(new FreeMarkerRoute("/") {
            @Override
            public Object handle(Request request, Response response) {
                Map<String, Object> attributes = new HashMap<String, Object>();
                String output = "";
                try {
                    String[] roots = new String[] { "." };
                    GroovyScriptEngine gse = new GroovyScriptEngine(roots);
                    Binding binding = new Binding();
                    gse.run("src/main/groovy/script/savedDrafts.groovy", binding);
                    Object outputObj = binding.getVariable("output");
                    if (outputObj!=null) {
                        output = outputObj.toString();
                    }
                } catch(Exception e) {
                    output = "{error: \"unknown error: "+ ExceptionUtils.getStackTrace(e)+"\"}";
                }
                attributes.put("draftsData", output);
                return modelAndView(attributes, "index.ftl");
            }
        });
        get(new Route("/scrape") {
            @Override
            public Object handle(Request request, Response response) {
                String baseURL = request.queryParams("url");
                String output = "";
                try {
                    String[] roots = new String[] { "." };
                    GroovyScriptEngine gse = new GroovyScriptEngine(roots);
                    Binding binding = new Binding();
                    binding.setVariable("baseURL", baseURL);
                    gse.run("src/main/groovy/script/scrape.groovy", binding);
                    Object outputObj = binding.getVariable("output");
                    if (outputObj!=null) {
                        output = outputObj.toString();
                    }
                } catch(Exception e) {
                    output = "{error: \"unknown error: "+ ExceptionUtils.getStackTrace(e)+"\"}";
                }
                return output;
            }
        });
        get(new Route("/getStatistics") {

            @Override
            public Object handle(Request request, Response response) {
                String draftId = request.queryMap("draftId").value();
                DBCollection coll = db.getCollection("cardStatistics");
                DBObject query = new BasicDBObject("draftId", draftId);
                DBCursor cursor = coll.find(query);
                JsonObject resultJson = new JsonObject();

                try {
                    while (cursor.hasNext()) {
                        DBObject card = cursor.next();
                        String pick = card.get("pick").toString();
                        if (!resultJson.has(pick)) {
                            resultJson.add(pick, new JsonObject());
                        }
                        JsonObject pickObj = resultJson.getAsJsonObject(pick);
                        pickObj.addProperty(card.get("cardKey").toString(), Integer.parseInt(card.get("hits").toString()));
                    }
                } finally {
                    cursor.close();
                }
                return resultJson.toString();
            }
        });
        put(new Route("/savePick") {
            @Override
            public Object handle(Request request, Response response) {
                JsonObject data = new JsonParser().parse(request.body()).getAsJsonObject();
                String cardKey = data.getAsJsonPrimitive("card").getAsString();
                String cardValue = data.getAsJsonPrimitive("pick").getAsString();
                String draftId = data.getAsJsonPrimitive("draftId").getAsString();
                DBObject searchQuery = new BasicDBObject();
                searchQuery.put("cardKey", cardKey);
                searchQuery.put("pick", cardValue);
                searchQuery.put("draftId", draftId);
                DBObject modifiedObject = new BasicDBObject();
                modifiedObject.put("$inc", new BasicDBObject().append("hits", 1));
                DBCollection coll = db.getCollection("cardStatistics");
                coll.update(searchQuery, modifiedObject,true,false);
                return response;
            }
        });

    }

}