# Developing R packages & RAP ways of working
This training is designed as an introduction to both making and developing R packages and to integrating the many components of RAP (Reproducible Analytical Pipelines) ways of working. You should first have completed the following training sessions (or reached an equivalent standard to having done so):

- [Introduction to R](https://github.com/moj-analytical-services/IntroRTraining)
- [R Charting](https://github.com/moj-analytical-services/ggplotTraining)
- [Introduction to R Markdown](https://github.com/moj-analytical-services/rmarkdown_training)
- [Writing functions in R](https://github.com/moj-analytical-services/writing_functions_in_r)

It would also be helpful if you could first make sure you have installed the packages devtools and usethis. If the versions you have are lower than 2.4.2 (devtools) and 2.0.0 (usethis) please upgrade (update) them.

Recordings of these sessions can be viewed on the [MS Stream R Training channel](https://web.microsoftstream.com/channel/aa3cda5d-99d6-4e9d-ac5e-6548dd55f52a). If you have any access problems please contact <aidan.mews@justice.gov.uk> or <georgina.eaton4@justice.gov.uk>.

## Contents

* [1. Introduction](#1-introduction)
* [2. Choose a name](#2-choose-a-name)
* [3. Create github repository](#3-create-github-repository)
* [4. Make a copy of the project in R Studio](#4-make-a-copy-of-the-project-in-R-Studio)
* [5. Create the package](#5-create-the-package)
* [6. Add R and Rmarkdown code](#6-add-R-and-Rmarkdown-code)
* [7. Making functions work in a package](#7-making-functions-work-in-a-package)
* [8. Amend the DESCRIPTION file](#8-amend-the-DESCRIPTION-file)
* [9. Excluding sensitive data](#9-excluding-sensitive-data)
* [10. Adding data in rda format](#10-adding-data-in-rda-format)
* [11. Adding documentation about package data](#11-adding-documentation-about-package-data)
* [12. Automating quality assurance checks on input data sets](#12-automating-quality-assurance-checks-on-input-data-sets)
* [13. Developing functions](#13-developing-functions)
* [14. Documenting functions](#14-documenting-functions)
* [15. Using the condition system for functions](#15-using-the-condition-system-for-functions)
* [16. Testing your code](#16-testing-your-code)
* [17. Unit testing](#17-unit-testing)
* [18. Continuous integration](#18-continuous-integration)
* [19. Dependency management](#19-dependency-management)
* [20. Installing and using your package](#20-installing-and-using-your-package)

## 1. Introduction

This training is based on Matthew Gregory's free online course [Reproducible Analytical Pipelines (RAP) using R](https://www.udemy.com/reproducible-analytical-pipelines/) and Hadley Wickham's book [R Packages](http://r-pkgs.had.co.nz/)

The goal of this training is two fold: 

- To enable you to integrate the many components of RAP ways of working into your projects. Even if you are coding a one-off product rather than automating a task, integrating RAP ways of working still have large benefits. They increase transparency and trust in statistics, quality and quality management, and accessibility of code and data - see pages 11-16 of the [OSR Review - RAP: Overcoming barriers to adoption](https://osr.statisticsauthority.gov.uk/wp-content/uploads/2021/03/Reproducible-Analytical-Pipelines-Overcoming-barriers-to-adoption-1.pdf) 
- To teach you how to make and develop packages. These are not difficult to make but enable others to easily use your code and have time saving conventions that you can follow (e.g. to organise code). The latter can be very beneficial to use in projects even if you are not making packages. 
 
Hadley Wickham's [R Packages introduction](https://r-pkgs.org/introduction.html) states: "In R, the fundamental unit of shareable code is the package. A package bundles together code, data, documentation, and tests, and is easy to share with others." The directory structure of an R package is typically as follows: 

- R code is in 'R' (this is required); 
- documentation is in 'man' (this is also required); 
- data are in 'data'; 
- tests are in 'tests'; 
- dependency management may be in the associated directory e.g. 'renv' if using renv; and 
- templates on how to use the package are in 'vignettes'.

This training is designed with exercises in each section to enable you to develop a package and integrate RAP ways of working for the minimal statistical bulletin created as part of the [Introduction to Rmarkdown](https://github.com/moj-analytical-services/rmarkdown_training). The files to do this are all included in this repository. You can then apply the same skills to your real life publications.

**Exercise 1:** Take a look at the structure of a github repo which contains [an R package](https://github.com/DCMSstats/eesectors) and see if you can recognise the structure described above.

## 2. Choose a name

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short; 
- be unique (for google searches); 
- include either upper or lower case characters but not a mixture of them; 
- be clear about what the package does e.g. if a training exercise example, consider putting 'eg' in the name. 

You can read more in the [R Packages section Name your package](https://r-pkgs.org/workflow101.html#name-your-package).

As we're going to develop a package for the minimal statistical bulletin created as part of the [Introduction to R Markdown](https://github.com/moj-analytical-services/rmarkdown_training), choose a name such as "egnamerap" where the eg is because it's a training exercise, the name is your first name (if your first name is very unique) and the rap because you are going to RAP a minimal statistical bulletin.

**Exercise 2:** Decide what name to call your package

## 3. Create github repository 

To utilise the benefits of version control and to enable other people to download and use your package, it should be created inside a github repository. [This guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/create-project.html#create-a-new-project-in-github) shows you how to do this.

**Exercise 3:** Create a new github repository, following the above guidance. Give the repository it the same name as you've decided to call your package (see [section 2](#2-choose-a-name)) and a suitable description (e.g. 'My RAP training exercise'). Add a README file and a .gitignore file but not a license at this stage.

## 4. Make a copy of the project in R Studio

To enable you to make changes to your project using R Studio you can make a copy of your repository in your personal R Studio workspace. Guidance to do this is available [here](https://user-guidance.services.alpha.mojanalytics.xyz/github/rstudio-git.html#step-1-navigate-to-your-platform-r-studio-and-make-a-copy-of-the-github-project-in-your-r-studio). As github.com has changed slightly since this guidance was made, the green button 'Clone or download' is now called 'Code'.

**Exercise 4:** Follow Step 1 of the guidance to make a copy of your project in R Studio.

## 5. Create the package 

A repository can easily be converted into a package using R Studio. Assuming you have already installed the package usethis ([see the opening paragraph of this README](#developing-r-packages--rap-ways-of-working)), run the following command and select the option to overwrite what is already there:

        usethis::create_package("path/to/package/pkgname")

After completing this process the 'Files' window will show additions to the project directory.

**Exercise 5:** Follow the above steps, inserting the correct directory path and package name within the create_package command (you can quickly obtain these using the getwd() command). Lastly, follow Steps 2 and 3 of [this guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/rstudio-git.html#work-with-git-in-rstudio) to commit all your changes to git and then push them to github.com. If you refresh your github.com repository page you should now see the additions there.

## 6. Add R and Rmarkdown code 

Code can be added to a package by saving the R file to the package R directory and the R Markdown file to the package home directory. This can be done in R Studio by saving the files directly (e.g. using the 'Save As' option if they are in a different location). You could also potentially do this programmatically using the function dump() as follows:

        dump("R_object_name", file = "directory_path/R_object_name.R")

If the files are in github.com but not R Studio you have two main options to get them into R Studio. 
* Clone the relevant repository (as shown in [section 4](#4-make-a-copy-of-the-project-in-R-Studio)). 
* If there are only a few files you could click the green github 'Code' button (as in [section 4](#4-make-a-copy-of-the-project-in-R-Studio) aove) and then 'Download ZIP' to download the files to your computer and then upload the relevant ones from your computer into your package using R Studio. 

**Exercise 6:** Add the crimesdata_pub.Rmd file and also the mystyles.docx file (which crimesdata_pub.Rmd calls on) from this repository to your package home directory. Lastly, commit all your changes to git and then push them to github.com. You can now refresh your github.com repository page and see the amendments there.

## 7. Making functions work in a package

While the format of code inside a package is very similar to "normal R code", it is particularly important to properly reference functions that you are using from other packages. This won't affect how your code runs, but it will ensure that others code works correctly when they use your package.

Normally when you use a function from another package, you might call that package in a library call, and then reference the function directly e.g.

        library(dplyr)
        
        data %>% filter(Year == 2020)

Doing this inside a package would cause the dplyr library to be loaded into the R environment which can then have unexpected (global) effects for the user of your package. Their code could then run in ways that they might not expect or want. For example, if someone calls your package that references the dplyr filter() function as above, this could result in their base filter() commands running as if they were dplyr ones. When using a function from another package, you should always specify the function along with the package it's from. You can do this using a double colon e.g.

        data %>% dplyr::filter(Year == 2020)

You will also, instead of using the library() command, need to add any packages you use to your own package's DESCRIPTION file to ensure they are available without causing unexpected effects to anyone who downloads your package. This is covered in [section 8](#8-amend-the-DESCRIPTION-file).   

**Exercise 7:** Add the summarise_crimes.R file from this repository to your package. Open the file and have a look at this function which provides the average number of crimes for the selected years; at the moment the package dplyr is not called correctly. Amend this code so it will work as expected for other users (which it will after you have added dplyr to your package's DESCRIPTION file (a task in [section 8](#8-amend-the-DESCRIPTION-file))) by removing the "library()" call and calling the two dplyr functions (filter and summarise) specifically using the "double colon method". Lastly, commit all your changes to git and then push them to github.com. You can now refresh your github.com repository page and see the amendments there.

## 8. Amend the DESCRIPTION file

The DESCRIPTION file is one of the files automatically created when you run the create package command. It provides important metadata about the package including declaring the external functions your package imports from other packages and the functions your package exports for external use. You can click on the DESCRIPTION filename in the R Studio files window and then amend it as appropriate. 

An example of an amended DESCRIPTION file [is provided here](https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION). The formatting is important. Each line consists of a field name and a value, separated by a colon. Where values span multiple lines, they need to be indented. In particular:

- The Title is a one line description of the package - keep this short, with suitable use of capitals and less than 65 characters.
- The Version should be amended when you update the package
- The Authors@R field makes use of a three letter code to specify the various roles, the most useful being:
   - cre: the package maintainer; the person you should contact if you have a problem.
   - aut: authors; those who have made significant contributions to the package.
   - ctb: contributors; those who have made smaller contributions, like patches.
   - cph: copyright holder. This is used if the copyright is held by someone other than the author, typically a company (i.e. the author’s employer).
- The Description is more detailed than the Title - one paragraph with each line being up to 80 characters.
- The License determines who can use your code and for what purpose. Without a license, the code is copyrighted by default; to use it, you must contact the author directly and ask permission. You can read more about licensing in the [R Packages Licensing chapter](https://r-pkgs.org/license.html). At MoJ we use the MIT License -  see [Analytical Platofrm User Guidance](https://user-guidance.services.alpha.mojanalytics.xyz/github/create-project.html#licence).
- The Depends and Imports fields allow you to list the external packages that your package uses; it is now considered best practice to add these packages as Imports rather than Depends. Unless you have the knowledge to do something different, you should assume that the package version needs to be greater than or equal to the version you're currently using.

You can read more about the most important DESCRIPTION fields in the [R Packages Package metadata chapter](https://r-pkgs.org/description.html). 

To specify a particular license, make sure the usethis package you have installed is 2.0.0 or greater and run the appropriate command. For example, to use the permissive MIT license used by MoJ (specifying your firstname and surname):  

        use_mit_license("Firstname Surname")
        
This specifies the license you have chosen in the DESCRIPTION file and also puts a copy of the full license in LICENSE.md and adds this file to .Rbuildignore.

**Exercise 8:** Amend the DESCRIPTION file, specifically the: 
- Title (e.g. Create a Minimal Statistical Bulletin) 
- Authors@R (e.g. make yourself author and maintainer) 
- Description (e.g. Create a minimal statistical bulletin showing the number of crimes in each year) 
- Package dependency text (specify the minimum version of R needed and the need for ggplot2, dplyr and magrittr).

Follow up by specifying an MIT license. Lastly, commit all your changes to git and then push them to github.com. You can now refresh your github.com repository page and see the amendments there.

## 9. Excluding sensitive data 

You should not hold any sensitive data in Github.com as they may be accessed by others. To prevent you accidentally pushing any sensitive data to Github.com: 

* Don't store any sensitive data within the R Studio copy of your repository. 
* As a second line of protection, specify the names of any sensitive data files in the gitignore file so that they cannot be pushed to Github.com. To do this, open the gitignore file and add the names of the files (e.g. confidential.txt). If there's a file that's not to be ignored then you can specify it while adding an exclamation mark in front of its name e.g. '!unconfidential.txt'. 

A useful [gitignore template](https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore) has been developed by ukdatascience which is free for you to copy, use and amend.

You can also add further protection by using git hooks. These check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about this is available [here](https://github.com/ukgovdatascience/dotfiles).

**Exercise 9:** 
1) Place a copy of crimedata.csv into your package Rstudio folder. Amend the gitignore file to also include the code in the ukdatascience [gitignore template](https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore). After committing and pushing to github.com and refreshing your github.com repository page can you see crimedata.csv there? 
2) Now specify crimedata.csv as a file not to be ignored at the end of the gitignore file (it doesn't actually contain sensitive data). After pushing to github.com can you now see it?

## 10. Adding data in rda format

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

        raw <- read.csv("directory_path/data_name.csv", check.names = TRUE)
        usethis::use_data(raw)  
        rm(raw)

4. Run the R script. The folder 'data' should now have been created that contains the object raw.rda

This R script could be developed. For instance:
1. If some processing of the data is needed this could be added e.g. to make a variable of class factor
2. If the .rda file needs to be updated when the input raw dataset is changed, then add an overwrite=TRUE to the use_data function e.g. usethis::use_data(raw, overwrite = TRUE)  

To see the effect of changes made to the package, the following code needs to be run. All the changes made to the code will now be in memory: 

    devtools::load_all() 

**Exercise 10:** 
1) Make an .rda file of 'crimesdata.csv' (which is already in tidy data format) by following the above steps and give it the user friendly name 'crimes_raw_data'. 
2) Amend crimesdata_pub.Rmd so that it now runs using the .rda file by "commenting out" the read_csv line and removing the "commenting out" of the data(crimes_raw_data) line. 
3) Lastly, commit all your changes to git and then push them to github.com. 

## 11. Adding documentation about package data

Documentation is really important so users know how to use the package, and package managers and developers can quickly get up to speed. It should therefore be embedded within the package in such a way that it is easily available to all users. Best practice is for documentation about:
 
* Datasets (within the package) to be in a separate R script within the R folder.
* Functions (within the package) to be within the same R scripts. 

Documentation can be added for datasets within a package by creating an data.R file. You can view an example [data.R file](https://github.com/DCMSstats/eesectors/blob/master/R/data.R) from the eesectors package; this makes use of the package roxygen2 to automatically turn the formatted comments into nice looking documentation.

Looking at the first 22 rows you can see a title, subtitle, the format of the data, a description of each of the variables, the source location, keywords and lastly what the data object is called (within speech marks; so if the documentation is about crimes_raw_data.rda then "crimes_raw_data").

After adding or amending documentation in an .R file, the following command can be used to generate a more complicated code (.Rd) file in the man folder, which then enables users to view nice looking documentation through the help facility:

    devtools::document()

The documentation for the data object can then be viewed in the help facility using the usual command i.e.:

    ?objectname

Documenting functions is covered in [section 14](#14-documenting-functions). You can learn more about documentation more generally by reading the [R Packages Object documentation chapter](https://r-pkgs.org/man.html); there is also a separate [R Packages section about documenting datasets](https://r-pkgs.org/data.html#sec-documenting-data) which you may want to look at. 

**Exercise 11:** Create an data.R file in your R folder and paste in the first 22 rows from the example eesectors package [data.R file](https://github.com/DCMSstats/eesectors/blob/master/R/data.R). Amend the contents, generate the nice looking documentation, and then take a look at it (using the help facility). Lastly, commit all your changes to git and then push them to github.com. 

## 12. Automating quality assurance checks on input data sets

While input data may already have been quality assured prior to being loaded into the package, it is best practice to set up automated quality assurance checks on these data. As well as being able to flag up inconsistencies, these checks should ensure that the data loaded are in the expected format and structure. This reduces the likelihood of loading data which are incompatible with the code in the package, and ensures the same checks are carried out every time.

You can view an example [quality assurance R script](https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R) from the eesectors package. The roxygen2 documentation appears at the top of the file. The checks include:
- the correct columns are present in the data. 
- that the number of rows is as expected. 

It may also be helpful for the script to:

- produce some charts to enable the user to check the data visually.  
- add name lookups so any charts produced have nice labels (e.g. the first letter being a capital and the others being lower case).
- drop any variables that won't be needed.
- create the final dataset of class 'file/function_name' as done at the end of [the example quality assurance R script](https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R). (Everything in R is an object and many objects have a class attribute, representing the set of properties or methods that are common to all objects of this type.) 

The checks can be run using the code:

    x <- pkgname::file/function_name(dataset_name)

**Exercise 12:** Set up automated quality assurance checks on your input data "crimes_raw_data". These should check that the data are in a valid data.frame and contain no missing values To do this, copy rows 38, 53-56, 67-68, 77 and 174 of [the example quality assurance R script](https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R) into a new R script you can call "crimes_data.R", amend the contents suitably and run the checks. Remember to run devtools::load_all() to see the effect of changes made to your package. Lastly, commit all your changes to git and then push them to github.com. If you have more time, then you could also add checks that the data.frame contains the right number of columns and that these columns have the correct names, and some documentation.

## 13. Developing functions

Why, when and how to write your own functions is covered by the [Writing functions in R](https://github.com/moj-analytical-services/writing_functions_in_r) training. As this states, functions are a way to bundle up bits of code to make them easy to reuse. They can save you time, reduce the risk of errors, and make your code easier to understand. When commencing a project, you should:

* Consider and make a list of what functions would be beneficial. A good rule of thumb is to develop a function whenever you’d be using the same or similar code in three places. It is also helpful to consider others' needs e.g. you may know another analyst who needs similar code.
* After you've made a list, check whether the functions already exist (e.g. in the [mojrap](https://github.com/moj-analytical-services/mojrap) package). As appropriate use those that do and develop any that don't. 
* If developing a new function, consider where it's most beneficial for it to reside. For instance, it may be more beneficial to develop an [mojrap](https://github.com/moj-analytical-services/mojrap) type function within [mojrap](https://github.com/moj-analytical-services/mojrap) than within your package.

**Exercise 13**: Consider (by looking at crimesdata_pub.Rmd) whether it would be beneficial to incorporate any extra functions into your minimal statistical bulletin package (in addition to the summarise_crimes function provided by summarise_crimes.R)? Do you consider the summarise_crimes function beneficial?

## 14. Documenting functions

The mechanism for adding a function script to a package is covered in [section 6](#6-add-R-and-Rmarkdown-code) above.

As with documenting data (see [section 11](#11-adding-documentation-about-package-data) above) it is helpful to use Roxygen2 to document functions. Documentation of functions helps users to understand how they work, what arguments need to be given, and how the arguments need to be formatted.

The documentation of functions is done within the same R script as the function itself - see [this example]( https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R) from the eesectors package. Looking at the first 41 rows you can see a title (one sentence), description, details including inputs, what is returned, some examples, and the @export which enables users to access the function when they load your package. Functions which are not marked with @export can be used by other functions inside the package, but aren't readily available for users directly. Where you see the syntax \code{} the contents of the {} will be regarded as code.  

The process is as follows:

1. Add documentation to the .R file
2. Run devtools::document()
3. Preview in the help facility using ?objectname
4. Amend the documentation as appropriate and repeat steps 2 to 4. 

To check that the documentation enables others to easily understand the code you should get at least one other person to peer review your documentation. Are they able to understand how to use each function from the documentation alone?

**Exercise 14:** Follow the above process to add suitable documentation to the function summarise_crimes.R. It may be easiest to copy rows 1-41 from [this example](https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R) and then amend. You should include a helpful description, details of the inputs, an example, and specify @export to allow users to access the function. Lastly, commit all your changes to git and then push them to github.com. If you still have time, then do the same for the function that you created in the [section 12](#12-automating-quality-assurance-checks-on-input-data-sets) exercise above.

## 15. Using the condition system for functions 

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

**Exercise 15:** Apply the quick way of generating useful feedback to the function summarise_crimes.R and then run it to see what messages are produced. Lastly, commit all your changes to git and then push them to github.com.

## 16. Testing your code 

Anytime someone makes a change to the code, this should be accompanied by testing to check that it works as it should and the output is as expected. Such testing is best automated as manual testing is laborious, boring and time-consuming. Moreover, automated testing provides users with more assurance and helps those making changes to the code to identify any shortcomings and rectify these. 

Tests can be run when desired but are better set up to run automatically (see [section 18](#18-continuous-integration) on continuous integration) before a github pull request is granted. In particular, there are two types of test you should consider:
- unit tests (covered in [section 17](#17-unit-testing)); generally there should be at least one for each function. 
- integration tests (covered in [section 18](#18-continuous-integration)); testing everything in the whole pipeline (or package). 

It is important you decide what aspects of the code really need to be tested, and then to automate only these tests. To make the process as efficient as possible, it may be desirable for you to create mock data (which shouldn't contain any sensitive information) that have the key features of the actual data (same columns, names etc.) but be much smaller in size to allow for easy loading and processing. As long as the data files are small, the mock data can be stored in the tests directory ([section 17](#17-unit-testing) covers how to set this directory up).

**Exercise 16**: Consider (by looking at crimesdata_pub.Rmd) whether it could be beneficial to create a mock version of the crimedata.csv data. This dataset should retain the structure of the crimedata.csv (same number of columns, column names, data types) but be much smaller (e.g. only two or three rows).

## 17. Unit testing

Unit testing can be easily automated using the [testthat package](https://testthat.r-lib.org/). This:
* Provides a user friendly way of specifying tests that determine whether a function has run as expected (e.g. returns a particular value).
* Enables you to write messages that inform the user when running the tests (e.g. figure 1 works as expected).
* Instructs users about whether checks have passed or failed. 
* Easily integrates into your existing workflow. 

To set up your package to use testthat run the command:

        usethis::use_testthat()

This: 
* Adds testthat to the DESCRIPTION Suggests field
* Creates a 'tests' folder, inside of which is: 
  * A testthat folder, where your R test scripts should be placed;
  * The testthat.R file, which runs the R scripts in the testthat folder.

To check what percentage of the (relevant) code in your package is currently being tested, you can run the command devtools::test_coverage()

To develop tests:
* Create a new R script file in the testthat folder.
  * There should generally be one R script for each function which will include all the tests you want to run on it.
  * Each test file should be named 'test_[function name].R'.
* Use the R script to: 
  * Load in any data that you want the test(s) to use.
  * Specify each test using the test_that() function.

An example R script is [here](https://r-pkgs.org/tests.html#test-structure). You'll notice this file includes:
* A single context() call which provides a brief description of its contents.
* Using a package - instead of calling it up using library() follow the see [Section 7. Making functions work in a package](#7-making-functions-work-in-a-package) guidance.
* Specifying the tests using the test_that() functions. Where a test_that() function involves more than one expect_ function, it will only a pass if all expect_ functions produce a TRUE result. Otherwise it will fail.
 
An example test_that() function is as follows:

    test_that("Returns vector of length five", {
     expect_equal(length(your_function(x)), 5)
    })

Notice that:
* The first argument is for providing a clear description of the test (in this example "Returns vector of length five") which is displayed to the user when the test is run.
* Following the first argument, the test itself is specified within curly brackets {} (in this example testing that the returned vector is of length 5). 

Some frequently used expect_ function examples are:
* expect_equal(): Checks that two outputs are equal
* expect_match(): Checks a string matches a regular expression
* expect_type(): Checks an object matches a certain type or class
* expect_output(): Checks the output has a specific structure such as a list
* expect_error(): Checks the code returns an error in specific circumstances
* expect_silent(): Checks that the code produces no output, messages, or warnings. 

For a full list of expect_ functions see the [R Packages Testing chapter](https://r-pkgs.org/tests.html). There are also other functions you can use e.g. using the package vdiffr to test plots to see whether they look as expected. 
  
To run your tests, use devtools::test() or Ctrl/Cmd + Shift + T.

**Exercise 17**: Create some tests for the summarise_crimes function:  
1) Run usethis::use_testthat() to set up your testing structure.
2) Inside the tests/testthat folder, create an R file called test_summarise_crimes.R
3) Create tests (it's easiest to copy and amend some of [this test script](https://github.com/mammykins/regregrap/blob/master/tests/testthat/test_fivereg_recent.R) which contains tests for [this fivereg_recent function](https://github.com/mammykins/regregrap/blob/master/R/fivereg_recent.R)) to check whether the summarise_crimes function stops running if:
   * There is an error.
   * The input is not a dataframe.
   * The input dataframe variables 'year' and 'crimes' aren't of class int.
4) Run the tests you have created. 
5) If time permits, you could also: 
   * Try writing a test that the function will fail, just to see what happens!
   * Run devtools::test_coverage() to check what percentage of (relevant) code in your package is now being tested.
6) Lastly, commit all your changes to git and then push them to github.com.

## 18. Continuous integration

Continous integration is about automating software workflows. An automated workflow can be setup so that when you or someone else pushes changes to github.com, tests are run to ascertain whether there are any problems. These checks should include the unit tests you've developed and also the R CMD tests (over 50 individual checks for common problems).  

Before setting up this automation, it's worth first enhancing the quality of your package by running the R CMD tests (which can take a long time at first as there may be many error messages) and fixing any problems. To do this: 

1. Run devtools::check()  
2. Fix each problem. You should definately fix the errors, try to eliminate the warnings (essential if submitting to CRAN), and ideally eliminate all notes. To understand more about a problem, look it up in [R Packages Automated Checking chapter](https://r-pkgs.org/r-cmd-check.html). It may also be useful to look at [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html), and at code that has passed the test (e.g. [the eesectors package](https://github.com/DCMSstats/eesectors)). 
3. Rerun 

To setup continuous integration using GitHub Actions: 

        usethis::use_github_actions()

This automatically puts a status badge in your README. You can provide extra security for your master branch by going to github settings, then Branches, and 'Require pull request reviews before merging' and 'Require status checks to pass before merging'.

You can read further about automating checking in [R Packages Automated Checking chapter](https://r-pkgs.org/r-cmd-check.html).

**Exercise 18**: Run the R CMD tests on your code and resolve any error messages. Then setup continuous integration using GitHub Actions. Lastly, commit all your changes to git and then push them to github.com.

## 19. Dependency management

The DESCRIPTION Depends and Imports fields list the external packages that your package needs together with the versions required. However, it is still possible that problems may surface, for instance where one package clashes with another. The use of [renv](https://cran.r-project.org/web/packages/renv/vignettes/renv.html) enables each project to have its' own project-local library.     

To install renv: 

        install.packages("renv")

You will also need to add the renv package to your package DESCRIPTION file imports list - see section [8. Amend the DESCRIPTION file](#8-amend-the-DESCRIPTION-file).

You can now use renv to fork (or copy) the state of your default R libraries into a project local library and create (or amend) a project-local .Rprofile which is then used by new R sessions to ensure the project-local library is used: 

        renv::init()

The state of your project-local libraries can also be saved (renv::snapshot()) and loaded (renv::restore()). Benefits of being able to do this include:  

* So you can return to a project in the future with a record of the packages originally used to run it.
* To ensure all collaborators are working with the exact same set of packages.

For more information see [this introduction to renv](https://www.rstudio.com/resources/rstudioconf-2020/renv-project-environments-for-r/).

**Exercise 19**: Setup renv and activate it using renv::init(). Lastly, commit all your changes to git and then push them to github.com.

## 20. Installing and using your package

Congratulations, you have successfully produced a working package in R!

For you and anyone else to install this package, you need to install it from github using devtools::install_github("your package repo and name") e.g.
    
    devtools::install_github("moj-analytical-services/mojrap")
    
You may need to use a Github Personal Access Token (PAT) if your repository access setting is "internal" or "private". For guidance on how to use a PAT, see the [Analytical Platform Guidance section](https://user-guidance.services.alpha.mojanalytics.xyz/github.html#private-r-packages-on-github-pat-authentication) for this. **Note** as per section nine, it is important not to push your PAT to GitHub.

When installing your own packages in the development stage, you can also use other arguments in this function. To install a package from a branch other than your default branch, use the "ref" argument to specify the branch of interest. You can also specify a commit or release to install using:
    
    devtools::install_github("moj-analytical-services/mojrap@v1.0.1")
    
**Exercise 20**: Try installing your completed package!


