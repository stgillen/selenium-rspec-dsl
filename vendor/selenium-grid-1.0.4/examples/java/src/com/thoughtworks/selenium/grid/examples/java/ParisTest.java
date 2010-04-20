package com.thoughtworks.selenium.grid.examples.java;

import org.testng.annotations.Test;


/**
 */
public class ParisTest extends GoogleImageTestBase {

    @Test(groups = {"example", "firefox", "default"}, description = "Louvre")
    public void louvre() throws Throwable {
        runFlickrScenario("Louvre");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Louvre")
    public void rubinius() throws Throwable {
        runFlickrScenario("Louvre");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Pont Neuf")
    public void pontNeuf() throws Throwable {
        runFlickrScenario("Pont Neuf");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Notre Dame de Paris")
    public void notreDameDeParis() throws Throwable {
        runFlickrScenario("Notre Dame de Paris");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Versailles")
    public void versailles() throws Throwable {
        runFlickrScenario("Versailles");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Seine by Night")
    public void seine() throws Throwable {
        runFlickrScenario("Seine by Night");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Tour Eiffel")
    public void tourEiffel() throws Throwable {
        runFlickrScenario("Tour Eiffel");
    }

    @Test(groups = {"example", "firefox", "default"}, description = "Avenue des Champs Elysees")
    public void champsElysees() throws Throwable {
        runFlickrScenario("Avenue des Champs Elysees");
    }

}