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

You can read more about naming a package in the 'Naming your package' section of  http://r-pkgs.had.co.nz/package.html 

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

A bare-bones DESCRIPTION file has been created which stores important metadata about your package. You can click on the DESCRIPTION filename in the file window and then amend it as appropriate. To see an example of an amended DESCRIPTION file see: https://github.com/DCMSstats/eesectors/blob/master/DESCRIPTION 

Exercise 5: Amend the DESCRIPTION file, amending the Title, Authors and Description text. Lastly, push back to git (click on Git and then Push). You can now refresh your github repository page and see the amendments there.
