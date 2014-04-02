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

        get(new FreeMarkerRoute("/view") {
            @Override
            public Object handle(Request request, Response response) {
                String output = "";
                try {
                    String[] roots = new String[] { "." };
                    GroovyScriptEngine gse = new GroovyScriptEngine(roots);
                    Binding binding = new Binding();
                    binding.setVariable("baseURL", "http://gatherer.wizards.com/magic/draftools/draftviewer.asp?draftid=08_01_2013_1");
                    gse.run("src/main/groovy/script/scrape.groovy", binding);
                    Object outputObj = binding.getVariable("output");
                    if (outputObj!=null) {
                        output = outputObj.toString();
                    }
                } catch(Exception e) {
                    output = "{error: \"unknown error: "+ ExceptionUtils.getStackTrace(e)+"\"}";
                }
                Map<String, Object> attributes = new HashMap<String, Object>();
                attributes.put("output", output);
                return modelAndView(attributes, "view.ftl");
            }
        });

    }

}