---
author:
  name: "Edirin Atumah"
linktitle:
title: "A Beginner's Guide to Designing Page Objects - Pt.2"
date: 2020-09-26T03:59:58+01:00
draft: false
toc: false
type:
- post
- posts
weight: 10
Cover: "images/po/two.jpg"
Credit: "Photo by Miguel Á. Padriñán from Pexels"
tags:
  - selenium, automation
series:
    - PageObject
---

## Introduction
In the last post we created our first Page Object, (read it [here](/posts/a-beginners-guide-to-designing-page-objects-pt.1) ) we were able to run a test to verify it works as expected.

In this guide, we'll apply design principles to refactor the test and page objects we created.

When you're finished, you'll be able to create effective page objects for any UI interface you encounter using design principles.

## Prerequisites

Before you begin this guide you'll need the following:

- Read [part one](/posts/a-beginners-guide-to-designing-page-objects-pt.1)  

Let's do it :muscle:  


## Lets start the refactoring with the test class:
#### GoogleUITest.java

![test class](/images/po/pg-test.png)

### What areas we can improve and why:

*RULE:* Your Test Class Should test behaviour NOT implementation.

- `GoogleHomePage homePage = new GoogleHomePage(driver);`
    - This ties the test to the page object implementation of GoogleHomePage, therefore if the page object API changes, the test would need to be modified.

-   `SearchResultPage resultPage =
    homePage.enterSearchText("Selenium").selectFirstAutoSuggest();`
    - How the actions are done is not a concern for the test class i.e if `AutoSuggest` feature is removed, then this test class breaks.

- `assertTrue(resultPage.getResultSetCount() > 5);`
    - This breaks the ["Tell, Don't Ask" principle"](https://martinfowler.com/bliki/TellDontAsk.html) i.e the logic of checking result set against a number should not be in the test. If results and computational logic changes it will break the test.

### Let's rewrite the test class to remove these areas of concern:

#### Step 1:
- Identify the domain concept and the behaviours connected to it:
    - For us it will be:
        - Concept - `SearchEngine` & `SearchResult`
        - Behaviour - `search for a term` & `return results for that term`
        - Logic - `SearchResult` is the domain object we tell to perform desired logic on the search result.

_Using these approach to rewrite the test class, it should now look like this:_

#### RefactoredTest.java

![RefactoredTest](/images/po/pg3.png)

Voilà! all the clicks and selects et al have now disappeared!

### Your test class is now decoupled from the page object.  

If you replace `SearchEngine searchEngine = new GoogleSearchEngine(driver);`  
with `SearchEngine searchEngine = new BingSearchEngine(driver);`   
The test won't concern itself about the underlying search engine in use.  

#### Step 2:
#### 1. Let's build the behaviour as an Interface
![interface](/images/po/interface1.png)

#### 2. Let's build an implementation of the Interface using the page object to fulfil the needs of the behaviour.

![implement interface](/images/po/pg4.png)


#### 3. This is the GoogleHomePage PageObject
![homePage](/images/po/pg5.png)


#### 4. Let's build the SearchResult
![search result](/images/po/pg6.png)

## What have we done so far?
- Refactored the test class to contain only behaviour not implementation.
- Identify the domain concept and related behaviours.
- Created an Interface to model the behaviour.
- Created a concrete class to implement the interface using pageobject to satisfy the behaviour.
- Modify the GoogleHomePage PageObject.
- Created Domain Class to hold SearchResult.

## See all classes here for easy reference.
{{< tip >}}
TIP:

- Don't copy and paste.
- Type the below code by hand.
- Read this brilliant [article](https://www.freecodecamp.org/news/the-benefits-of-typing-instead-of-copying-54ed734ad849/) to understand why.
{{< /tip >}}

![RefactoredTest](/images/po/pg3.png)

![interface](/images/po/interface1.png)

![implement interface](/images/po/pg4.png)

![homePage](/images/po/pg5.png)

![search result](/images/po/pg6.png)

## Conclusion

In this article we have applied design techniques to optimize the test and the underlying code design.
Now you can run the test and put your result in the comments section.


## Things to Note
In the next post in this series, we shall be applying design techniques to optimize the `GoogleHomePage` PageObject.

Before then, feel free to write another test using a completely different search engine in the test class and create your implementation of the interface.  

I am happy to answer questions you may have, reach me on any of my handles.
