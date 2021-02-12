# rpackage_training
Making and developing R packages for RAP (Reproducible Analytical Pipelines). This training is suitable for those who have completed the following training sessions or have at least reached an equivalent standard to having done this:

- Intro R training: https://github.com/moj-analytical-services/IntroRTraining
- R Charting: https://github.com/moj-analytical-services/ggplotTraining
- R Markdown: https://github.com/moj-analytical-services/rmarkdown_training
- Writing functions in R: https://github.com/moj-analytical-services/writing_functions_in_r

Recordings of these sessions can be viewed at: https://web.microsoftstream.com/channel/aa3cda5d-99d6-4e9d-ac5e-6548dd55f52a. 

# 1. Introduction

This training is based on Matthew Gregory's free online course 'Reproducible Analytical Pipelines (RAP) using R' (see https://www.udemy.com/reproducible-analytical-pipelines/) and Hadley Wickham's book 'R Packages' (see http://r-pkgs.had.co.nz/)

The goal of this training is to teach you how to develop packages with a particular emphasis on RAP. Thankfully they are not difficult to make. To maximise its' usefulness please do the exercises which enable you to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training - see https://github.com/moj-analytical-services/rmarkdown_training. You can then apply the same skills to your real life publications.

There are benefits to the RAP for each statistical publication being within a package. Hadley Wickham's introduction (https://r-pkgs.org/intro.html) states: "In R, the fundamental unit of shareable code is the package. A package bundles together code, data, documentation, and tests, and is easy to share with others."  The package should also include tests and data (which can be made up if real data are sensitive). The directory structure of an R package is typically as follows (e.g. https://github.com/DCMSstats/eesectors): 

- R code is in 'R' (this is compulsory); 
- documentation is in 'man' (this is compulsory); 
- data are in 'data'; 
- tests are in 'tests'; 
- dependency management may be in the associated directory e.g. 'packrat' if using packrat; and 
- templates on how to use the package are in 'vignettes'.

# 2. Choose a name

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short; 
- be unique (for google searches); 
- include either upper or lower case characters but not a mixture of them; 
- be clear about what the package does e.g. if to do some RAP work, consider putting 'rap' at the end of the name. 

You can read more about naming a package in the 'Naming your package' section of https://r-pkgs.org/workflows101.html?q=name#naming

As we're going to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training (see https://github.com/moj-analytical-services/rmarkdown_training) choose a name such as egnamerap where the eg is because it's a training exercise, the name is your first name (if your first name is very unique) and the rap because you are going to RAP a minimal statistical bulletin.

Exercise 1: Decide what name to call your package

# 3. Create github repository 

Guidance to create a new github repository is at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#creating-your-project-repo-on-github The formatting of the 'create a new repository' github page has changed slightly since this guidance was created but the substance is still the same. 

Exercise 2: Follow the guidance to create a new github repository, giving it the same name as you've decided to call your package (see previous section - if this name is already taken you'll have to call it something else) and a suitable description (e.g. 'My RAP training exercise'). As this is a training exercise you can leave the default setting of your repository (see Step 2) as PRIVATE so it’s only visible to you as the creator.

# 4. Make a copy of the project in R Studio

Guidance to make a copy of the project in R Studio is at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio. As github has changed since this guidance was made, instead of clicking the green github 'Clone or download' button, click the green 'Code' button.

Exercise 3: Follow Step 1 of the guidance to make a copy of the project in R Studio.

# 5. Create the package 

You can create a package in R Studio by taking the following steps:

- Install the package devtools if you haven't already (click on Packages, Install, type in devtools and click on Install). 
- Run the following command and select the option to overwrite what is already there:

        devtools::create("path/to/package/pkgname")

You can now see in the 'Files' window that there are additions in your project directory.

Exercise 4: Follow the above steps, inserting the correct directory path and package name within the create command (you can quickly obtain these using the getwd() command). Lastly, follow Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio, committing your changes to all files to git and then pushing them to github.com. If you refresh your github.com repository page you should now see the additions there.

# 6. Add R and Rmarkdown code 

Any R and R Markdown code to be within the package should be saved into it. The R code can be saved to the package R/ directory while the R Markdown code can be saved to the package home directory. You can do this in R Studio either in the normal way (e.g. using the 'Save As' option) or programmatically using the function dump() as follows:

        dump("R_object_name", file = "directory_path/R_object_name.R")

If the files you want to include within your package are in GitHub but not R Studio then you have two main options to get them in R Studio. You could either clone the relevant repository (as in section 4 'Make a copy of the project in R Studio' above). Or if there are only a few files you could click the green github 'Code' button (as in section 4 above) and then 'Download ZIP' to download the files to your computer and then upload the relevant ones from your computer into your package using R Studio. 

Exercise 5: Add the crimesdata_pub.Rmd to your package. 

# 7. Amend the DESCRIPTION file

The DESCRIPTION file is one of two files automatically created when you run the create package command (see above section on 'Create the package'), the other being the NAMESPACE file (more about this later). It provides important metadata about the package. You can click on the DESCRIPTION filename in the R Studio files window and then amend it as appropriate. 

To view an example of an amended DESCRIPTION file see: https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION Take note of the formatting. Each line consists of a field name and a value, separated by a colon. Where values span multiple lines, they need to be indented. In particular:

- The Title is a one line description of the package - keep short, capitalised like a title and less than 65 characters.
- The Version should be amended when you update the package
- The Authors@R field which has a three letter code specifying the role, the most useful being:
   - cre: the package maintainer, the person you should contact if you have a problem.
   - aut: authors, those who have made significant contributions to the package.
   - ctb: contributors, those who have made smaller contributions, like patches.
   - cph: copyright holder. This is used if the copyright is held by someone other than the author, typically a company (i.e. the author’s employer).
- The Description is more detailed than the Title - one paragraph with each line being upto 80 characters
- The Depends and Imports fields allow you to list the packages that your package needs to work; apart from the version of R generally use the Imports rather than the Depends command to do this. Unless you have the knowledge to do something different, require the package version to be greater than or equal to the version you’re currently using.

You can read more about the most important DESCRIPTION fields at: https://r-pkgs.org/description.html

Exercise 6: Amend the DESCRIPTION file, specifically the Title, Authors@R, Description and package dependency text (we need ggplot2 and dplyr). Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the amendments there.

# 8. Excluding sensitive data 

The best way to ensure you don't accidentally push any sensitive data to github.com is not to store them within your R Studio copy of the repository. There is also a second layer of protection that you should set up to prevent the package containing any sensitive information. 

The gitignore file can be amended to specify any sensitive data files so that they cannot to be pushed to git. This can be done by opening the gitignore file and adding the name of the file (e.g. confidential.txt). If there's a file that's not to be ignored then add an exclamation mark in front of its name e.g. '!unconfidential.txt'. 

A link to a template gitignore that ukgovdatascience have done and which is free to copy, use and amend as appropriate is at: https://github.com/ukgovdatascience/dotfiles

You can also use git hooks which check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about these hooks is available at: https://github.com/ukgovdatascience/dotfiles

Exercise 7: Place a copy of crimedata.csv into your package Rstudio folder. Then amend the gitignore file to include the code in https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore After committing and pushing to github (Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio) can you see crimedata.csv? Then additionally specify crimedata.csv as a file not to be ignored at the end of the gitignore file. After pushing to github can you now see it?

# 9. Adding data in RData format

While no sensitive data should be within the package, it is helpful to include non-sensitive data to make the development of functions and package testing easier. Where the data are sensitive, fake data should be generated instead.

Any data included within the package should be in the form of a minimal tidy data set. Tidy datasets are easy to manipulate, model and visualise, and have a specfic structure; each variable is a column, each observation a row, and each type of observational unit a table (e.g. if for each offender we measure height and weight, then the observational unit is the offender) such that data corresponding to different types of observational unit (e.g. offenders and offender managers) are stored in separate tables. 

It is beneficial for the data to be within the package as an .RData file which stores the data in a format native to R. Compared with keeping the data in a .csv file it:

- Is faster to restore the data to R
- Keeps R specific information encoded in the data (e.g. attributes, variable types)

To create a nice .RData file:

1. Create a sub-directory called 'data-raw' in your project Rstudio folder by running the command 'devtools::use_data_raw()' 
2. Place the raw data into 'data-raw/'
3. Create a new R script in 'data-raw/' which reads in the raw data and puts them into 'data/' as an .RData object:

        raw <- read.csv("directory_path/data_name.csv", check.names = TRUE)
        devtools::use_data(raw)  
        rm(raw)

4. Save the script (e.g. as create_raw.R) and run it

Now the folder 'data' will have been created that contains the object raw.RData

The code could be developed. For instance:
1. If some processing of the data is needed this could be added e.g. to make a variable of class factor i.e. raw$phase <- as.factor(raw$phase)
2. If the .RData file is to be amended when the input raw dataset is amended then add an overwrite=TRUE to the use_data function e.g. devtools::use_data(raw, overwrite = TRUE)  

To see the effect of changes made to the package, the following code needs to be run. All the changes made to the code will now be in memory: 

    devtools::load_all() 

Exercise 8: Make an .RData file of 'crimesdata.csv' by following the above steps (including calling it 'raw'). Then amend crimesdata_pub.Rmd so that it now runs using the .RData file by "commenting out" the read_csv line and removing the "commenting out" of the data(crimedata) line. Lastly push to github.

# 10. Adding documentation about package data

Documentation is really important so users know how to use the package and so creators (who may forget the details) and developers can quickly get up to speed. It should therefore be embedded within the package in such a way that it is easily available to all users. Documentation about data sets within the package should be provided in a separate R script while that for an function can be held within the same R script. All documentation for the package should be held within the R folder. 

Documentation can be added for data sets within a package by creating an data.R file. You can view an example data.R file in the eesectors package at https://github.com/DCMSstats/eesectors/blob/master/R/data.R; this makes use of the package roxygen2 to automatically turn the formatted comments into nice looking documentation.

Looking at the first 22 rows you can see a title, subtitle, the format of the data, a description of each of the variables, the source location, the keywords and at the bottom what the data object is called (within speech marks).  

After adding or amending documentation in an .R file, the following command can be used to generate a more complicated code (.Rd) file in the man folder, which then enables users to view nice looking documentation through the help facility:

    devtools::document()

The documentation can then be viewed in the help facility using the usual help facility command i.e.:

    ?objectname

To read more about documentation more generally go to: http://r-pkgs.had.co.nz/man.html, and for data objects specifically: http://r-pkgs.had.co.nz/data.html#documenting-data  

Exercise 9: Create an data.R file in your R folder and paste in the first 22 rows from the one in the eesectors package. Amend the contents, generate the nice looking documentation, and then check out the documentation you have created. Lastly, push to github.

# 11. Automating quality assurance checks on input data sets

While input data may already have been quality assured prior to being loaded into the package, it is best practice set up automated quality assurance checks on the data within the package. 

You can view an example quality assurance R script in the eesectors package at https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R The roxygen2 documentation appears at the top of the file. The checks include that the data contain the correct columns and that the number of rows is at least the minimum expected. It may also be helpful for the script to:

- produce some plots to enable the user to check visually that the data look okay.  
- add name lookups for instance so any charts have nice labels (e.g. the first letter being a capital and the others being lower case).
- drop any variables that won't be needed.
- create the final data set of class 'file/function_name' (see the end of https://github.com/mammykins/regregrap/blob/master/R/phase_date_data.R)

The checks can be run using the code:

    x <- pkgname::file/function_name(dataset_name)

Exercise 10: Set up some automated quality assurance checks on your input data to check the the data.frame contains no missing values and the right number and names of columns. To do this, copy rows 1-77 and 174 of https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R, amend the contents suitably, run the checks, and lastly push to github.

# 12. Developing functions

Why, when and how to write your own functions is covered by the ['Writing functions in R'](https://github.com/moj-analytical-services/writing_functions_in_rWriting) training. As ['Writing functions in R'](https://github.com/moj-analytical-services/writing_functions_in_rWriting) states, they are a way to bundle up bits of code to make them easy to reuse. They can save you time, reduce the risk of errors, and make your code easier to understand. You should consider and make a list of what functions would be beneficial (a good rule of thumb for this is whenever you’d be using the same or similar code in three places) and then develop those that don't already exist.

The mechanism for adding a function script to a package is covered in section 6 above.

Exercise 11: Is it beneficial to incorporate any functions to your minimal statistical bulletin package? Regardless of the answer, a function called plot_crimes.R has been created to produce the plot. Add this to your package and amend crimesdata_pub.Rmd so it uses this function. Lastly, push to github.

# 13. Documenting functions

As with documenting data (see section 10 above) it is helpful to use Roxygen2 to document functions. The documentation of functions is done within the same R script - an example can be viewed at: https://github.com/DCMSstats/eesectors/blob/master/R/year_sector_data.R  

Looking at the first 41 rows you can see a title (one sentence), description, details including about inputs, what is returned, some examples, and the @export which enables the accessibility of the function to users when they load your package.

The process is as follows:
1. add documentation to the .R file (may be easiest to copy from the above R script and then amend)
2. run devtools::document()
3. preview in the help facility using ?objectname
4. amend as appropriate and repeat steps 2 to 4. 

To check that the documentation enables others to easily understand the code it is also recommended that it is peer reviewed.

Exercise 12: Follow the above process to add suitable documentation to the function plot_crimes.R. Lastly, push to github.

# 14. Using the condition system 

It is very helpful for package users to get good feedback about something unusual happenning when running a particular function. R has a very powerful condition system which can be used to flag errors, warnings and messages. You can read more about this in section 8 of ['Advanced R'](https://adv-r.hadley.nz/conditions.html) by Hadley Wickham.

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

Exercise 13: Follow the above process to generate useful feedback when running the function plot_crimes.R. Lastly, push to github.

# 15. Testing your code 

Any changes to code should be accompanied by testing to check that the revised function works as it should and the output is as expected. Such testing is best automated as to do manually is laborious, boring and time consuming. Moreover, automated testing provides package users with more assurance and assists anyone who makes changes to the code to identify any shortcomings and rectify these. As with manual checking, it is important to decide what needs to be tested and automate only these tests. It may often be desirable to create mock data to test the code using, which have the key features of the actual data but are much smaller in size. 

There are two types of test:
- unit tests; generally there should be one for each function. 
- functional tests; these test everything in the whole pipeline (or package). 

These can be run when desired but also be set up to run automatically (continuous integration) before a github pool request is granted. 

# 16. Unit testing

The testthat package makes setting up tests easy:
- provides functions that make it easy to describe what you expect a function to do (e.g. logical boolean tests).
- it enables you to write informative messages (e.g. figure 1 works as expected) so that when you run the test you can quickly see whether something has worked as expected (e.g. if the test involves two figure 1 checks and is passed then the output will be 'figure 1 works as expected: ..', a dot indicating a pass. If there is a failure a number will be give and it will be listed at the end of your output.   
- it easily integrates into your existing workflow. 
To set up your package to use testthat run the code "devtools::use_testthat()" (see http://r-pkgs.had.co.nz/tests.html for more details) which creates a test folder, within that a testthat folder and testthat.R which doesn't contain much code. The bulk of the code can now be added to the testthat folder, with the various files being named "test_[function name].R"
For example, take a look at developing a test for https://github.com/mammykins/regregrap/blob/master/R/fivereg_recent.R  which can be viewed at: https://github.com/mammykins/regregrap/blob/master/tests/testthat/test_fivereg_recent.R 
1) Create a new R script in the testthat folder called 'test_fivereg_recent.R' 
2) Then can copy code from http://r-pkgs.had.co.nz/tests.html#test-structure and adapt it. Can now check function that for instance is coded to:
- stop running if there is an error.
- stop running if the input is not a dataframe.
- stop running if the input dataframe 'df' doesn't contain the variable 'register' that is of class character or the variable 'date' that is of class date.
by testing the expectation that:
- the code has run without an error.
- an error is produced if a suitable dataset is not input, e.g. if an integer is input as the dataset or without the variables 'register' or 'date'.
- the output is consistent with what we'd get if we manually did in excel.
3) Run test using command+shift+t (it can be good to write something so the test should fail to begin to check the procedure is working).
You can additionally test figures e.g. plots to see whether they look like they should by using the package vdiffr (in CRAN and compatible with the testthat package).

COULD DEVELOP a function like https://github.com/mammykins/regregrap/blob/master/R/figure_1.R and then do unit test like https://github.com/mammykins/regregrap/blob/master/tests/testthat/test_figure_1.R 
