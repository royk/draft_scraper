import static spark.Spark.*;

import groovy.lang.Binding;
import groovy.lang.GroovyClassLoader;
import groovy.lang.GroovyObject;
import groovy.util.GroovyScriptEngine;
import org.apache.commons.lang3.exception.ExceptionUtils;
import spark.*;
import spark.template.freemarker.FreeMarkerRoute;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        setPort(System.getenv("PORT"));
        get(new FreeMarkerRoute("/view") {
            @Override
            public Object handle(Request request, Response response) {
                return modelAndView(null, "view.ftl");
            }
        });

        get(new FreeMarkerRoute("/scrape_view") {
            @Override
            public Object handle(Request request, Response response) {
                return modelAndView(null, "scrape_view.ftl");
            }
        });

        get(new Route("/loadSavedDraft") {
            @Override
            public Object handle(Request request, Response response) {
                String draftId = request.queryParams("draftId");
                String output = "";
                try {
                    String[] roots = new String[] { "." };
                    GroovyScriptEngine gse = new GroovyScriptEngine(roots);
                    Binding binding = new Binding();
                    binding.setVariable("draftId", Integer.parseInt(draftId));
                    gse.run("src/main/groovy/script/savedDrafts.groovy", binding);
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