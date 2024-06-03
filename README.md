

# Quarto split languages


- [What this is for](#what-this-is-for)
- [Using the language filter script](#using-the-language-filter-script)
  - [Installing](#installing)
  - [Usage](#usage)

<!-- README.md is generated from README.qmd. Please edit that file -->

## What this is for

Developing notebooks on Google Colab sucks. However, when you need to
teach a course in R or Python, Colab makes it a lot easier for the
students to get started (and for the teachers who don’t have to run
around cosplay an IT department). So I like to work in Quarto as long as
possible and then use this addon to make 3 versions of my notebooks:

1.  A Python version with just the Python code.
2.  An R version with just the R code.
3.  An HTML version with both.

As Colab supports only one language at a time, this seems to make most
sense.

## Using the language filter script

### Installing

``` bash
quarto add JBGruber/quarto-targetlang
```

Using {quarto-wordcount} requires Quarto version \>= 1.3.0

This will install the extension under the `_extensions` subdirectory. If
you’re using version control, you will want to check in this directory.

### Usage

Colab expects ipynb. This extension provides a special format which
takes the argument `target_lang` in the YAML header, and removes all
code chunks that do not fit this language:

``` yaml
format:
  targetlang-ipynb: 
    toc: false
    filters: 
      - langsplit.lua
  html: default
target_lang: "r"
```

You can render this from RStudio if you want. Or, what is even easier is
to run it from the command line, using quarto-cli:

``` bash
quarto render template.qmd --no-execute --to targetlang-ipynb -o template-py.ipynb --metadata target_lang:python
quarto render template.qmd --no-execute --to targetlang-ipynb -o template-r.ipynb --metadata target_lang:r
quarto render template.qmd --to html
```

Alternatively, there is also a `quarto` R package:

``` r
library(quarto)
library(quarto)
quarto_render(input = "template.qmd", output_format = "targetlang-ipynb", output_file = "template-py.ipynb", execute = FALSE, metadata = list(target_lang = "python"))
quarto_render(input = "template.qmd", output_format = "targetlang-ipynb", output_file = "template-r.ipynb", execute = FALSE, metadata = list(target_lang = "r"))
quarto_render(input = "template.qmd", output_format = "html")
```