---
author:
  name: "Edirin Atumah"
linktitle:
title: "A Beginner's Guide to Designing Page Objects - Pt.3"
date: 2021-01-18
publishdate: 2021-01-18
draft: false
toc: false
type:
weight: 10
Cover: "images/po/done.png"
Credit: "Photo by Malte Luk from Pexels"
tags:
  - selenium, automation
series:
    - PageObject
---

## Introduction
In the last post, we applied design techniques to refactor the test class and the underlying code design.

Read it [here](/posts/a-beginners-guide-to-designing-page-objects-pt.2)

In this final guide, we will look at how to refactor a page object in response to changes from the business.

When you finish reading, you will be able to create effective page objects for any UI interface you encounter using design principles.

## Prerequisites

Before you begin this guide you'll need the following:
{{< tip >}}
- Read [Part Two](/posts/a-beginners-guide-to-designing-page-objects-pt.2)
{{< /tip >}}

Let's do it 💪💪💪

## The Current Test:
![test class](/images/po/pg3.png)

### New Requirement:
{{< tip >}}
- Add test to search from the results page.
{{< /tip >}}

There are two Test cases now.

We should write them out again so it is clear

#### Testcase 1: User can start search from Home page
- Be on the Home page
- Type `Selenium Java` in the searchbox
- click the first suggestion from auto-suggest dropdown
- Assert results are displayed on the search page.

#### Testcase 2: User can start search from results page
- Be on the Search results page
- Type `Selenium Java` in the searchbox
- click the first suggestion from auto-suggest dropdown
- Assert results are displayed on the search page.

{{< tip >}}
- Notice how similar this journey is to our existing test case.
The only difference is one starts from the home page, the other from results page!
{{< /tip >}}


## Step 1 — Add the new test case
{{< image  src="/images/po/new-requirement.png" >}}

### What has changed?
- We added two new methods _`openHomePage()`_ & _`openSearchPage()`_ to the search engine object, to make sure the test starts from the right page.

- We changed the _test name_, _assertion_ and the _message returned_ on failure.

- We removed all references to WebDriver from the test class.

- **NOTHING ELSE!** That's right. Nothing else needed to change in the test class, because we have written a resilient class.


## Step 2 — Let's update the interface with the 2 new methods
{{< image  src="/images/po/new-interface.png" >}}

## Step 3 - Let’s implement the new methods in the GoogleSearchEngine Class.
{{< image  src="/images/po/new-implementation.png" >}}

## Step 4 - Let’s refactor the searchFor method in the GoogleSearchEngine Class.
Looking at current implementation below:

{{< image  src="/images/po/pg4.png" >}}

- We notice the method began from the `GoogleHomePage`, entered `SearchText` via the HomePage and `results` is also coming from the homepage.

In a nutshell, the implementation of `searchFor()` couples it to the GoogleHomePage making it hard to cater for the new requirement.


#### What do we do?

### 1. Decouple SearchFor implementation from GoogleHomePage
- #### Find the common element between Homepage & Result page

#### _Home Page_
{{< image  src="/images/po/hp-searchform.png" >}}

#### _Results Page_
{{< image  src="/images/po/rp-searchform.png" >}}


You will notice the `searchForm` is common across all Google Pages. Thus, making it a candidate to extract from the Homepage and move to its own class with the search behaviours.

#### _SearchForm_

{{< image  src="/images/po/new-searchform.png" >}}

- #### Refactor searchFor() to use the searchForm in the GoogleSearchEngine class.

{{< image  src="/images/po/new-searchFor.png" >}}


- #### Add a Search Results page to extract results into Domain class SearchResults.
- This page will extract the link & linkText values from the WebElement List

{{< image  src="/images/po/sr-page.png" >}}

- This populates the SearchResults domain object.

{{< image  src="/images/po/search-results.png" >}}


### Now are back to the where we started.
The test class! But this time, we have refactored all the framework code.
The test should work perfectly.

{{< image  src="/images/po/new-requirement.png" >}}

## What have we done so far?
- Refactored the test class add new test case and remove framework code like `WebDriver`.

- Refactored GoogleSearchEngine#searchFor method to not depend on GoogleHomePage

- Added Navigation methods to the SearchEngine Interface.

- Created SearchForm component to handle all search related task.

- Created SearchResultPage to collect result.

## Conclusion

This completes the three part Page Object series 🥳.

Now go forth and use the lessons from this article to build page  objects for your projects.

## Things to Note
For brevity the classes were edited to focus on the relevant details, but don't worry you can find the complete code in my Github repo.

https://github.com/bongosway/selenium-starter


I am happy to answer questions you may have, reach me on any of my handles.
