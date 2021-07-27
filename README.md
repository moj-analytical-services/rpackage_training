# rpackage_training
Making and developing R packages for RAP (Reproducible Analytical Pipelines). This training is suitable for those who have completed the following training sessions or have at least reached an equivalent standard to having done this:

- Intro R training: https://github.com/moj-analytical-services/IntroRTraining
- R Charting: https://github.com/moj-analytical-services/ggplotTraining
- R Markdown: https://github.com/moj-analytical-services/rmarkdown_training
- Writing functions in R: https://github.com/moj-analytical-services/writing_functions_in_r

Recordings of these sessions can be viewed at: https://web.microsoftstream.com/channel/aa3cda5d-99d6-4e9d-ac5e-6548dd55f52a. 

# 1. Introduction

This training is based on Matthew Gregory's free online course 'Reproducible Analytical Pipelines (RAP) using R' (see https://www.udemy.com/reproducible-analytical-pipelines/) and Hadley Wickham's book 'R Packages' (see http://r-pkgs.had.co.nz/)

The goal of this training is to teach you how to develop packages with a particular emphasis on RAP. Thankfully they are not difficult to make. This training is designed for you to follow along with, and in each section there are exercises you can follow which enable you to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training - see https://github.com/moj-analytical-services/rmarkdown_training. The files to do this are all included in this repository. You can then apply the same skills to your real life publications.

There are benefits to the RAP for each statistical publication being within a package. Hadley Wickham's introduction (https://r-pkgs.org/intro.html) states: "In R, the fundamental unit of shareable code is the package. A package bundles together code, data, documentation, and tests, and is easy to share with others."  The package should also include tests and data (which can be made up if real data are sensitive). The directory structure of an R package is typically as follows (e.g. https://github.com/DCMSstats/eesectors): 

- R code is in 'R' (this is required); 
- documentation is in 'man' (this is also required); 
- data are in 'data'; 
- tests are in 'tests'; 
- dependency management may be in the associated directory e.g. 'packrat' if using packrat; and 
- templates on how to use the package are in 'vignettes'.

**Exercise 1:** Take a look at the structure of a github repo which contains [an R package](https://github.com/DCMSstats/eesectors) and see if you can recognise the structure described above.

# 2. Choose a name

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short; 
- be unique (for google searches); 
- include either upper or lower case characters but not a mixture of them; 
- be clear about what the package does e.g. if to do some RAP work, consider putting 'rap' at the end of the name. 

You can read more about naming a package in the 'Naming your package' section of https://r-pkgs.org/workflows101.html?q=name#naming

As we're going to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training (see https://github.com/moj-analytical-services/rmarkdown_training) choose a name such as "egnamerap" where the eg is because it's a training exercise, the name is your first name (if your first name is very unique) and the rap because you are going to RAP a minimal statistical bulletin.

**Exercise 2:** Decide what name to call your package

# 3. Create github repository 

Your package will be created inside a github repository to show you how to allow other people to download and use your packages (just like any other R package). Guidance to create a new github repository is at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#creating-your-project-repo-on-github.

**Exercise 3:** Follow the guidance to create a new github repository, giving it the same name as you've decided to call your package (see previous section) and a suitable description (e.g. 'My RAP training exercise'). As this is a training exercise you can leave the default setting of your repository (see Step 2) as PRIVATE so it’s only visible to you.

# 4. Make a copy of the project in R Studio

You then need to clone your repository to your version of R to allow you to make changes to it. Guidance to do this is available here: https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio. As github has changed since this guidance was made, instead of clicking the green github 'Clone or download' button, click the green 'Code' button.

**Exercise 4:** Follow Step 1 of the guidance to make a copy of the project in R Studio.

# 5. Create the package 

You can now convert your cloned repository into a package automatically in R Studio by taking the following steps:

- Install the package devtools if you haven't already (click on Packages, Install, type in devtools and click on Install). 
- Run the following command and select the option to overwrite what is already there:

        devtools::create("path/to/package/pkgname")

You can now see in the 'Files' window that there are additions in your project directory.

**Exercise 5:** Follow the above steps, inserting the correct directory path and package name within the create command (you can quickly obtain these using the getwd() command). Lastly, follow Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio, committing your changes to all files to git and then pushing them to github.com. If you refresh your github.com repository page you should now see the additions there.

# 6. Add R and Rmarkdown code 

It's now time to add the code that makes up your package! This can be code in both R and R Markdown files; R files need to be added to the package R/ directory while R Markdown code can be saved to the package home directory. You can do this in R Studio by either saving the files directly (e.g. using the 'Save As' option) or programmatically using the function dump() as follows:

        dump("R_object_name", file = "directory_path/R_object_name.R")

If the files you want to include within your package are in GitHub but not R Studio then you have two main options to get them in R Studio. You could either clone the relevant repository (as in section 4 'Make a copy of the project in R Studio' above). Or if there are only a few files you could click the green github 'Code' button (as in section 4 above) and then 'Download ZIP' to download the files to your computer and then upload the relevant ones from your computer into your package using R Studio. 

**Exercise 6:** Add the crimesdata_pub.Rmd file to your package. 

# 7. Making your functions work in a package

Generally, there are few differences between the normal R code that you write, and the format of code inside a package. The most important consideration is how you reference functions that you are using from other packages.

Normally when you use a function from another package, you might call that package in a library call, and then reference the function directly e.g.

        library(dplyr)
        
        data %>% filter(Year == 2020)

You can't do this from inside a package as it will affect the package availability across someone else's version of R. Instead you need to call each function specifically using a double colon e.g.

        data %>% dplyr::filter(Year == 2020)

You will also need to add any packages you use to your own package's DESCRIPTION file (more on this in the next section) to ensure they are available to anyone who downloads your package. Note that none of this affects how your code actually runs, it just ensures that it works correctly when installed.

**Exercise 7:** Add the summarise_crimes.R file to your package. Open the file and have a look at this function; at the moment the package dplyr is not called correctly for use in a package. Make this code work within your package by removing the "library()" call and calling the two dplyr functions specifically using the "double colon method". Push your changes to Github.

# 8. Amend the DESCRIPTION file

The DESCRIPTION file is one of two files automatically created when you run the create package command, the other being the NAMESPACE file (more about this later). It provides important metadata about the package. You can click on the DESCRIPTION filename in the R Studio files window and then amend it as appropriate. 

To view an example of an amended DESCRIPTION file see: https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION Take note of the formatting. Each line consists of a field name and a value, separated by a colon. Where values span multiple lines, they need to be indented. In particular:

- The Title is a one line description of the package - keep short, capitalised like a title and less than 65 characters.
- The Version should be amended when you update the package
- The Authors@R field which has a three letter code specifying the role, the most useful being:
   - cre: the package maintainer, the person you should contact if you have a problem.
   - aut: authors, those who have made significant contributions to the package.
   - ctb: contributors, those who have made smaller contributions, like patches.
   - cph: copyright holder. This is used if the copyright is held by someone other than the author, typically a company (i.e. the author’s employer).
- The Description is more detailed than the Title - one paragraph with each line being up to 80 characters
- The Depends and Imports fields allow you to list the packages that your package needs to work; nowadays it is considered best practice to add these packages as Imports rather than Depends. Unless you have the knowledge to do something different, you should assume that the package version needs to be greater than or equal to the version you're currently using.

You can read more about the most important DESCRIPTION fields at: https://r-pkgs.org/description.html

**Exercise 8:** Amend the DESCRIPTION file, specifically: 
- Title (e.g. Create a minimal statistical bulletin) 
- Authors@R (e.g. make yourself author and maintainer) 
- Description (e.g. Create a minimal statistical bulletin showing the number of crimes in each year) 
- Package dependency text (specify the minimum version of R needed and the need for ggplot2 and dplyr). 

Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the amendments there.

# 8. Excluding sensitive data 

Analytical Platform best practice is that you should not be storing sensitive data within your R Studio copy of the repository, as this prevents you accidentally pushing this to Github. There is also a second layer of protection that you should set up to prevent the package containing any sensitive information. 

The gitignore file can be amended to specify any sensitive data files so that they cannot to be pushed to git. This can be done by opening the gitignore file and adding the name of the file (e.g. confidential.txt). If there's a file that's not to be ignored then add an exclamation mark in front of its name e.g. '!unconfidential.txt'. 

A link to a template gitignore that ukgovdatascience have done and which is free to copy, use and amend as appropriate is at: https://github.com/ukgovdatascience/dotfiles

You can also use git hooks which check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about these hooks is available at: https://github.com/ukgovdatascience/dotfiles

**Exercise 8:** Place a copy of crimedata.csv into your package Rstudio folder. Then amend the gitignore file to include the code in https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore After committing and pushing to github (Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio) can you see crimedata.csv? Then additionally specify crimedata.csv as a file not to be ignored at the end of the gitignore file. After pushing to github can you now see it?

# 9. Adding data in rda format

While no sensitive data should be stored in the package, it is helpful to include some non-sensitive data to make the development of functions and package testing easier. Where the data are sensitive, fake data should be generated instead.

Any data included within the package should be in the form of a minimal tidy data set. Tidy datasets are easy to manipulate, model and visualise, and have a specific structure; each variable being a column, each observation a row, and each type of observational unit a table such that data corresponding to different types of observational unit (e.g. offenders and offender managers) are stored in separate tables. More information about tidy data can be found here: https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html 

The best way to store the data inside the package is as an .rda file, which stores the data in a format native to R. Compared with keeping the data in a .csv file, this format:

- Is faster to restore the data to R
- Keeps R specific information encoded in the data (e.g. attributes, variable types)

To create a nice .rda file:

1. Create a sub-directory called 'data-raw' in your project Rstudio folder by running the command:

        usethis::use_data_raw()
        
2. Place the raw data into 'data-raw/'

3. Open the R script 'DATASET.R' in 'data-raw/' that has automatically been created by step 1. This can be amended to read in the raw data and put them into 'data/' as an .rda object as follows:

        raw <- read.csv("directory_path/data_name.csv", check.names = TRUE)
        usethis::use_data(raw)  
        rm(raw)

4. Run the script.

Now the folder 'data' will have been created that contains the object raw.rda

The code could be developed. For instance:
1. If some processing of the data is needed this could be added e.g. to make a variable of class factor
2. If the .rda file needs to be updated when the input raw dataset is changed, then add an overwrite=TRUE to the use_data function e.g. usethis::use_data(raw, overwrite = TRUE)  

To see the effect of changes made to the package, the following code needs to be run. All the changes made to the code will now be in memory: 

    devtools::load_all() 

**Exercise 9:** Make an .rda file of 'crimesdata.csv' by following the above steps and give it a user friendly name such as 'crimes_raw_data'. Then amend crimesdata_pub.Rmd so that it now runs using the .rda file by "commenting out" the read_csv line and removing the "commenting out" of the data(crimedata) line. Lastly push to github.

# 10. Adding documentation about package data

Documentation is really important so users know how to use the package, and package managers and developers can quickly get up to speed. It should be embedded within the package in such a way that it is easily available to all users. All documentation for the package should be held within the R folder. Documentation about data sets within the package should be in a separate R script while documentation for a function can be within the same R script. 

Documentation can be added for data sets within a package by creating an data.R file. You can view an example data.R file in the eesectors package at https://github.com/DCMSstats/eesectors/blob/master/R/data.R; this makes use of the package roxygen2 to automatically turn the formatted comments into nice looking documentation.

Looking at the first 22 rows you can see a title, subtitle, the format of the data, a description of each of the variables, the source location, keywords and lastly what the data object is called (within speech marks; so if the documentation is about crimes_raw_data.rda then "crimes_raw_data").

After adding or amending documentation in an .R file, the following command can be used to generate a more complicated code (.Rd) file in the man folder, which then enables users to view nice looking documentation through the help facility:

    devtools::document()

The documentation can then be viewed in the help facility using the usual help facility command i.e.:

    ?objectname

To read more about documentation more generally go to: https://r-pkgs.org/man.html, and for data objects specifically: https://r-pkgs.org/data.html#documenting-data  

**Exercise 10:** Create an data.R file in your R folder and paste in the first 22 rows from the one in the eesectors package. Amend the contents, generate the nice looking documentation, and then check out the documentation you have created. Lastly, push to github.

# 11. Automating quality assurance checks on input data sets

While input data may already have been quality assured prior to being loaded into the package, it is best practice set up automated quality assurance checks on the data within the package. As well as being able to flag up inconsistencies, these checks should ensure that the data loaded are in the expected format and structure. This reduces the likelihood of loading data which are incompatible with the code in the package, and ensures the same checks are carried out every time.

You can view an example quality assurance R script in the eesectors package at https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R The roxygen2 documentation appears at the top of the file. The checks include:
- the correct columns are present in the data 
- that the number of rows is higher than the expected minimum. 

It may also be helpful for the script to:

- produce some plots to enable the user to check the data visually.  
- add name lookups so any charts have nice labels (e.g. the first letter being a capital and the others being lower case).
- drop any variables that won't be needed.
- create the final data set of class 'file/function_name' (see the end of https://github.com/mammykins/regregrap/blob/master/R/phase_date_data.R)

The checks can be run using the code:

    x <- pkgname::file/function_name(dataset_name)

**Exercise 11:** Set up some automated quality assurance checks on your input data. These should check that the the data.frame contains no missing values, that it has the right number of columns, and that these columns have the correct names. To do this, copy rows 1-77 and 174 of https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R, amend the contents suitably, run the checks, and lastly push to github.

# 12. Developing functions

Why, when and how to write your own functions is covered by the ['Writing functions in R'](https://github.com/moj-analytical-services/writing_functions_in_rWriting) training. As ['Writing functions in R'](https://github.com/moj-analytical-services/writing_functions_in_rWriting) states, functions are a way to bundle up bits of code to make them easy to reuse. They can save you time, reduce the risk of errors, and make your code easier to understand. You should consider and make a list of what functions would be beneficial (a good rule of thumb for this is whenever you’d be using the same or similar code in three places) and then develop those that don't already exist.

The mechanism for adding a function script to a package is covered in section 6 above.

**Exercise 12**: Consider whether it would be beneficial to incorporate any functions into a package like your minimal statistical bulletin package? Regardless of the answer, a function called plot_crimes.R has been created to produce the plot. Add this to your package and amend crimesdata_pub.Rmd so it uses this function. Lastly, push to github.

# 13. Documenting functions

As with documenting data (see section 10 above) it is helpful to use Roxygen2 to document functions. Documentation of functions helps users to understand how functions work, and what arguments they need to be given (and what format those arguments should take).

The documentation of functions is done within the same R script as the function itself - an example can be viewed at: https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R  

Looking at the first 41 rows you can see a title (one sentence), description, details including inputs, what is returned, some examples, and the @export which enables users to access the function when they load your package. Functions which are not marked with @export can be used by other functions inside the package, but aren't readily available for users directly. 

The process is as follows:

1. add documentation to the .R file
2. run devtools::document()
3. preview in the help facility using ?objectname
4. amend the documentation as appropriate and repeat steps 2 to 4. 

To check that the documentation enables others to easily understand the code you can get someone else to peer review your documentation and see if they understand how to use each function from the documentation alone.

**Exercise 13:** Follow the above process to add suitable documentation to the function plot_crimes.R. Make sure you include a helpful description, details of the inputs, and an example. Make sure you specify @export to allow users to access the function. Lastly, push to github.

# 14. Using the condition system 

It is very helpful for package users to get good feedback about something unusual happening when running a particular function, as it makes it easier to understand what is going wrong, or to debug code.  R has a very powerful condition system which can be used to flag errors, warnings and messages. You can read more about this in section 8 of ['Advanced R'](https://adv-r.hadley.nz/conditions.html) by Hadley Wickham.

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
      
An applied example of this can be seen at: https://github.com/DCMSstats/eesectors/blob/master/R/figure3.1.R 

**Exercise 14:** Follow the above process to generate useful feedback when running the function plot_crimes.R. Run the function to check what kind of messages this function generates when it runs. Lastly, push to github.

# 15. Testing your code 

Any time you or someone else makes a change to code in your package, this should be accompanied by testing to check that the revised function works as it should and the output is as expected. Such testing is best automated as manual testing is laborious, boring and time-consuming. Moreover, automated testing provides package users with more assurance and assists anyone who makes changes to the code to identify any shortcomings and rectify these. 

As with manual checking, it is first important to decide what aspects of your code need to be tested, and to automate only these tests. Often, it is sensible to create mock data to use to test your code. This data should have have the key features of the actual data (same columns, names, etc) but be much smaller in size to allow for easy loading and processing. The mock data can also be stored in the package as it does not contain any sensitive information. 

There are two types of test:
- unit tests; generally there should be at least one for each function. 
- functional tests; these test everything in the whole pipeline (or package). 

These can be run when desired but also be set up to run automatically (continuous integration) before a github pull request is granted. 

**Exercise 15**: Create a mock version of the crimedata.csv data. This dataset should retain the structure of the crimedata.csv (same number of columns, column names, data types) but should be much smaller (e.g. only two or three rows).

# 16. Unit testing

Unit testing can be easily automated using the testthat package:

- It provides functions that make it easy to describe what you expect a function to do (e.g. logical boolean tests).
- It enables you to write informative messages (e.g. figure 1 works as expected). This means that when you run the test you can quickly see whether something has worked as expected.
- It is easy to see checks have passed or failed. If a check is passed then the output will be 'figure X works as expected: ..', with a dot indicating a pass. If there is a failure, a number will be given and it will be listed at the end of your output.   
- it easily integrates into your existing workflow. 

To set up your package to use testthat:

* Run "devtools::use_testthat()" (see http://r-pkgs.had.co.nz/tests.html for more details). This creates a test folder structure, which consists of a folder called "test" and inside that is a testthat folder and the testthat.R file, which contains the basic code required to run the tests. 
* You can now create your tests in the testthat folder. You can create a new file in here for every set of tests you want to run on a specific function. Each file needs to be named "test_[function name].R"
* Inside the test file, you can load in any data that you want to use for the tests. You can then create any tests you want to run using the test_that() function.
* The first argument to this function should be a description of the test you are running; this is what test_that displays when a test fails, so make it a clear description e.g. "string is five characters long"
* After this, you can pass the tests themselves in curly brackets {}. There are many varieties of test that can be created using the range of expect_X functions. Some examples of these functions are:
  * expect_equal(): Checks that two outputs are equal
  * expect_match(): Checks a string matches a regular expression
  * expect_output(): Checks the output has a specific structure such as a list
  * expect_error(): Check that the code returns an error in specific circumstances.
  
A completed test will look something like this:

    test_that("Vector contains exactly five objects", {
      
      expect_equal(length(your_function(x)), 5)
    
    })
    
* You can find a full list of expect_ functions in the Testing chapter of the [R Packages book](https://r-pkgs.org/tests.html). You can additionally test figures e.g. plots to see whether they look like they should by using the package vdiffr (in CRAN and compatible with the testthat package).
* When the test runs, it will check that all of the expect functions produce a TRUE result. If they don't, that specific test will fail.

**Exercise 16**: Create some tests for the fivereg_recent function (taken from [here](https://github.com/mammykins/regregrap/blob/master/R/fivereg_recent.R):  

1) Save a copy of the fivereg_recent.R file from this repo into your R package repo. Take a look at the function.

2) Run "devtools::use_testthat()" to set up your testing structure.

3) Inside the test/testthat folder, create an R file called test_fivereg_recent.R

4) Create some tests for this function, to check for example:

  * Does the function stop running if there is an error.
  * Does the function stop running if the input is not a dataframe.
  * Does the function stop running if the input dataframe 'df' doesn't contain the variable 'register' that is of class character or the variable 'date' that is of class date.

5) Run the tests you have created using command+shift+t. Try writing a test that the function will fail, just to see what happens!

6) You can also run devtools::test_coverage() to check what percentage of the code in your package is currently being tested.

# 17. Continuous integration (functional testing)

# 18. Installing and using your package

Congratulations, you have successfully produced a working package in R!

For you and anyone else to install this package, you need to install it from github using devtools::install_github("your package repo and name") e.g.
    
    devtools::install_github("moj-analytical-services/mojrap")
    
You may need to use a Github Personal Access Token (PAT) if your repository access setting is "internal" or "private". 

When installing your own packages in the development stage, you can also use other arguments in this function. To install a package from a branch other than your default branch, use the "ref" argument to specify the branch of interest. You can also specify a commit or release to install using:
    
    devtools::install_github("moj-analytical-services/mojrap@v1.0.1")
    
**Exercise 18**: Try installing your completed package!


