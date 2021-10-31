package Pages;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class HelpPage {
    public static final int TIMEOUT_IN_SECONDS = 10;
    private WebDriver driver;

    public HelpPage(WebDriver driver) {
        this.driver = driver;
    }

    public void open() {
        driver.get("https://help.sumup.com/en-GB");
    }

    public void waitForPageToLoad() {
        WebDriverWait webDriverWait = new WebDriverWait(driver, TIMEOUT_IN_SECONDS);
        webDriverWait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("//header//a[contains(@href,'https://help.sumup.com/hc/') or (@aria-label='SumUp Logo')]")));
    }

    public void selectCountryDropdownOption(String optionName) {
        WebElement countryDropdown = driver.findElement(
                By.xpath("(//*[@aria-label='Country Picker'])[2]//..//*[contains(@class,'react-select__single-value')]"));
        countryDropdown.click();
        WebElement optionSelect = driver.findElement(By.xpath(String.format("//p[contains(text(),'%s')]", optionName)));
        Actions action = new Actions(driver);
        action.moveToElement(optionSelect).click().build().perform();
    }

    public void searchForText(String searchText) {
        WebElement searchInput = driver.findElement(By.xpath("//input[@type='search' or contains(@placeholder,'Search')]"));
        searchInput.clear();
        searchInput.sendKeys(searchText);
        searchInput.sendKeys(Keys.ENTER);
    }

    public int getSearchResultNumber() {
        String searchResult = driver.findElement(By.xpath("(//*[contains(text(),'invoice')])[1]")).getText();

        if (searchResult.matches(".*\\d.*")) {
            return Integer.parseInt(searchResult.replaceAll("[^0-9]", ""));
        } else {
            return 0;
        }
    }

    public void navigateToLastPageSearchResults() {

        if (new WebDriverWait(driver, TIMEOUT_IN_SECONDS).until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//*[contains(@class,'pagination-next')]"))).isDisplayed()) {
            driver.findElement(By.xpath("//*[contains(@class,'pagination-next')]//preceding::a[1]")).click();
        }
    }

    public String getLastSearchResultTitleOnPage() {
        return driver.findElement(By.xpath("(//section/div//h2)[last()]")).getText();
    }

    public void clickOnLastSearchResultTitleOnPage() {
        driver.findElement(By.xpath("(//section/div//h2)[last()]")).click();
    }

    public String getSearchedArticleTitle() {
        return driver.findElement(By.tagName("h1")).getText();
    }

    public void navigateToMainPage() {
        WebElement homeLink = driver.findElement(By.xpath("//header//a[contains(@href,'https://sumup.')]"));
        homeLink.click();
    }
}
