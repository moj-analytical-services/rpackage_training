# Developing R packages
This training is designed as an introduction to making and developing R packages which are important to reproducible ways of working. You should first have completed the following training sessions (or reached an equivalent standard to having done so):

- [Introduction to using R on the Analytical Platform](https://github.com/moj-analytical-services/intro_using_r_on_ap)
- [Introduction to R](https://github.com/moj-analytical-services/IntroRTraining)
- [R Charting](https://github.com/moj-analytical-services/ggplotTraining)
- [Writing functions in R](https://github.com/moj-analytical-services/writing_functions_in_r)

Recordings of these sessions can be viewed via links provided in the [Analytical Platform and related tools training section on R training](https://moj-analytical-services.github.io/ap-tools-training/ITG.html#r-training). If you have any access problems please contact <aidan.mews@justice.gov.uk> or <georgina.eaton4@justice.gov.uk>.

You should also have completed the following (if not done already):
1.	Steps 1 to 4 and 6 of [this MoJ Analytical Platform quickstart guide](https://user-guidance.analytical-platform.service.justice.gov.uk/get-started.html#get-started), making sure you can access RStudio from the control panel.
2. Clone this course repository from GitHub into RStudio. Guidance on how to clone repos can be found at [Using GitHub with the platform - MoJ Analytical Platform](https://user-guidance.analytical-platform.service.justice.gov.uk/github/rstudio-git.html#step-1-navigate-to-your-platform-r-studio-and-make-a-copy-of-the-github-project-in-your-r-studio)
3.	Once you have cloned the repository run these lines in your RStudio console, including to install appropriate versions of the packages devtools and usethis: 

        install.packages("renv")
  	     renv::restore()

If you have any issues, please post them in the appropriate Slack channel (either #[ask-operations-engineering](https://moj.enterprise.slack.com/archives/C01BUKJSZD4) or #[intro_r channel](https://asdslack.slack.com/archives/CGKSJV9HN))

Lastly, if you are able to, it may also help to make use of dual screens (your laptop plus a monitor) during the training session to enable you to watch the session on one and code on the other.

## Contents

* [Package overview](#package-overview)
   + [1. Introduction](#1-introduction)
   + [2. Naming and setting up your project](#2-naming-and-setting-up-your-project)
* [Package structure](#package-structure)
   + [3. Create the package](#3-create-the-package)
   + [4. Amend the DESCRIPTION file](#4-amend-the-DESCRIPTION-file)
* [Adding functions](#adding-functions)
   + [5. Developing functions](#5-developing-functions)
   + [6. Add R and Rmarkdown code](#6-add-R-and-Rmarkdown-code)
   + [7. Making functions work in a package](#7-making-functions-work-in-a-package)
   + [8. Documenting functions](#8-documenting-functions) 
* [Exception handling](#exception-handling)
   + [9. Using the condition system for functions](#9-using-the-condition-system-for-functions)
* [Testing code](#testing-code)
   + [10. Testing your code](#10-testing-your-code)
   + [11. Unit testing](#11-unit-testing)
* [Releasing a package](#releasing-a-package)
   + [12. Checking your package](#12-checking-your-package)
   + [13. Managing releases and future changes to your package](#13-managing-releases-and-future-changes-to-your-package)
   + [14. Installing and using your package](#14-installing-and-using-your-package)
* [Maintenance cycle](#maintenance-cycle)
   + [15. Adding a NEWS file](#15-adding-a-news-file)
   + [16. Continuous integration](#16-continuous-integration)
* [Annex](#annex)
   + [A1. Excluding sensitive data](#a1-excluding-sensitive-data)
   + [A2. Adding data in rda format](#a2-adding-data-in-rda-format)
   + [A3. Adding documentation about package data](#a3-adding-documentation-about-package-data)

## Package overview 

### 1. Introduction

This training is based on Hadley Wickham's book [R Packages](http://r-pkgs.had.co.nz/). The goal of it is to teach you how to make and develop packages. These are not difficult to make but enable others to easily use your code (increasing efficiency, reducing the maintenance burden, and also helping improve quality) and have time saving conventions that you can follow (e.g. to organise code). The latter can be very beneficial to use in projects even if you are not making packages. 
 
Hadley Wickham's [R Packages introduction](https://r-pkgs.org/introduction.html) states: "In R, the fundamental unit of shareable code is the package. A package bundles together code, data, documentation, and tests, and is easy to share with others." The directory structure of an R package is typically as follows: 

- R code is in 'R' (this is required); 
- documentation is in 'man' (this is also required); 
- data are in 'data'; 
- tests are in 'tests'; 
- dependency management may be in the associated directory e.g. 'renv' if using renv; and 
- templates on how to use the package are in 'vignettes'.

This training is designed with exercises in each section to enable you to develop a package. The files to do this are all included in this repository.

**Exercise 1:** Take a look at the structure of a github repo which contains [an R package](https://github.com/DCMSstats/eesectors) and see if you can recognise the structure described above.

### 2. Naming and setting up your project

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short; 
- be unique (for Google searches); 
- include either upper or lower case characters but not a mixture of them; 
- be clear about what the package does e.g. if a training exercise example, consider putting 'eg' in the name. 

You can read more in the [R Packages section Name your package](https://r-pkgs.org/workflow101.html#name-your-package).

As we're going to develop a package for the minimal statistical bulletin created as part of the [Introduction to R Markdown](https://github.com/moj-analytical-services/rmarkdown_training), choose a name such as "egnamerap" where the eg is because it's a training exercise, the name is your first name (if your first name is very unique) and the rap because you are going to RAP a minimal statistical bulletin.

Once you have decided on a name, you can create a new github repository using it (following [this Analytical Platform guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/create-project.html#create-a-new-project-in-github)), and make a copy of your repository in your personal R Studio workspace (following step 1 of [this Analytical Platform guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/rstudio-git.html#step-1-navigate-to-your-platform-r-studio-and-make-a-copy-of-the-github-project-in-your-r-studio) - note as github.com has changed slightly since this guidance was made, the green button 'Clone or download' is now called 'Code'). 

The default branch of an R package GitHub repo should be reserved for working releases of the package. Always make your changes on a different branch then merge to the default branch for each release. 

**Exercise 2:** 
1. Decide what name to call your package
2. Create a new github repository, giving it your chosen name and a suitable description (e.g. 'My RAP training exercise'). Add a README file and a .gitignore file but not a license at this stage.
3. Make a copy of your project in R Studio.
4. Create a git branch called `0.0.1` where you can make changes.

## Package structure

### 3. Create the package 

A repository can easily be converted into a package using R Studio. Assuming you have already installed the package usethis ([see the opening paragraph of this README](#developing-r-packages--rap-ways-of-working)), run the following command and select the option to overwrite what is already there:

        usethis::create_package("path/to/package/pkgname")

After completing this process the 'Files' window will show additions to the project directory.

**Exercise 3:** Follow the above steps, inserting the correct directory path and package name within the create_package command (you can quickly obtain these using the getwd() command). Lastly, follow Steps 2 and 3 of [this guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/rstudio-git.html#work-with-git-in-rstudio) to commit all your changes to git and then push them to github.com. If you refresh your github.com repository page you should now see the additions there.

### Copyright and licencing

Licencing code is essential as it sets out how others can use it. You can read more about licencing 
[here](https://r-pkgs.org/license.html). The work-product of civil servants falls under 
[Crown copyright](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and usually requires an Open Government Licence but for open source software we have the [option
to use other open source licences](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/open-government-licence/open-software-licences/). The 
[MIT licence](https://opensource.org/license/mit/) is the [MoJ preferred choice](https://user-guidance.analytical-platform.service.justice.gov.uk/github/create-project.html#licence) and can be added to your package using:

```R
usethis::use_mit_license("Crown Copyright (Ministry of Justice)")
```
This will add two text files to the top level of your project, `LICENCE` and `LICENCE.md`. It will also update the relevant section in the DESCRIPTION file and update the .buildignore file.

**Exercise**

* Add an MIT licence to your package
* Commit (to the git version history) and push (to GitHub.com) both licence files


### 4. The description file

The [DESCRIPTION](https://r-pkgs.org/description.html#the-description-file) file contains important 
metadata about the package; it is a text file that you can open and edit in RStudio. An example of 
an amended DESCRIPTION file is provided 
[here](https://github.com/moj-analytical-services/psutils/blob/main/DESCRIPTION). The formatting 
is important. Each line consists of a field name and a value, separated by a colon. 
Where values span multiple lines, they need to be indented. In particular:

- **Title:** - a one line description of the package - keep this short, with suitable use of capitals and less than 65 characters.
- **Version:** - the package version. This must be amended when you update the package. Use Semantic Versioning (see below)
- **Authors@R:** - the package authors and their rolls (more info below)
- **Description:** - a one paragraph summary of the package
- **License:** - licencing information (this will have been automatically updated when you added the licence with {usethis}).
- **Imports:** - all the other packages that your package uses. You can specify a minimum or maximum version in brackets after the name. 
- **Suggests:** - packages that are not required for basic functionality but allow enhanced features such as vignettes or are useful during package development.
- **Remotes:** - if your package depends on another one that not on CRAN, this is where you specify how to find it.
- **Depends:** - this is where you list a minimum version of R if you are aware of one. For example if you are using the R native pipe (`|>`) in your package you would need to specify R (>= 4.1.0). 


#### Authors

Package authors are supplied as a vector of persons i.e. `c(person(...), person(...))`. In addition 
to a name and an email, each person should have a "role"" specified. More information can be found 
by running `?person` but the four most common roles are detailed below:

- aut: authors; those who have made significant contributions to the package.
- ctb: contributors; those who have made smaller contributions, like patches.
- cre: the package maintainer; the person you should contact if you have a problem.
- cph: copyright holder; most likely `person("Crown Copyright (Ministry of Justice)", role = "cph")` 

#### Dependency Management

The Imports and Suggests fields are used for dependency management for your package/ development 
processes. You want to be as permissive as possible specifying minimum or maximum versions of 
packages listed in Imports and Suggests to increase the compatability of your package with others. 
If you know that your code relies on functionality added in a particular version of a package you 
must specify the minimum version otherwise don't specify a minimum version.

There is a tool in {usethis} for adding packages to the description file. It will check if the 
package is installed before adding it so is useful for catching spelling mistakes!

By default, packages are added as Imports e.g. to add {dplyr} as an import: 
`usethis::use_package("dplyr")`. You can use the `type` argument to add them to Suggests instead e.g.
to add {devtools} as a suggested package: `usethis::use_package("devtools", type = "Suggests")`.

#### Semantic Versioning

Semantic Versioning is a version control paradigm which uses a major.minor.patch system to 
communicate what type of changes occur between versions. A "major change" will increment the
major number, a "minor change" will increment the minor number and a "patch change" will increment
the patch number. The type of version change is linked to the type of code changes you make. The full 
[Semantic Versioning specification](https://semver.org/) is worth reading and learning (especially 
points 2-8) but a basic summary for now:

* **You must not change your package without also changing the version number**.
* If your code update contains any backwards incompatible (breaking) changes e.g. removing/renaming a function, changing an argument name, etc you must implement a **major** version change.
* If your code update contains any backwards compatible new features e.g. adding a new function, etc you must implement at least a **minor** version change.
* If your code update only contains backwards compatible changes e.g. refactoring code, bug fix, etc this would be a **patch** version change.
* Before version 1.0.0 any type of changes can occur at any point (the normal rules don't apply to allow rapid development).
* Once your package is in use, the version should probably be at least 1.0.0.
* Incrementing a number sets those to the right of it to zero e.g. a major change from version 1.2.3 would take you to version 2.0.0; a minor change from 0.1.3 would take you to 0.2.0.

#### Checking your package
Packages require that the right files and the right information are in the right places. A small mistake
can prevent the package from functioning as intended. Many package features can be checked using
the function `devtools::check()`. It runs a series of checks that examine (among other things) package 
structure, metadata, code structure, and documentation. More information about the individual checks is 
available [here](https://r-pkgs.org/R-CMD-check.html). Any issues that are identified will be labeled
as "errors", "warnings" or "notes". Errors and warnings must be fixed. Occasionally it is acceptable
to leave a "note" but usually these should be fixed too.

**Exercise ** 
Amend the DESCRIPTION file of your package, specifically the: 
- Title PLACEHOLDER - example title
- Authors@R - make yourself author and maintainer and add Crown Copyright as the copyright holder
- Description PLACEHOLDER - example description.
(save the file)

Add {usethis} and {devtools} to Suggests

- Ensure the package version is `0.1.0`.
- Commit the changes

Run `devtools::check()` - there should be no errors, warnings or notes.

## Adding functions

### 5. Developing functions

Why, when and how to write your own functions is covered by the [Writing functions in R](https://github.com/moj-analytical-services/writing_functions_in_r) training. As this states, functions are a way to bundle up bits of code to make them easy to reuse. They can save you time, reduce the risk of errors, and make your code easier to understand. When commencing a project, you should:

* Consider and make a list of what functions would be beneficial. A good rule of thumb is to develop a function whenever you’d be using the same or similar code in three places. It is also helpful to consider others' needs e.g. you may know another analyst who needs similar code.
* After you've made a list, check whether the functions already exist (e.g. in the [mojrap](https://github.com/moj-analytical-services/mojrap) package). As appropriate use those that do and develop any that don't. 
* If developing a new function, consider where it's most beneficial for it to reside. For instance, it may be more beneficial to develop an [mojrap](https://github.com/moj-analytical-services/mojrap) type function within [mojrap](https://github.com/moj-analytical-services/mojrap) than within your package.

**Exercise 5**: Consider (by looking at crimesdata_pub.Rmd) whether it would be beneficial to incorporate any extra functions into your minimal statistical bulletin package (in addition to the summarise_crimes function provided by summarise_crimes.R)? Do you consider the summarise_crimes function beneficial?

### 6. Add R and Rmarkdown code 

Code can be added to a package by saving the R file to the package R directory and the R Markdown file to the package home directory. This can be done in R Studio by saving the files directly (e.g. using the 'Save As' option if they are in a different location), or by using the move/copy GUI options in RStudio. 

If the files are in github.com but not R Studio you have two main options to get them into R Studio. 
* Clone the relevant repository (as shown in [section 2](#2-choose-a-name)). 
* If there are only a few files you could click the green github 'Code' button (as in [section 2](#2-choose-a-name) above) and then 'Download ZIP' to download the files to your computer and then upload the relevant ones from your computer into your package using R Studio. 

**Exercise 6:** Add the crimesdata_pub.Rmd file and also the mystyles.docx file (which crimesdata_pub.Rmd calls on) from this repository to your package home directory. Lastly, commit all your changes to git and then push them to github.com. You can now refresh your github.com repository page and see the amendments there.

### 7. Making functions work in a package

While the format of code inside a package is very similar to "normal R code", it is particularly important to properly reference functions that you are using from other packages. This won't affect how your code runs, but it will ensure that others code works correctly when they use your package.

Normally when you use a function from another package, you might call that package in a library call, and then reference the function directly e.g.

        library(dplyr)
        
        data %>% filter(Year == 2020)

Doing this inside a package would cause the dplyr library to be loaded into the R environment which can then have unexpected (global) effects for the user of your package. Their code could then run in ways that they might not expect or want. For example, if someone calls your package that references the dplyr filter() function as above, this could result in their base filter() commands running as if they were dplyr ones. When using a function from another package, you should always specify the function along with the package it's from. You can do this using a double colon e.g.

        data %>% dplyr::filter(Year == 2020)

You will also, instead of using the library() command, need to add any packages you use to your own package's DESCRIPTION file to ensure they are available without causing unexpected effects to anyone who downloads your package. This was covered in [section 4](#4-amend-the-DESCRIPTION-file).   

**Exercise 7:** Add the summarise_crimes.R file from this repository to your package. Open the file and have a look at this function which provides the average number of crimes for the selected years; at the moment the package dplyr is not called correctly. Amend this code so it will work as expected for other users (which it will later after you have added dplyr to your package's DESCRIPTION file (a task in [section 4](#4-amend-the-DESCRIPTION-file))) by removing the "library()" call and calling the two dplyr functions (filter and summarise) specifically using the "double colon method". Lastly, commit all your changes to git and then push them to github.com. You can now refresh your github.com repository page and see the amendments there.

### 8. Documenting functions

Documentation is really important so users know how to use the package, and package managers and developers can quickly get up to speed. It should therefore be embedded within the package in such a way that it is easily available to all users. Best practice is for documentation about:
 
* Datasets (within the package) to be in a separate R script within the R folder.
* Functions (within the package) to be within the same R scripts.

Documentation of functions helps users to understand how they work, what arguments need to be given, and how the arguments need to be formatted.

The documentation of functions is done within the same R script as the function itself - see [this example]( https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R) from the eesectors package. Looking at the first 41 rows you can see a title (one sentence), description, details including inputs, what is returned, some examples, and the @export which enables users to access the function when they load your package. Functions which are not marked with @export can be used by other functions inside the package, but aren't readily available for users directly. Where you see the syntax \code{} the contents of the {} will be regarded as code.  

The process is as follows:

1. Add documentation to the .R file
2. Run devtools::document()
3. Preview in the help facility using ?objectname
4. Amend the documentation as appropriate and repeat steps 2 to 4. 

To check that the documentation enables others to easily understand the code you should get at least one other person to peer review your documentation. Are they able to understand how to use each function from the documentation alone?

You can learn more about documentation more generally by reading the [R Packages Object documentation chapter](https://r-pkgs.org/man.html)

**Exercise 8:** Follow the above process to add suitable documentation to the function summarise_crimes.R. It may be easiest to copy rows 1-41 from [this example](https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R) and then amend. You should include a helpful description, details of the inputs, an example, and specify @export to allow users to access the function. Lastly, commit all your changes to git and then push them to github.com. If you still have time, then do the same for the function that you created in the [section 13](#13-automating-quality-assurance-checks-on-input-data-sets) exercise above.

## Exception handling

### 9. Using the condition system for functions 

The [Advanced R Conditions chapter](https://adv-r.hadley.nz/conditions.html) states 'The condition system provides a paired set of tools that allow the author of a function to indicate that something unusual is happening, and the user of that function to deal with it'. R has a very powerful condition system which can be used to flag errors, warnings and messages.

A quick way of generating useful feedback is simply by wrapping the function body within the following code: 

    # informative error handling 
    out <- tryCatch(
    expr = {
        
    # your function body goes here 
    
        },  
    
    warning = function() {
    
        w <- warnings() 
        warning('Warning produced running function_name():', w) 
    
    }, 
    error = function(e)  {
    
        stop('Error produced running function_name():', e) 
    
    },
    finally = {} 
    )   
      
You can view [this applied example](https://github.com/DCMSstats/eesectors/blob/master/R/figure3.1.R) from the eesectors package. For further information, read the [Advanced R Conditions chapter](https://adv-r.hadley.nz/conditions.html).

**Exercise 9:** Apply the quick way of generating useful feedback to the function summarise_crimes.R and then run it to see what messages are produced. Lastly, commit all your changes to git and then push them to github.com.

## Testing code

### 10. Testing your code 

Anytime someone makes a change to the code, this should be accompanied by testing to check that it works as it should and the output is as expected. Such testing is best automated as manual testing is laborious, boring and time-consuming. Moreover, automated testing provides users with more assurance and helps those making changes to the code to identify any shortcomings and rectify these. 

While tests can be run when desired, it is better to set them up to run automatically before a github pull request is granted (see [section 19](#19-continuous-integration) on continuous integration). 

There are two types of test you should consider:
- unit tests (covered in [section 18](#18-unit-testing)); generally there should be at least one for each function. 
- integration tests (covered in [section 19](#19-continuous-integration)); testing everything in the whole pipeline (or package). 

As testing can have no end to it, it is recommended that you start by considering what really needs to be tested (e.g. what is of high risk?), and then to develop these tests. If in the future you decide something else really needs to be tested you can add a test for this. To make the process as efficient as possible, it may be desirable for you to create mock data (which shouldn't contain any sensitive information) that have the key features of the actual data (same columns, names etc.) but be much smaller in size to allow for easy loading and processing. As long as the data files are small, the mock data can be stored in the tests directory ([section 18](#18-unit-testing) covers how to set this directory up).

**Exercise 10**: Consider whether it could be beneficial to create a mock version of the crimedata.csv data. This dataset should retain the structure of the crimedata.csv (same number of columns, column names, data types) but be much smaller (e.g. only two or three rows).

### 11. Unit testing

Unit testing can be easily automated using the [testthat package](https://testthat.r-lib.org/). This:
* Provides a user friendly way of specifying tests that determine whether a function has run as expected (e.g. returns a particular value).
* Enables you to write messages that inform the user when running the tests (e.g. figure 1 works as expected).
* Instructs users about whether checks have passed or failed. 
* Easily integrates into your existing workflow. 

To set up your package to use testthat run the command:

        usethis::use_testthat(3)

This: 
* Adds testthat (>= 3.0.0) to the DESCRIPTION Suggests field
* Creates a 'tests' folder, inside of which is: 
  * A testthat folder, where your R test scripts should be placed;
  * The testthat.R file, which runs the R scripts in the testthat folder.

To check what percentage of the (relevant) code in your package is currently being tested, you can run the command:

        devtools::test_coverage()

To develop tests:
* Select the R script containing the function you want to test, and in the Console run: `usethis::use_test()`
  * There should generally be one R script for each function which will include all the tests you want to run on it.
  * Each test file should be named 'test_[function name].R'.
* Use the R script to: 
  * Load in any data that you want the test(s) to use.
  * Specify each test using the test_that() function.

An example R test script is [here](https://github.com/mammykins/regregrap/blob/master/tests/testthat/test_fivereg_recent.R). You'll notice this file includes:
* A single context() call which provides a brief description of its contents.
* Data being loaded for the tests to use.
* Tests being specified using the test_that() functions. Where a test_that() function involves more than one expect_ function, it will only a pass if all expect_ functions produce a TRUE result. Otherwise it will fail.
* Using the package [stringr](https://stringr.tidyverse.org/) in line with the [Section 8. Making functions work in a package](#8-making-functions-work-in-a-package) guidance.
 
An example test_that() function is as follows:

    test_that("your_function() Returns object of length five", {
     expect_equal(length(your_function(x)), 5)
    })

Notice that:
* The first argument is for providing a clear description of the test (in this example "Returns object of length five") which is displayed to the user when the test is run. It also contains the name of the function being tested. This helps with debugging if the test fails.
* Following the first argument, the test itself is specified within curly brackets {} (in this example testing that the returned object is of length 5). You can include multiple expect_ functions within the curly brackets for each test.

Some frequently used expect_ function examples are:
* expect_equal(): Checks that two outputs are equal
* expect_match(): Checks a string matches a regular expression
* expect_type(): Checks an object matches a certain type or class
* expect_output(): Checks the output has a specific structure such as a list
* expect_error(): Checks the code returns an error in specific circumstances
* expect_silent(): Checks that the code executes silently (produces no output, messages, or warnings etc.). 

For a full list of testthat expect_ and other functions see the [testthat function documentation](https://testthat.r-lib.org/reference/). There are also other functions you can use e.g. the package [vdiffr](https://cran.rstudio.com/web/packages/vdiffr/index.html) enables the testing of plots to see whether they look as expected. You can also read more about using testhat in the [R Packages testing sections](https://r-pkgs.org/testing-basics.html).
  
To run your tests, use devtools::test() or Ctrl/Cmd + Shift + T.

**Exercise 11**: Create some tests for the summarise_crimes function:  
1) Run usethis::use_testthat(3) to set up your testing structure.
2) Inside the tests/testthat folder, create an R file called test_summarise_crimes.R
3) Create a test (it's easiest to copy and amend lines 1 and 10-13 of [this test script](https://github.com/mammykins/regregrap/blob/master/tests/testthat/test_fivereg_recent.R) which contains tests for [this fivereg_recent function](https://github.com/mammykins/regregrap/blob/master/R/fivereg_recent.R)) to check whether the summarise_crimes function stops running if there is an error (e.g. using expect_silent()).
4) Run the test you have created. 
5) If time permits, you could also:
   * Add tests that the input is not a suitable dataframe and the input dataframe variables 'year' and 'crimes' aren't of class int. 
   * Try writing a test that the function will fail, just to see what happens!
   * Run devtools::test_coverage() to check what percentage of (relevant) code in your package is now being tested.
6) Lastly, commit all your changes to git and then push them to github.com.

## Releasing a package

### 12. Checking your package

Before releasing your package, you can check it by running the R CMD tests which include over 50 individual checks for common problems, and fix any problems. This can take a long time at first as there may be many error messages. To do this: 

1. Run devtools::check()  
2. Fix each problem. You should definitely fix the errors, try to eliminate the warnings (essential if submitting to CRAN), and ideally eliminate all notes. To understand more about a problem, look it up in [R Packages Automated Checking chapter](https://r-pkgs.org/r-cmd-check.html). It may also be useful to look at [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html), and at code that has passed the test (e.g. [the eesectors package](https://github.com/DCMSstats/eesectors)). 
3. Rerun 

**Exercise 12**: Run the R CMD tests on your code and resolve any error messages. Then commit all your changes to git and then push them to github.com.

### 13. Managing releases and future changes to your package

Keep the default branch of your repo for the most recent working release of your package. 

Never release changes to your package without updating the version number.

Use [semantic versioning](https://semver.org/).

[GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) are a great way to mange the versions of your package. Every time you release an updated version of your package, include a GitHub release. This way if you ever need an older version of your package it is very easy to install using the GitHub Release Tag. 

**Exercise 13**: Create a GitHub Release for your package

### 14. Installing and using your package

Congratulations, you have successfully produced a working package in R! Open a pull request and merge it to the main branch.

To install a package from a **public** GitHub repo using `renv` you just need the owner and the repo:

    renv::install("moj-analytical-services/mojrap")
  
The easiest way install a package from an **internal** or **private** GitHub repo is with the following syntax:

    renv::install("git@github.com:moj-analytical-services/mojrap.git")
    
Note: If your package has any Imports that are from internal or private repos you will need to also use this syntax in the Remotes field. [Example here.](https://github.com/moj-analytical-services/psutils/blob/main/DESCRIPTION)
    
With `renv` >= `0.15.0` you can also include `@ref` on the end of the URL where the "ref" is a branch name, commit or github tag e.g.    
    
    renv::install("git@github.com:moj-analytical-services/mojrap.git@v1.0.1")
    
**Exercise 14**: Try installing your completed package!

## Maintenance cycle

### 15. Adding a NEWS file

The NEWS markdown file functions as a changelog for your package. It must be updated every time you make changes to your package.

**Exercise 15**: Add a NEWS file to your package (`usethis::use_news_md()`). 

### 16. Continuous integration

Continuous integration is about automating software workflows. An automated workflow can be setup so that when you or someone else pushes changes to github.com, tests are run to ascertain whether there are any problems. These checks should include the unit tests you've developed and also the R CMD tests (over 50 individual checks for common problems).  

Before setting up this automation, you should have fixed any problems identified by running the R CMD tests - see [Section 12. Checking your package](#12-hecking-your-package).

To setup continuous integration using GitHub Actions: 

        usethis::use_github_actions()

This automatically puts a status badge in your README. You can provide extra security for your master branch by going to github settings, then Branches, and 'Require pull request reviews before merging' and 'Require status checks to pass before merging'.

You can read further about automating checking in [R Packages Automated Checking chapter](https://r-pkgs.org/r-cmd-check.html).

**Exercise 16**: Setup continuous integration using GitHub Actions. Lastly, commit all your changes to git and then push them to github.com.

## Annex

### A1. Excluding sensitive data 

You should not hold any sensitive data in Github.com as they may be accessed by others. To prevent you accidentally pushing any sensitive data to Github.com: 

* Don't store any sensitive data within the R Studio copy of your repository. 
* As a second line of protection, specify the names of any sensitive data files in the gitignore file so that they cannot be pushed to Github.com. To do this, open the gitignore file and add the names of the files (e.g. confidential.txt). If there's a file that's not to be ignored then you can specify it while adding an exclamation mark in front of its name e.g. '!unconfidential.txt'. 

A useful [gitignore template](https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore) has been developed by ukdatascience which is free for you to copy, use and amend.

You can also add further protection by using git hooks. These check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about this is available [here](https://github.com/ukgovdatascience/dotfiles).

Note: if you do accidentally end up pushing sensitive data or information to Github, please refer immediately to the Analytical Platform guidance on next steps [here](https://user-guidance.services.alpha.mojanalytics.xyz/information-governance.html#reporting-security-incidents).

**Exercise A1:** 
1) Place a copy of crimedata.csv into your package Rstudio folder. Amend the gitignore file to also include the code in the ukdatascience [gitignore template](https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore). After committing and pushing to github.com and refreshing your github.com repository page can you see crimedata.csv there? 
2) Now specify crimedata.csv as a file not to be ignored at the end of the gitignore file (it doesn't actually contain sensitive data). After pushing to github.com can you now see it?

### A2. Adding data in rda format

While no sensitive data should be stored in the package, it is helpful to include some non-sensitive data to make the development of functions and package testing easier. Where the data are sensitive, fake data should be generated instead.

Any data included within the package should be in the form of a minimal tidy data set, as these are easy to manipulate, model and visualise. Tidy datasets have a specific structure; each variable being a column, each observation a row, and each type of observational unit a table (so for example data relating to offenders and offender managers would be stored in separate tables). More information about tidy data can be found [here](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html). 

The best way to store the data inside the package is as an .rda file, which stores the data in a format native to R. Compared with keeping the data in a .csv file, this format:

- Is faster to restore the data to R
- Keeps R specific information encoded in the data (e.g. attributes, variable types)

To create a nice .rda file from your .csv file:

1. Create a sub-directory called 'data-raw' in your project Rstudio folder by running the command:

        usethis::use_data_raw()
        
2. Place the raw data into 'data-raw/'

3. Open the R script 'DATASET.R' in 'data-raw/' that has automatically been created by step 1. This can then be amended to read in the raw data and put them into 'data/' as an .rda object. The relevent code is:

        crimes_raw_data <- read.csv("your_package_directory_path/crimedata.csv", check.names = TRUE)
        usethis::use_data(crimes_raw_data)  
        rm(crimes_raw_data)

4. Run the R script. The folder 'data' should now have been created that contains the object crimes_raw_data.rda

Alternatively, if the data is already loaded into your local environment, to create RData you can simply use
        
        save(crimes_raw_data, file = "directory_path/crimes_raw_data.Rda")

This R script could be developed. For instance:
1. If some processing of the data is needed this could be added e.g. to make a variable of class factor
2. If the .rda file needs to be updated when the input raw dataset is changed, then add an overwrite=TRUE to the use_data function e.g. usethis::use_data(raw, overwrite = TRUE)  

To see the effect of changes made to the package, the following code needs to be run. All the changes made to the code will now be in memory: 

    devtools::load_all() 

**Exercise A2:** 
1) Make an .rda file of 'crimesdata.csv' (which is already in tidy data format) by following the above steps and give it the user friendly name 'crimes_raw_data'. 
2) Amend crimesdata_pub.Rmd so that it now runs using the .rda file by "commenting out" the read_csv line and removing the "commenting out" of the data(crimes_raw_data) line. 
3) Lastly, commit all your changes to git and then push them to github.com. 

### A3. Adding documentation about package data

Documentation can be added for datasets within a package by creating an data.R file. You can view an example [data.R file](https://github.com/DCMSstats/eesectors/blob/master/R/data.R) from the eesectors package; this makes use of the package roxygen2 to automatically turn the formatted comments into nice looking documentation.

Looking at the first 22 rows you can see a title, subtitle, the format of the data, a description of each of the variables, the source location, keywords and lastly what the data object is called (within speech marks; so if the documentation is about crimes_raw_data.rda then "crimes_raw_data").

After adding or amending documentation in an .R file, the following command can be used to generate a more complicated code (.Rd) file in the man folder, which then enables users to view nice looking documentation through the help facility:

    devtools::document()

The documentation for the data object can then be viewed in the help facility using the usual command i.e.:

    ?objectname

Documenting functions is covered in [section 15](#15-documenting-functions). There is also a separate [R Packages section about documenting datasets](https://r-pkgs.org/data.html#sec-documenting-data) which you may want to look at. 

**Exercise A3:** Create an data.R file in your R folder and paste in the first 22 rows from the example eesectors package [data.R file](https://github.com/DCMSstats/eesectors/blob/master/R/data.R). Amend the contents, generate nice looking documentation, and then take a look at it (using the help facility). Lastly, commit all your changes to git and then push them to github.com. 






