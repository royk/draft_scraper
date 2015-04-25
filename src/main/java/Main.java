import static spark.Spark.*;

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

    }

}