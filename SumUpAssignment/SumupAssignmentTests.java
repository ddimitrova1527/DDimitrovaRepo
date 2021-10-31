import Pages.HelpPage;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.After;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import static org.junit.Assert.assertEquals;

public class SumupAssignmentTests {
    private static WebDriver driver;

    @BeforeClass
    public static void setUp() {
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
    }

    @After
    public void tearDown() {
        driver.quit();
    }

    @Test
    public void verifyHelpPageSearchResults() {
        HelpPage helpPage = new HelpPage(driver);
        helpPage.open();
        helpPage.waitForPageToLoad();
        helpPage.selectCountryDropdownOption("United States");
        helpPage.waitForPageToLoad();
        helpPage.searchForText("invoice");
        helpPage.waitForPageToLoad();
        int searchResult = helpPage.getSearchResultNumber();
        int expectedSearchNumber = 23;
        assertEquals("The number of returned result in the search is not expected.", expectedSearchNumber, searchResult);
        helpPage.navigateToLastPageSearchResults();
        String searchResultTitle = helpPage.getLastSearchResultTitleOnPage();
        helpPage.clickOnLastSearchResultTitleOnPage();
        String searchedArticleTitle = helpPage.getSearchedArticleTitle();
        assertEquals("The result item title does not match the title of the section you’re lead to.", searchResultTitle, searchedArticleTitle);
        helpPage.navigateToMainPage();
    }
}
