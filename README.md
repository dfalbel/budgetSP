
<!-- README.md is generated from README.Rmd. Please edit that file -->
budgetSP
========

[![Travis-CI Build Status](https://travis-ci.org/dfalbel/budgetSP.svg?branch=master)](https://travis-ci.org/dfalbel/budgetSP) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/dfalbel/budgetSP?branch=master&svg=true)](https://ci.appveyor.com/project/dfalbel/budgetSP)

Installation
------------

You can install budgetSP from github with:

``` r
# install.packages("devtools")
devtools::install_github("dfalbel/budgetSP")
```

consultaDespesa
---------------

This service mimics the *point & click* service that can be accessed [here](https://www.fazenda.sp.gov.br/SigeoLei131/Paginas/FlexConsDespesa.aspx). A technical manual can be found [here](https://github.com/dfalbel/budgetSP/blob/master/inst/WebserviceTransparenciaManual.pdf).

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

Parameters
==========

Possible values of parameters are:

-   **ano**: 2010 to 2016
-   **codigoOrgao**: all possible values [here](https://github.com/dfalbel/budgetSP/blob/master/inst/codigoOrgao.csv)
-   **codigoUo**: all possible values [here](https://github.com/dfalbel/budgetSP/blob/master/inst/codigoUo.csv)
-   **codigoUnidadeGestora**: all possible values [here](https://github.com/dfalbel/budgetSP/blob/master/inst/codigoUnidadeGestora.csv)
