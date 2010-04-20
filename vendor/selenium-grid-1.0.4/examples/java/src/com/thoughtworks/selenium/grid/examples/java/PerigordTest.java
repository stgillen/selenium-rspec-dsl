package com.thoughtworks.selenium.grid.examples.java;

import org.testng.annotations.Test;


/**
 */
public class PerigordTest extends GoogleImageTestBase {


    @Test(groups = {"example", "firefox", "default"}, description = "Lascaux Hall of the Bull")
    public void rubinius() throws Throwable {
        runFlickrScenario("Lascaux Hall of the Bull");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Sarlat")
    public void pontNeuf() throws Throwable {
        runFlickrScenario("Sarlat");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Cathedral in Perigueux")
    public void notreDameDeParis() throws Throwable {
        runFlickrScenario("Cathedral in Perigueux");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Montbazillac")
    public void versailles() throws Throwable {
        runFlickrScenario("Montbazillac");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Domme - La Halle Fleurie")
    public void domme() throws Throwable {
        runFlickrScenario("Domme - La Halle Fleurie");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Rouffignac")
    public void rouffignac() throws Throwable {
        runFlickrScenario("Rouffignac");
    }


}