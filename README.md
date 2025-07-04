# Developing R packages

## Pre-course requirements
This training is designed as an introduction to making and developing R packages which are 
important to reproducible ways of working. You should first have completed the following training 
sessions (or reached an equivalent standard to having done so):

- [Introduction to using R on the Analytical Platform](https://github.com/moj-analytical-services/intro_using_r_on_ap)
- [Introduction to R](https://github.com/moj-analytical-services/IntroRTraining)
- [Writing functions in R](https://github.com/moj-analytical-services/writing_functions_in_r)
- [Introduction to Git and GitHub](https://github.com/moj-analytical-services/intro_to_github_training)

You must also have completed steps 1 to 4 and 6 of the
[MoJ Analytical Platform quickstart guide](https://user-guidance.analytical-platform.service.justice.gov.uk/get-started.html#get-started), 
making sure you can access RStudio from the control panel. If you have any issues, please post them in the 
appropriate Slack channel (either [#ask-operations-engineering](https://moj.enterprise.slack.com/archives/C01BUKJSZD4) or [#intro_r](https://asdslack.slack.com/archives/CGKSJV9HN)). 

Using two screens (e.g. your laptop plus a monitor) during the training session might be useful to enable you to watch the session on one and code on the other.

Recordings of these sessions can be viewed via links provided in the [Analytical Platform and related tools training section on R training](https://moj-analytical-services.github.io/ap-tools-training/ITG.html#r-training). If you have any access problems please contact <aidan.mews@justice.gov.uk>.


## Contents

* [Section 1 - Introduction](#section-1---introduction)
* [Section 2 - Package scope and naming](#section-2---package-scope-and-naming)
    + [The scope](#the-scope)
    + [The name](#the-name)
* [Section 3 - Package structure](#section-3---package-structure)
* [Section 4 - Create the package](#section-4---create-the-package)
    + [Essential development practice for R packages](#essential-development-practice-for-r-packages)
    + [Tools to help with package development](#tools-to-help-with-package-development)
* [Section 5 - Copyright and licencing](#section-5---copyright-and-licencing)
* [Section 6 - Package metadata](#section-6---package-metadata)
    + [Authors](#authors)
    + [Semantic Versioning](#semantic-versioning)
    + [Dependency management](#dependency-management)
* [Section 7 - Checking your package](#section-7---checking-your-package)
* [Section 8 - Adding functions](#section-8---adding-functions)
    + [is Friday function](#is-friday-function)
    + [filter by species function](#filter-by-species-function)
* [Section 9 - Making functions work in a package](#section-9---making-functions-work-in-a-package)
* [Section 10 - Documenting functions](#section-10---documenting-functions)
* [Section 11 - Testing your code](#section-11---testing-your-code)
    + [The structure of a test](#the-structure-of-a-test)
    + [Tests for the filter by species function](#tests-for-the-filter-by-species-function)
    + [Test coverage](#test-coverage)
    + [Tests for the is Friday function](#tests-for-the-is-friday-function)
* [Section 12 - Add a README](#section-12---add-a-readme)
* [Section 13 - Add a NEWS file](#section-13---add-a-news-file)
* [Section 14 - Managing releases of your package](#section-14---managing-releases-of-your-package)
* [Section 15 - Installing and using your package](#section-15---installing-and-using-your-package)
* [Section 16 - Maintenance cycle](#section-16---maintenance-cycle)
* [Annex](#annex)
    + [A1 Continuous integration](#a1-continuous-integration)
    + [A2 Installing packages on the Analytical Platform prior to R 4.4.0](#a2-installing-packages-on-the-analytical-platform-prior-to-r-440)


## Section 1 - Introduction

This training is based on the book [R Packages by Hadley Wickham and Jennifer Bryan](https://r-pkgs.org/). The goal of it is 
to teach you how to make and develop packages. R packages are not difficult to make and have several 
benefits:

* Packages have a standard structure and are easy to install. 
* Documentation is included with the code.
* Packages facilitate the integration of unit testing.
* Code changes can be clearly tracked via package versioning.

These benefits together improve the reliability, reusability and sharability of code, and give you 
the confidence to update it without the fear of unknowingly breaking something.

This training is designed with exercises to enable you to develop a package. Your example package
will include some functions that we will provide.


## Section 2 - Package scope and naming

Before you start developing a package there are two questions to consider "what will your package 
contain?" (the scope) and "what will you call it?" (the name).


### The scope

You could put every function you ever write into one package but it is likely that this would 
quickly become difficult to maintain especially if this resulted in a large number of dependencies.
Instead it is better to group your functions into thematically similar activities. For example the
{forcats} package contains functions for working with categorical data and factors and the {stringr}
package contains functions for working with strings and regular expressions.

Some packages may contain generalized functions (on a particular theme) that have a broad spectrum 
of applications e.g. [the {psutils} R package ("prisons stats utilities")](https://github.com/moj-analytical-services/psutils). Others may 
contain very specialized functions that are only used as part of one process e.g. 
[the {pssf} R package ("prisons stats specialised functions")](https://github.com/moj-analytical-services/pssf).

It is also worth considering whether your functions might fit within an existing package rather than starting a new one.

### The name

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short 
- be unique (for Google searches)
- be made of ASCII letters, numbers and "." only (it must start with a letter)
- not use a mixture of upper and lower case letters (this makes the name hard to remember)
- if possible be clear about what the package does i.e. reflect the scope
- memorable (both {psutils} and {pssf} are terrible names on this account!)

You can read more in the [R Packages section Name your package](https://r-pkgs.org/workflow101.html#name-your-package)


##### Exercises
* **2.1** Decide what name to call your package (something like your initials or name combined with "demo",
"eg", or "toy" might be appropriate for this training). Make sure you respect the constraints on permitted characters!
* **2.2** [Create a new github repository (Analytical Platform User Guidance)](https://user-guidance.analytical-platform.service.justice.gov.uk/github/create-project.html#create-a-new-project-in-github), giving it your chosen name and "internal" visibility. Add a .gitignore file (using the "R" template) but not a license or README at this stage.
* **2.3** [Clone the repo (Analytical Platform User Guidance)](https://user-guidance.analytical-platform.service.justice.gov.uk/github/rstudio-git.html#step-1-navigate-to-your-platform-r-studio-and-make-a-copy-of-the-github-project-in-your-r-studio) as an RStudio project.


## Section 3 - Package structure
R packages have a standard structure. The following components must be included (either because 
they are essential package components or because they are essential parts of the development and 
maintenance process).

- **R/** - A folder where functions are saved (This is for package code only if you are making notes during the training don't save them here!).
- **man/** - A folder for documentation.
- **tests/** - A folder for {testthat} infrastructure and testing scrips.
- **.Rbuildignore** - A file that [allows certain paths to be ignored when the package is built (R Packages book)](https://r-pkgs.org/structure.html#sec-rbuildignore).
- **DESCRIPTION** - A file containing package metadata.
- **NAMESPACE** - A file containing exported and imported variable names.
- **LICENCE and/or LICENSE.md** - A file or files with information about how the code can be used.
- **NEWS** - A file that acts as a changelog so returning users can quickly see what has changed between different version of the package.
- **README** - A file or files that covers how to install the package and a guide for first time users.


Some packages may have [other components (R Packages book)](https://r-pkgs.org/misc.html), a few common ones that you may want to use are listed below:

* **inst/** - A folder for "other files" e.g. markdown templates.
* **data/** - A folder for data (**nothing sensitive!**) in .rda format that are available as part of the package e.g. for demonstrating functionality. Each data set should be documented in a similar way to functions. 
* **data-raw/** - A folder for preserving the creation history of your .rda file (must be added to the .Rbuildignore). This could also contain CSV versions of small data files used in testing code.

##### Exercises 
* **3.1** Take a look at the structure of a github repo which contains an R package e.g. [{stringr}](https://github.com/tidyverse/stringr) or [{dplyr}](https://github.com/tidyverse/dplyr) and see if you can recognise the structure and elements described above.

## Section 4 - Create the package

### Essential development practice for R packages

The default branch of an R package GitHub repo must be reserved for working releases of the package. 
Always make your changes on a different branch then merge to the default branch for each release. 
You should also [add protections to your `main` branch (GitHub Docs article)](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule#creating-a-branch-protection-rule) to shield it from accidental pushes. (We will skip this step in the training for speed but it is very important for production code).

##### Exercises
* **4.1** Create a new git branch called `dev` in RStudio where we will begin building the package.

### Tools to help with package development

There are several R packages that contain tools to help ensure your package is set up in the correct
format and aid development by automating common tasks. The two we will be using today are 
[{devtools}](https://devtools.r-lib.org/) and [{usethis}](https://usethis.r-lib.org/).

##### Exercises 
* **4.2** Using `install.packages()`, install the {devtools} and {usethis} packages. If you are using R < 4.4.0 on the AP please review [appendix A2](#a2-installing-packages-on-the-analytical-platform-prior-to-r-440) first.

The following {usethis} function will structure your current working directory as an R package 
(you will need to overwrite what is already there when prompted):
```R
usethis::create_package(getwd())
```
This will create several of the files and folders discussed at the start of the package structure 
section.

##### Exercises 
* **4.3** Set up you project as a folder using `usethis::create_package(getwd())`. You will be asked if you want to overwrite the existing .Rproj file. You do!
* **4.4** Which standard package elements have been created?


## Section 5 - Copyright and licencing

Licencing code is essential as it sets out how others can use it. You can [read more about licencing (R Packages book)](https://r-pkgs.org/license.html). The work-product of civil servants falls under 
[Crown copyright (archived article)](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and usually requires an Open Government Licence but for open source software we have the [option
to use other open source licences (archived article)](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/open-government-licence/open-software-licences/). The 
[MIT licence (open source initiative article)](https://opensource.org/license/mit/) is the [MoJ preferred choice (Analytical Platform User Guidance)](https://user-guidance.analytical-platform.service.justice.gov.uk/github/create-project.html#licence) and can be added to your package using:

```R
usethis::use_mit_license("Crown Copyright (Ministry of Justice)")
```
This will add two text files to the top level of your project, `LICENCE` and `LICENCE.md`. It will also update the relevant section in the DESCRIPTION file and update the .buildignore file.

##### Exercises
* **5.1** Add an MIT licence to your package


## Section 6 - Package metadata

The [DESCRIPTION file (R Packages book)](https://r-pkgs.org/description.html#the-description-file) contains important 
metadata about the package; it is a text file that you can open and edit in RStudio. You can view as an example [the amended psutils package DESCRIPTION file](https://github.com/moj-analytical-services/psutils/blob/main/DESCRIPTION). The formatting 
is important. Each line consists of a field name and a value, separated by a colon. 
Where values span multiple lines, they need to be indented. In particular:

- **Title:** - a one line description of the package - keep this short, with suitable use of capitals and less than 65 characters.
- **Version:** - the package version. This must be amended when you update the package. Use Semantic Versioning (see below)
- **Authors@R:** - the package authors and their roles (more info below)
- **Description:** - a one paragraph summary of the package
- **License:** - licencing information (this will have been automatically updated when you added the licence with {usethis}).
- **Imports:** - all the other packages that your package uses for basic functionality. You can specify a minimum or maximum version in brackets after the name. 
- **Suggests:** - packages that are not required for basic functionality but allow enhanced features such as vignettes or are useful during package development.
- **Remotes:** - if your package depends on another one that is not on CRAN, this is where you specify how to find it.
- **Depends:** - this is where you list a minimum version of R if you are aware of one. For example if you are using the R native pipe (`|>`) in your package you would need to specify R (>= 4.1.0). 

##### Exercises
* **6.1** Add a package title to the relevant field in the DESCRIPTION file.
* **6.2** Add a package description to the relevant field in the DESCRIPTION file.


### Authors

Package authors are supplied as a vector of persons i.e. `c(person(...), person(...))`. In addition 
to a `given` name, `family` name, and an `email`, each person should have a `role` specified. More 
information can be found by running `?person` but the four most common roles are detailed below 
(multiple roles should be combined with `c()`):

- aut: authors; those who have made significant contributions to the package.
- ctb: contributors; those who have made smaller contributions, like patches.
- cre: the package maintainer; the person you should contact if you have a problem.
- cph: copyright holder; most likely `person("Crown Copyright (Ministry of Justice)", role = "cph")` 

##### Exercises
* **6.3** Add yourself to the DESCRIPTION file as the author and maintainer of the package. 
* **6.4** Add the relevant copyright holder.

### Semantic Versioning

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

##### Exercises
* **6.5** Amend the description file to set the package version number to "0.1.0".

### Dependency management

The Imports and Suggests fields are used for dependency management for your package/ development 
processes. You want to be as permissive as possible specifying minimum or maximum versions of 
packages listed in Imports and Suggests to increase the compatibility of your package with others. 
If you know that your code relies on functionality added in a particular version of a package you 
must specify the minimum version otherwise don't specify a minimum version.

Any package that your code relied upon for core functionality should be listed in the "Imports" 
section. The "Suggests" section is for packages that are used in the development process or give 
extra optional functionality.

There is a tool in {usethis} for adding packages to the description file. It will check if the 
package is installed before adding it so is useful for catching spelling mistakes!

By default, packages are added as Imports e.g. to add {lubridate} as an import: 
`usethis::use_package("lubridate")`. You can use the `type` argument to add them to Suggests instead e.g.
to add {devtools} as a suggested package: `usethis::use_package("devtools", type = "Suggests")`.

##### Exercises
* **6.6** Add {devtools} and {usethis} to the suggests field.
* **6.7** We will be using the R native pipe so set the minimum version of R as >= 4.1.0 in the depends field: `usethis::use_package("R", type = "Depends", min_version = "4.1.0")`


## Section 7 - Checking your package
Packages require that the right files and the right information are in the right places. A small 
mistake can prevent the package from functioning as intended. Many package features can be checked 
using the function `devtools::check()`. It runs a series of checks that examine (among other things) 
package structure, metadata, code structure, and documentation. You can read more about [the 
individual checks (R Packages book)](https://r-pkgs.org/R-CMD-check.html). Any issues that are 
identified will be labeled as "errors", "warnings" or "notes". Errors and warnings must be fixed. 
Occasionally it is acceptable to leave a "note" but usually these should be fixed too.

##### Exercises 
* **7.1** Run `devtools::check()` - there should be no errors, warnings or notes.
* **7.2** If all the checks pass, commit (to the git version history) and push (to GitHub.com) the DESCRIPTION file.
* **7.3** If all the checks pass, commit and push both licence files.
* **7.4** If all the checks pass, commit and push any changes to the .Rbuildignore, .gitignore and .Rproj files.

## Section 8 - Adding functions

As you can take the [Writing functions in R training course (GitHub repository)](https://github.com/moj-analytical-services/writing_functions_in_r), 
we will skip function development in this course. 

We are going to include two functions in our example package, one that checks if a date is a Friday and another that 
filters a data frame by a column called `Species` for rows that match a specific target value.

In a package, functions must be saved in .R files in the R/ folder. You can have multiple functions 
in a single script (see [suggestions about how to organise your functions (R Packages book)](https://r-pkgs.org/code.html#sec-code-organising)) 
but we will use one function per file for this exercise.

### is Friday function
```R
is_friday <- function(date) {

  if (!inherits(date, "Date")) {
    date <- lubridate::ymd(date)
  }

  lubridate::wday(date) == 6

}
```
### filter by species function
```R
filter_by_species <- function(df, target_species) {

  df |>
    dplyr::filter(.data$Species == target_species)

}
```

##### Exercises
* **8.1** Copy each function to a new R script and save it in the R/ folder. The function name is probably
an appropriate name for each file.
* **8.2** Run `devtools::check()` - You will get a warning about undeclared imports and a note about an "undefined global function or variable". We will deal with these in the next section.


## Section 9 - Making functions work in a package

While the format of code inside a package is very similar to "normal R code", it is vital to 
properly reference functions that you are using from other packages. You must never use
`library()`, `require()` or `source()` calls inside a package; instead you should use 
`package::function()` syntax. You can read more about [properly referencing functions (R Packages book)](https://r-pkgs.org/code.html#sec-code-r-landscape). 
In some instances it is better to import a function from the relevant namespace (more on this later).

Because packages like {dplyr} use "tidy evaluation" we need to make some changes to the code when
including it within packages. To find out more, read the 
[Programming with dplyr article](https://dplyr.tidyverse.org/articles/programming.html). In the "filter by species" function we get 
around the use of unquoted column names by including the `.data` "pronoun". For example, outside of
a package context `iris |> dplyr::filter(Species == "Setosa")` is valid syntax and `Species` will
be interpreted as a string (the name of a column in the data frame `iris`) via "tidy evaluation".
In a package context however, it will be interpreted as an object name (and probably the name of an 
object without a definition). This will cause the checks on the package to fail.

##### Exercises
* **9.1** Have a look at the use of `package::function()` syntax in the functions.
* **9.2** Have a look at the use of the `.data` pronoun in the filter by species function.
* **9.3** Add {dplyr} and {lubridate} to the imports field of the DESCRIPTION file (install the packages if prompted to).
* **9.4** Run `devtools::check()` - you will still be getting the note about `.data` - we will deal with this in the next section.
* **9.5** Commit and push the changes to the DESCRIPTION file.

## Section 10 - Documenting functions

Documentation is really important so users know how to use the package, and package managers and 
developers can quickly get up to speed. It should therefore be embedded within the package in such 
a way that it is easily available to all users. 

We can include "roxygen comments" with our functions to provide documentation that can be 
automatically knitted into help files. Roxygen comments are denoted by hash and a single quotation 
mark followed by a space `#' `. Comments can then be labeled with a tag which is a string starting
with @ e.g. `@title` would be the tag for the help file's title. You can add a roxygen comment skeleton 
to a function script with Ctrl + Alt + Shift + R (make sure your cursor is on the first line of or 
above the function).

A set of roxygen comments for the is Friday function is given below.

```
#' @title Is Friday?
#' @description Check which elements in a vector of dates are Fridays.
#' @param date A Date class object or a string in the form "yyyymmdd".
#' @returns A boolean vector the same length as `date`.
#' @export
#' @examples
#' # TRUE
#' is_friday("2025-03-28")
#' "2025-03-28" |> lubridate::ymd() |> is_friday()
#' 
#' # FALSE
#' is_friday("2025-03-24")
#' 
#' # TRUE, FALSE
#' c("2025-03-28", "2025-03-24") |> is_friday()
```

As a minimum, for each function exported for users of your package you should include:
* `@title` - the title for the help file
* `@description` - a description of what your function does
* `@returns` - a summary of your function output (general properties such as type or structure)
* `@param` - One for each argument in your function (Note that the name of the parameter comes after the tag followed by another space before the text describing the parameter)
* `@examples` - Sufficient examples for users to get started with your function (most people will probably look at the examples before reading the text!)

There is a special tag `@export` which indicates that the function should be added to the NAMESPACE
of your package. This means it will be accessible to users of your package and using the `@export` tag
will also trigger the generation of a help file. Any functions that are for internal package use only
should not be tagged with `@export`.

There is another special tag `@importFrom` that can be used to import functions and methods etc from
the NAMESPACE of other packages. The use of this should be reserved for things like operators and 
functions that are always nested inside other functions (for example `aes()` from {ggplot2}) and 
pronouns where the use of `::` syntax is either invalid or makes the code hard to read.

Once we have added our roxygen comments we can use `devtools::document()` to generate the the help 
files. These will be saved in the `man/` folder. You will also see that the function is now listed 
in the NAMESPACE file. (Note that `devtools::document()` is also run as part of 
`devtools::check())`.

##### Exercises
* **10.1** Copy the roxygen comment chunk above and paste it in the relevant script above the is Friday function.
* **10.2** Run `devtools::document()` -  you will now see a file in `man/` and a change to the NAMESPACE
* **10.3** Run `?is_friday` to view the help file generated from the roxygen comments (you may need to run `devtools::load_all()` first).
* **10.4** Add roxygen comments for the filter by species function (hint: use the `iris` dataset in the example)
* **10.5** Run `devtools::document()` - you will see another file in `man/` and other function added to the NAMESPACE
* **10.6** Add the following as as additional roxygen comment to the filter by species file: `#' @importFrom dplyr .data`
* **10.7** Run `devtools::document()` - you will see a new line in your NAMESPACE file that makes dplyr's `.data` available for use in your package.
* **10.8** Run `devtools::check()`
* **10.9** When all checks pass commit and push the R scripts containing the functions, the `man/` files and the NAMESPACE file.



## Section 11 - Testing your code

We now have a separate training course ([link to code testing training repo](https://github.com/moj-analytical-services/codetestingtraining)) 
that gives a more thorough introduction to testing code but we will cover the basics here.

You have written (in this case been given) some code but how do you know that it is actually doing 
what you intended? You might use `devtools::load_all()` to load your package and then try the 
functions to see if they give the expected output. This works but every time you need to test your 
functions (e.g. if any changes are made to your code base or if there are changes in your 
dependencies) you will need to re-create the inputs to the function and re-write the code. This 
quickly makes testing a very time consuming process. 

We can instead formalize this testing process (and automate the running of it) using the [{testthat}
R package](https://testthat.r-lib.org/index.html). When we run the function `usethis::use_testthat()`
it will:
* Add `testthat (>= 3.0.0)` to the Suggests field in the DESCRIPTION file.
* Creates a `tests/` folder, inside of which is a `testthat/` folder, where your R test scripts should be placed, and a `testthat.R` which helps in automating the testing.

##### Exercises 
* **11.1** Run `usethis::use_testthat()` to set up the testing infrastructure.
* **11.2** Navigate to the script containing the filter by species function and in the console run: `usethis::use_test()`. This will open a new script which is saved in `tests/testhat/`. The script will have the same name as the function script but will have a `test-` prefix. An example test will be given.

### The structure of a test

The {testthat} tests contain two elements, the name of the test and one or more expectations. A 
test will fail if at least one expectation is not met or if there is an unexpected error.

You can have multiple tests for a single function so the name of the test is important for 
identifying which test failed (when it fails). The test name should therefore contain information 
about what you are testing i.e. the function name and what specific behavior you are testing. 
Each test should always have a unique name within a package to avoid wasting time debugging the 
wrong test! 

[Expectations ({testthat} reference)](https://testthat.r-lib.org/reference/index.html#expectations) are a series of 
functions that check for the presence or absence of specific values or properties in function 
outputs or their side effects.

##### Exercises 
* **11.3** Have a look at the {testthat} reference to see some of the pre-built expectations

### Tests for the filter by species function

A test (with four expectations) for the filter specis function is given below. The first three
expectations check various properites of the function output when used with the `iris` data
frame. The fourth expectation checks that we get an error if we supply something other than
a data frame to the first argument.

```R
test_that("filter_by_species works", {
  
  filter_by_species(iris, "setosa") |> expect_s3_class("data.frame")
  filter_by_species(iris, "versicolor") |> nrow() |> expect_equal(50)
  filter_by_species(iris, "virginica") |> ncol() |> expect_equal(5)
  
  filter_by_species("foo", "bar") |> expect_error()
  
})
```
##### Exercises 
* **11.4** Copy the code above to the test file for the filter by species function.
* **11.5** Save the test file and run `devtools::load_all()`.
* **11.6** Run `devtools::test()` - you will get feedback as the tests run about how many have failed, resulted in a warning, or passed.

### Test coverage

Test coverage is a metric that can be useful in assessing the adequacy of tests. The {covr} package 
can be used to examine test coverage. It builds the package and runs the tests in a modified 
environment counting how many times each line of package code is run by the tests. 



##### Exercises 
* **11.7** Run `devtools::test_coverage()` and inspect the output - the first time you run this you might be prompted to install the packages {covr} and {DT}.
* **11.8** Add {covr} and {DT} to the Suggests field in your DESCRIPTION file.

### Tests for the is Friday function

A test (with one expectation) for the is Friday function is given below.
```R
test_that("is_friday works", {
  
  lubridate::ymd("2025-03-28") |> is_friday() |> expect_true()
  
})
```

##### Exercises
* **11.9** Create a testing file for the is Friday function and add the test.
* **11.10** Run `devtools::load_all()` and `devtools::test()`.
* **11.11** If all the tests pass, run `devtools::test_coverage()` - why do we not have 100% code coverage?

Test coverage is particularly useful where you have `if()` statements in your code. It helps you 
ensure that all the various conditions that can arise have been covered. In our single expectation
for the is Friday function, the `if()` statement evaluates as `FALSE` so the "if block" is not run. The
if block could contain a bug that would not be caught by our current tests.

##### Exercises
* **11.12** Add another expectation to the is Friday test that will cause the if block to run. (Use a string in the form "yyyymmdd" as the input).
* **11.13** Run `devtools::load_all()` and `devtools::test()`.
* **11.14** If all the tests pass, run `devtools::test_coverage()` and inspect the output
* **11.15** Now run `devtools::check()` - this will also run the tests alongside the other checks.
* **11.16** If all the checks pass, commit and push the testing files and the DESCRIPTION file.


## Section 12 - Add a README

The README acts as a "quick-start guide" for users of your package. It should include:
* Instructions for installing the package.
* A brief overview of what the package does and how you can get started using it.
* If the package is intended for open collaboration, instructions for how people can get involved.

You can use a simple markdown README or dynamically generate one using R Markdown which 
enables the ability to embed code chunks and several other extensions useful for writing 
technical reports. The latter may be preferable if you want to demonstrate what some of 
your code does. You can add a README with either `usethis::use_readme_md()` or 
`usethis::use_readme_rmd()` depending on the type you want.

##### Exercises
* **12.1** Add a markdown README to your package
* **12.2** Update the install instructions to the following: `renv::install("git@github.com:moj-analytical-services/PACKAGE.git")` (you will need to replace "PACKAGE" with the name of your package). You can also remove the line about installing a "development" version.
* **12.3** Replace the example with an example from the is friday function.
* **12.4** Update the overview of what your package does.
* **12.5** Run `devtools::check()` - if all the checks pass commit and push the README.

## Section 13 - Add a NEWS file

The NEWS markdown file functions as a change-log for your package. It must be updated every time 
you make changes to your package.

##### Exercises
* **13.1** Have a look at the [NEWS file for {dplyr} R package](https://github.com/tidyverse/dplyr/blob/main/NEWS.md) - when were inequality joins introduced?
* **13.2** Add a NEWS file to your package (`usethis::use_news_md()`). 
* **13.3** We will not be submitting this package to CRAN so update the bullet point to something like "initial release".
* **13.4** Run `devtools::check()` - if all the checks pass commit and push the NEWS file.

## Section 14 - Managing releases of your package

Congratulations, you have successfully produced a working package in R! Open a pull request and 
merge it to the `main` branch.

[GitHub Releases (GitHub Docs article)](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) 
are a great way to manage the versions of your package. Every time you release an updated version of 
your package, include a GitHub release. This way if you ever need an older version of your package 
it is very easy to install using the GitHub Release Tag. 

##### Exercises 
* **14.1** Open a pull request and merge the `dev` branch into `main`.
* **14.2** Click on the "Releases" section on the Code tab of the GitHub repo for your package.
* **14.3** Click on "Draft a new release"
* **14.4** Fill in the release title with the Semantic Version number of your package
* **14.5** Add a description of the release (the section of your NEWS file pertaining to this version of the package might be appropriate)
* **14.6** Click on "Choose a tag"
* **14.7** The tag should be the Semantic version number prepended with a lowercase "v" e.g. for version `0.1.0` the tag will be `v0.1.0`. After
    typing the tag you will need to click on "Create new tag: ... on publish".
* **14.8** Click on the "Publish release" button

## Section 15 - Installing and using your package

To install a package from a **public** GitHub repo using `renv` you just need the owner and the 
repo:

```R
renv::install("moj-analytical-services/mojchart")
```
  
The easiest way install a package from an **internal** or **private** GitHub repo is with the 
following (SSH URL) syntax:

```R
renv::install("git@github.com:moj-analytical-services/mojchart.git")
```    
    
Note: If your package has any Imports that are from internal or private repos you will need to 
also use the SSH URL syntax in the Remotes field. For example the [{psutils} package DESCRIPTION FILE includes {verify} as an
import](https://github.com/moj-analytical-services/psutils/blob/main/DESCRIPTION#L41) and as another internal package, 
the [{verify} SSH URL syntax is specified in the {psutils} package DESCRIPTION FILE Remotes field](https://github.com/moj-analytical-services/psutils/blob/main/DESCRIPTION#L51). 
    
With `renv` >= `0.15.0` you can also include `@ref` on the end of the URL where the "ref" is a 
branch name, commit or github tag e.g.    

```R
renv::install("git@github.com:moj-analytical-services/verify.git@v0.0.19")
```
    
##### Exercises
* **15.1** Try installing your completed package in a different repo
* **15.2** Have a look at the help file for the filter by species function
* **15.3** Run the examples from the is Friday function help


## Section 16 - Maintenance cycle

You have released your package and have received some feedback from a user - "I want a function to 
test if a date is a Monday".

```R
is_monday <- function(date) {
  
  if (!inherits(date, "Date")) {
    date <- lubridate::ymd(date)
  }
  
  lubridate::wday(date) == 2
  
}
```

##### Exercises
* **16.1** Switch back to the RStudio project where you are developing your package.
* **16.2** Ensure you are on the `dev` branch.
* **16.3** Install {renv} and run `renv::install()`. This function has special behavior in the presence of a 
  DESCRIPTION file - it will install the packages listed there. This behaviour is bugged in some versions of
  {renv}. If you get an error message, run `renv::install("renv@0.15.4")`, restart R (Ctrl+Shift+F10) then try again.
* **16.4** Run `devtools::check()`. This is to see if any changes in your packages dependencies have broken
  anything (the effectiveness of this will depend on the quality of your code and testing). Address
  any dependency related issues before making further changes.
* **16.5** Add the is monday function to your package. Don't forget to document it!
* **16.6** Run `devtools::load_all()` and `devtools::check()`. Fix any issues.
* **16.7** Add tests for the is monday function.
* **16.8** Run `devtools::load_all()` and `devtools::test()` and `devtools::test_coverage()`. Fix any issues.
* **16.9** Update the version number in the DESCRIPTION file
* **16.10** Update the NEWS file
* **16.11** Run `devtools::check()`
* **16.12** When all tests pass, commit and push the changes
* **16.13** Open a pull request, merge to `main` and generate a new GitHub release


## Annex

### A1 Continuous integration

Continuous integration is about automating software workflows. An automated workflow can be 
setup so that when you or someone else pushes changes to github.com, tests are run to 
ascertain whether there are any problems. These checks should include the unit tests you've 
developed and also the R CMD tests (over 50 individual checks for common problems) carried 
out when you run `devtools::check()`.

Before setting up this automation, you should have fixed any problems identified by running 
the R CMD tests - see [Section 7 - Checking your package](#section-7---checking-your-package).

To setup continuous integration using GitHub Actions: 

```R
usethis::use_github_actions()
```

This automatically puts a status badge in your README. 

You can read further about automating checking in [R Packages Automated Checking chapter](https://r-pkgs.org/r-cmd-check.html).

### A2 Installing packages on the Analytical Platform prior to R 4.4.0

Most R packages you install come from CRAN (The Comprehensive R Archive Network) 
which stores them on a series of mirrored servers that act as package repositories. 
Prior to R version 4.4.0 the Analytical Platform is set up to use a fixed R 
package repository by default. Depending on the version of R on the Analytical 
Platform you are using, this may be fairly old. Run `options("repos")` in the 
console and look at the date at the end to see which version you are using. To 
access the latest versions of packages you can use the following to update 
where you install from (this will reset when R is restarted).

```R
options(repos = "https://packagemanager.rstudio.com/all/__linux__/focal/latest")
```
