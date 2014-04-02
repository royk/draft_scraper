import static spark.Spark.*;

import groovy.lang.Binding;
import groovy.lang.GroovyClassLoader;
import groovy.lang.GroovyObject;
import groovy.util.GroovyScriptEngine;
import org.apache.commons.lang3.exception.ExceptionUtils;
import spark.*;

import java.io.File;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {

        get(new Route("/view") {
            @Override
            public Object handle(Request request, Response response) {
                String output = "";
                try {
                    String[] roots = new String[] { "." };
                    GroovyScriptEngine gse = new GroovyScriptEngine(roots);
                    Binding binding = new Binding();
                    binding.setVariable("input", "world");
                    gse.run("src/main/groovy/script/scrape.groovy", binding);
                    Object outputObj = binding.getVariable("output");
                    if (outputObj!=null) {
                        output = outputObj.toString();
                    }
                } catch(Exception e) {
                    output = "unknown error: "+ ExceptionUtils.getStackTrace(e);
                }
                return output;
            }
        });

    }

}