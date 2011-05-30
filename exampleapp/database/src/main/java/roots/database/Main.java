package roots.database;

import liquibase.exception.CommandLineParsingException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) throws CommandLineParsingException, IOException, NoSuchFieldException, IllegalAccessException {
        List<String> defaultArgs = Arrays.asList(
                "--driver=com.mysql.jdbc.Driver",
                "--url=jdbc:mysql://localhost/roots",
                "--username=roots",
                "--password=roots",
                "--changeLogFile=roots/database/db.changelog-master.xml"
        );
        List<String> suppliedArgs = Arrays.asList(args);
        List<String> liquibaseArgs = new ArrayList<String>();

        liquibaseArgs.addAll(defaultArgs);
        liquibaseArgs.addAll(suppliedArgs);

        liquibase.integration.commandline.Main.main(liquibaseArgs.toArray(new String[liquibaseArgs.size()]));
    }
}

