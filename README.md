
<!-- README.md is generated from README.Rmd. Please edit that file -->
budgetSP
========

[![Travis-CI Build Status](https://travis-ci.org/dfalbel/budgetSP.svg?branch=master)](https://travis-ci.org/dfalbel/budgetSP)

Installation
------------

You can install budgetSP from github with:

``` r
# install.packages("devtools")
devtools::install_github("dfalbel/budgetSP")
```

Using
-----

The simplest use of the package is:

``` r
library(budgetSP)
httr::set_config(httr::config(ssl_verifypeer = 0L))
consultaDespesa_get(ano = 2016, codigoOrgao = "01000") %>%
  consultaDespesa_parse()
#> # A tibble: 172 × 19
#>                   CodigoNomeOrgao                   CodigoNomeUo
#>                             <chr>                          <chr>
#> 1  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 2  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 3  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 4  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 5  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 6  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 7  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 8  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 9  01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> 10 01000 - ASSEMBLEIA LEGISLATIVA 01001 - ASSEMBLEIA LEGISLATIVA
#> # ... with 162 more rows, and 17 more variables: CodigoNomeUg <chr>,
#> #   CodigoNomeFonteRecursos <chr>, CodigoNomeTipoLicitacao <chr>,
#> #   CodigoNomeFuncao <chr>, CodigoNomeSubFuncao <chr>,
#> #   CodigoNomePrograma <chr>, CodigoNomeAcao <chr>,
#> #   CodigoNomeProgramaTrabalho <chr>, CodigoNomeMunicipio <chr>,
#> #   CgcCpfFavorecido <chr>, CodigoNomeElemento <chr>,
#> #   NaturezaDespesaNomeItem <chr>, ValorDotacaoInicial <dbl>,
#> #   ValorEmpenhado <dbl>, ValorLiquidado <dbl>, ValorPago <dbl>,
#> #   ValorPagoAnosAnteriores <dbl>
```
