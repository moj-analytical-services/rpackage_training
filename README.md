# rpackage_training
Making and developing R packages for RAP (Reproducible Analytical Pipelines)

# 1. Introduction

This training is based on Matthew Gregory's free online course 'Reproducible Analytical Pipelines (RAP) using R' (see https://www.udemy.com/reproducible-analytical-pipelines/) and Hadley Wickham's book 'R Packages' (see http://r-pkgs.had.co.nz/)

The goal of this training is to teach you how to develop packages with a particular emphasis on RAP. Thankfully they are not difficult to make. To maximise it please do the exercises which enable you to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training - see https://github.com/moj-analytical-services/rmarkdown_training. You can then apply the same skills to your real life publications.

There are benefits to the RAP for each statistical publication being within a package. Hadley Wickham's introduction (http://r-pkgs.had.co.nz/intro.html) states: "Packages are the fundamental units of reproducible R code. They include reusable R functions, the documentation that describes how to use them, and sample data."  The package should also include tests and data (which can be made up if real data are sensitive). Within an R package (e.g. https://github.com/DCMSstats/eesectors): 

- R code is in the directory 'R' (this is compulsory); 
- documentation is in 'man' (this is compulsory); 
- data are in 'data'; 
- tests are in 'tests'; 
- dependency management is (if using packrat) in 'packrat'; and 
- templates on how to use the package are in 'vignettes'.

# 2. Choose a name

Possibly the hardest part of creating a package is choosing a name for it. This should: 

- be short; 
- be unique (for google searches); 
- include either upper or lower case characters but not a mixture of them; 
- make clear what the package does e.g. if to do some RAP work, consider putting 'rap' at end of the name. 

You can read more about naming a package in the 'Naming your package' section of http://r-pkgs.had.co.nz/package.html 

As we're going to develop a package for the minimal statistical bulletin created as part of the Rmarkdown training (see https://github.com/moj-analytical-services/rmarkdown_training) choose a name such as egnamerap where the eg is because it's a training exercise, the name is your first name (if not the same as someone else's) and the rap because you are going to RAP a minimal statistical bulletin.

Exercise 1: Decide what name to call your package

# 3. Create github repository 

Guidance to create a new github repository is at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#creating-your-project-repo-on-github

Exercise 2: Follow the guidance to create a new github repository, giving it the same name as you've decided to call your package (see previous section) and a suitable description (e.g. 'My RAP training exercise'). As this is a training exercise you can leave the default setting of your repository (see Step 2) as PRIVATE so it’s only visible to you as the creator.

# 4. Make a copy of the project in R Studio

Guidance to make a copy of the project in R Studio is at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio

Exercise 3: Follow Step 1 of the guidance to make a copy of the project in R Studio.

# 5. Create the package 

You can create a package by taking the following steps:

- Install the package devtools if you haven't already (click on Packages, Install, type in devtools and click on Install). 
- Run the command 'devtools::create("path/to/package/pkgname")' and select the option to overwrite what is already there.

You can now see in the 'Files' window that there are additions in your project directory.

Exercise 4: Follow the above steps, inserting the correct directory path and package name within the create command. Lastly, follow Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio, committing your changes to git and then pushing them to github.com. If you refresh your github.com repository page you should now see the additions there.

# 6. Add R and Rmarkdown code 

Any R and R Markdown code to be within the package should be saved into it. The R code can be saved to the package R/ directory while the R Markdown code can be saved to the package home directory.

Exercise 5: Add the crimesdata_pub.Rmd to your package

# 7. Amend the DESCRIPTION file

The DESCRIPTION file is one of two files automatically created when you run the create command (see above section), the other being the NAMESPACE file (more about this later). It provides important metadata about the package. You can click on the DESCRIPTION filename in the file window and then amend it as appropriate. 

To view an example of an amended DESCRIPTION file see: https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION Take note of the formatting. Each line consists of a field name and a value, separated by a colon. When values span multiple lines, they need to be indented. In particular:

- The Title is a one line description of the package - keep short, capitalised like a title and less than 65 characters.
- The Version should be amended when you update the package
- The Authors@R field which has a three letter code specifying the role, the most useful being:
   - cre: the package maintainer, the person you should contact if you have problems.
   - aut: authors, those who have made significant contributions to the package.
   - ctb: contributors, those who have made smaller contributions, like patches.
   - cph: copyright holder. This is used if the copyright is held by someone other than the author, typically a company (i.e. the author’s employer).
- The Depends and Imports fields allow you to list the packages that your package needs to work; apart from the version of R generally use the Imports rather than Depends command to do this. Unless you have greater knowledge, require the package version to be greater than or equal to the version you’re currently using.
- The Description is more detailed than the Title - one paragraph with each line upto 80 characters

You can read more about the most important DESCRIPTION fields at: http://r-pkgs.had.co.nz/description.html 

Exercise 6: Amend the DESCRIPTION file, specifically the Title, Authors@R, Description and package dependency text (we need ggplot2 and dplyr). Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the amendments there.

# 8. Excluding sensitive data 

The best way to ensure you don't accidentally push any sensitive data to github.com is not to store them within your R Studio copy of the repository. There is also a second layer of protection that you should set up to prevent the package containing any sensitive information. 

The gitignore file can be amended to specify any sensitive data files so that they cannot to be pushed to git. This can be done by opening the gitignore file and adding the name of the file (e.g. confidential.txt). If there's a file that's not to be ignored then add an exclamation mark in front of its name e.g. '!unconfidential.txt'. 

A link to a template gitignore that ukgovdatascience have done and which is free to copy, use and amend as appropriate is at: https://github.com/ukgovdatascience/dotfiles

You can also use git hooks which check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about these hooks is available at: https://github.com/ukgovdatascience/dotfiles

Exercise 7: Place a copy of crimedata2.csv into your package Rstudio folder. Then amend the gitignore file to include the code in https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore After committing and pushing to github (Steps 2 and 3 at https://user-guidance.services.alpha.mojanalytics.xyz/github.html#r-studio) can you see crimedata2.csv? Then additionally specify crimedata2.csv as a file not to be ignored at the end of the gitignore file. After pushing to github can you now see it?

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

Exercise 8: Make an .RData file of 'crimesdata2.csv' by following the above steps (including calling it 'raw'). 

# 10. Adding documentation

Documentation is really important so users know how to use the package and so creators (who may forget the details) and developers can quickly get up to speed. It should therefore be embedded within the package in such a way that it is easily available to all users. Documentation about data sets within the package should be provided in a separate R script while that for an function can be held within the same R script. All documentation for the package should be held within the R folder. 

Documentation can be added for data sets within a package by creating an data.R file. You can view an example data.R file in the eesectors package at https://github.com/DCMSstats/eesectors/blob/master/R/data.R; this makes use of the package roxygen2 to automatically turn the formated comments into nice looking documentation.

Looking at the first 22 rows you can see a title, subtitle, the format of the data, a description of each of the variables, the source location, the keywords and at the bottom what the data object is called (within speech marks).  

After adding or amending documentation in .R files, the following command can be used to create more complicated code (.Rd) files in the man folder, which then enables users to view nice looking documentation through the help facility:

    devtools::document(roclets=c('rd', 'collate', 'namespace'))

The documentation can then be viewed in the help facility using the usual help facility command i.e.:

    ?objectname

To read more about documentation more generally go to: http://r-pkgs.had.co.nz/man.html, and for data objects specifically: http://r-pkgs.had.co.nz/data.html#documenting-data  

Exercise 9: Amend the DESCRIPTION file to add roxygen2 to the package dependency text. Then create an data.R file in your R folder and paste in the first 22 rows from the one in the eesectors package. Amend the contents, update your package and check out the documentation you have created. Lastly, push to github.

# 11. Automated input data quality assurance checks

We should check the input data contains the correct columns and that the number of rows is more than the minimum expected.

You can copy https://github.com/ukgovdatascience/eesectors/blob/master/R/year_sector_data.R and adjust for your purposes. The roxygen2 documentation appears at the top of the file. It may also be helpful to:

- add plots so the user can see for themselves from automatically produced plots that things look fine.  
- add name lookups e.g. any charts will have nice labels (e.g. the first letter being a capital and the others being lower case).
- drop any variables you won't need.
- create the final data set as of class 'file/function_name' (see the end of https://github.com/mammykins/regregrap/blob/master/R/phase_date_data.R)

To run these checks, use the code:

    x <- pkgname::file/function_name(dataset_name)


