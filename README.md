[![Build Status](https://travis-ci.org/M3SOulu/RSentiStrength.svg?branch=master)](https://travis-ci.org/M3SOulu/RSentiStrength)

# RSentiStrength

This packages contain functions for
running [SentiStrength](http://sentistrength.wlv.ac.uk) from R.

## Installation

With devtools:

    devtools::install_github("M3SOulu/RSentiStrength")

## Running SentiStrength

As SentiStrength is not open source, it is not bundled with the
package. In order to use it, one must first get the original
SentiStrength jar file and language data from the
[original SentiStrength authors](http://sentistrength.wlv.ac.uk).

They can be copied in the package installation directory using the
following R functions:

    library(RSentiStrength)
    SentiStrengthJar("/path/to/sentistrength.jar")
    AddSentiStrengthData("/path/to/sentistrength/language/data")

Then SentiStrength can be run on a character vector like this:

    SentiStrength(c("I am happy", "I am sad"))

By default, the output is parsed and stored in a data.table object
with two columns (min and max) and the same number of rows as the
length of the input vector.

Multiple variants of SentiStrength language data can be added by
modifying the datadir argument of AddSentiStrengthData:

    AddSentiStrengthData("/path/to/sentistrength/english/data", "sentidata_en")
    AddSentiStrengthData("/path/to/sentistrength/finnish/data", "sentidata_fi")

    SentiStrength("English text", "sentidata_en")
    SentiStrength("Suomen teksti", "sentidata_fi")

## Arousal lexicon for software engineering domain

The package comes with a custom language data folder, similar
to [TensiStrength](http://sentistrength.wlv.ac.uk/TensiStrength.html)
but based on our lexicon for measuring arousal in software engineering
textual data. It can be used like this:

    SentiStrength("English text", "tensidata_softeng")

If you use it for research purpose, please cite the
following paper:

    Mäntylä, M. V., Novielli, N., Lanubile, F., Claes, M., & Kuutila,
    M. (2017, May). Bootstrapping a lexicon for emotional arousal in
    software engineering. In 2017 IEEE/ACM 14th International
    Conference on Mining Software Repositories (MSR)
    (pp. 198-202). IEEE.

## Credits

This package only contains a few dozen lines of R code and most of the
credits go to the original SentiStrength authors:

    Thelwall, M., Buckley, K., Paltoglou, G., Cai, D., & Kappas,
    A. (2010). Sentiment strength detection in short informal
    text. Journal of the American society for information science and
    technology, 61(12), 2544-2558.
