# Automation Project

**Automated Testing Framework (ATF), using Selenium as a general purpose WebDriver library, that serves as the core communication between test scripts and browser.**

**Framework consists of these libraries:**

* Java Standard Library
* Selenium WebDriver - version 4.0.0-alpha-2
* JUnit - version 4.12

**Importing the project**
This is a maven project and it should be imported in the IDE as Maven project.
* Using IntelliJ IDE: 

From the File Menu -> Open 
The Select File or Directory to Import the project.
Build the pom file -> right click on Pom -> Maven -> Reload Project


**Running test cases locally**
```
mvn test -Dtest=SumupAssignmentTests
```
Go to SumupAssignmentTests class, and right click on the name of the test and then Run {Test} Ctrl+Shift+F10
