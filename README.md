# rpackage_training
Making and developing R packages for RAP (Reproducible Analytical Pipelines)

# 1. Introduction

This training is based on Matthew Gregory's free online course 'Reproducible Analytical Pipelines (RAP) using R' (see https://www.udemy.com/reproducible-analytical-pipelines/) and Hadley Wickham's book 'R Packages' (see http://r-pkgs.had.co.nz/)

The goal of this training is to teach you how to develop packages with a particular emphasis on RAP. Thankfully they are not difficult to make.

Hadley Wickham's introduction (http://r-pkgs.had.co.nz/intro.html) states: "Packages are the fundamental units of reproducible R code. They include reusable R functions, the documentation that describes how to use them, and sample data."  The minimal contents of a package include: functions, tests, documentation and data (which can be made up where real data are sensitive). Within an R package (e.g. https://github.com/DCMSstats/eesectors): 

- R code is in the directory 'R'; 
- data in 'data'; 
- documentation in 'man'; 
- QA in 'tests'; 
- dependency management in 'packrat'; and 
- templates on how to use the package in 'vignettes'.

There are benefits to each statistical production using RAP being within a package.   

# 2. Choose a name

Possibly the hardest part of creating a package is choosing a name for it. This should be both short and unique (for google searches) and include either upper or lower case characters but not a mixture of them. If the package is to do some RAP work, we may want to consider putting 'rap' at end of the name. 

You can read more about naming a package in the 'Naming your package' section of http://r-pkgs.had.co.nz/package.html 

In this training we're going to create a package to RAP the short statistical bulletin that we create as part of the Rmarkdown training - see https://github.com/moj-analytical-services/rmarkdown_training  As such you could choose a name such as egnamerap where the eg is because it's a training exercise, the name is your first name (if not the same as someone else's) and the rap because you are going to RAP a short statistical bulletin.

Exercise 1: Decide what name to call your package

# 3. Create github repository 

Guidance to create a new github repository is at https://moj-analytical-services.github.io/platform_user_guidance/github.html#step-1---create-a-new-project-repo-in-the-moj-analytical-services-github-page

Exercise 2: Follow the guidance to create a new github repository, giving it the same name as you've decided to call your package (in my case 'egaidanrap') and a suitable description (in my case 'Aidan's RAP training exercise').

# 4. Load into R as a project

Guidance to make a copy of the project in R Studio is at  https://moj-analytical-services.github.io/platform_user_guidance/github.html#step-1-navigate-to-your-platform-r-studio-and-make-a-copy-of-the-github-project-in-your-r-studio

Exercise 3: Follow the guidance load into R as a project.

# 5. Create the package 

You can create a package by taking the following steps:

- Install the package devtools if you haven't already (click on Packages, Install, type in devtools and click on Install). 
- Run the command 'devtools::create("path/to/package/pkgname")' and select the option to overwrite what is already there.

You can now see in the 'Files' window that there are additions in your project directory.

Exercise 4: Follow the above steps, replacing "path/to/package/pkgname" by the correct directory path. Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the additions there.

# 6. Amend the DESCRIPTION file

A bare-bones DESCRIPTION file has been created which stores important metadata about your package including the packages that your package needs to work. You can click on the DESCRIPTION filename in the file window and then amend it as appropriate. 

To see an example of an amended DESCRIPTION file see: https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION Take note of the formatting e.g. the Title is a one liner and doesn't end in a period. 

You can read more about the most important DESCRIPTION fields at: http://r-pkgs.had.co.nz/description.html These include the Authors@R field which has a three letter code specifying the role, the most useful being:

- cre: the creator or maintainer, the person you should bother if you have problems.
- aut: authors, those who have made significant contributions to the package.
- ctb: contributors, those who have made smaller contributions, like patches.
- cph: copyright holder. This is used if the copyright is held by someone other than the author, typically a company (i.e. the author’s employer).

You should also list the packages that your package needs to work; generally use the Imports rather than Depends command to do this. Unless you have greater knowledge, require the package version to be greater than or equal to the version you’re currently using.

Exercise 5: Amend the DESCRIPTION file, specifically the Title, Authors@R, Description and package dependency text (we need ggplot2 and dplyr). Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the amendments there.

# 7. Preventing sensitive data being pushed to git 

You can use the gitignore file to specify data files so that they cannot to be pushed to git. Simply open the gitignore file and add the name of the file (e.g. sensitive.txt). If you want to specify a file that's not to be ignored then add an exclamation mark in front of it's name e.g. '!sensitive.txt'. 

A template gitignore that ukgovdatascience have done and is free to copy from is at: https://github.com/ukgovdatascience/dotfiles

You can also use git hooks which check for certain datafiles and prevent a git push going ahead unless you give specific approval. More guidance about these hooks is available at the above ukgovdatascience link

Exercise 6: Upload or copy crimedata2.csv into your package Rstudio folder. Then amend the gitignore file to include the code in https://github.com/ukgovdatascience/dotfiles/blob/master/.gitignore After pushing to github can you see crimedata2.csv? Then additionally specify crimedata2.csv as a file not to be ignored at the end of the gitignore file. After pushing to github can you now see it?

# 8. Adding raw data as an RDA object

Raw data should be a minimal tidy data set. Tidy datasets are easy to manipulate, model and visualise, and have a specfic structure; each variable is a column, each observation a row, and each type of observational unit is a table. 

If the data are non-sensitive, then they should be included within the package as they make it easier for you and collaborators to help develop functions and test your package. If the data are sensitive, then create some fake data instead.

It is beneficial for your data to be within .rda files which store R objects in a format native to R. Compared with e.g. write.csv it:

- Is faster to restore the data to R
- Keeps R specific information encoded in the data (e.g., attributes, variable types, etc).

If the raw data needs some manipulating to make them more nicely formatted then this code should be included within the package for the sake of reproducability.  To create a nice RDA object:

    Place the raw data into a sub-directory you make called 'data-raw' in your project Rstudio folder.
    Create a new script in this folder with the following contents:
        raw <- read.csv("data_name.csv", check.names = TRUE)
        devtools::use_data(raw)  
        rm(raw)
        save the script  e.g. as create_raw.R

Now you'll see a data folder has been created that contains the object raw.rda

To develop this code, it is wise to consider two extra steps (section 2.16 in MOOC):
1. Add a line if a variable should be a factor variable rather than the default (unless number) read_csv character variable e.g.raw$phase <- as.factor(raw$phase)
2. Add an overwrite=TRUE to the use_data function if when the input raw dataset is amended you want to overwrite the existing RDA object.
devtools::use_data(raw, overwrite = TRUE)  

When you make changes to your package and want to see the effect of these, you can run the following code which reloads all the changes you have made to your code:  devtools::load_all(".") 
