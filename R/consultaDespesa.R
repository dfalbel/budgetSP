#' consultaDespesa Get
#'
#' Get data from the webservice.
#'
#' @param ano ano
#' @param codigoOrgao codigoOrgao
#' @param ... other arguments passed to httr::POST.
#'
#' @examples
#' \dontrun{
#' consulta <- consultaDespesa_get(ano = 2016, codigoOrgao = "42000")
#' # You can save the result to a xml file using:
#' consultaDespesa_get(ano = 2016, codigoOrgao = "42000", httr::write_disk("file.xml"))
#' }
#'
#' @export
consultaDespesa_get <- function(ano, codigoOrgao = "Consolidado", ...,
                                codigoUo = "",codigoUnidadeGestora = "",
                                codigoFonteRecursos = "",
                                codigoTipoLicitacao = "",
                                codigoFuncao = "", codigoSubfuncao = "",
                                codigoPrograma = "", codigoAcao = "",
                                codigoFuncionalProgramatica = "",
                                codigoMunicipio = "", codigoCategoria = "",
                                codigoGrupo = "", codigoModalidade = "",
                                codigoElemento = "", naturezaDespesa = "",
                                flagCredor = 0, cgcCpfCredor = "",
                                nomeCredor = "", flagEmpenhado = 1,
                                flagLiquidado = 0, flagPago = 0
                                ){
  httr::POST(
    url = "https://webservices.fazenda.sp.gov.br/WSTransparencia/TransparenciaServico.asmx?",
    httr::add_headers(SOAPAction= "http://fazenda.sp.gov.br/wstransparencia/ConsultarDespesas",
                Accept = "text/xml",  'Content-Type' = "text/xml; charset=utf-8"),
    body = consultaDespesa_body(ano, codigoOrgao),
    ...
  )
}

#' consultaDespesa Body
#'
#' Generates the BODY for the soap request for
#' consultaDespesa
#'
#' @param ano ano
#' @param codigoOrgao codigoOrgao
#'
consultaDespesa_body <- function(ano, codigoOrgao = "Consolidado",
                                 codigoUo = "",codigoUnidadeGestora = "",
                                 codigoFonteRecursos = "",
                                 codigoTipoLicitacao = "",
                                 codigoFuncao = "", codigoSubfuncao = "",
                                 codigoPrograma = "", codigoAcao = "",
                                 codigoFuncionalProgramatica = "",
                                 codigoMunicipio = "", codigoCategoria = "",
                                 codigoGrupo = "", codigoModalidade = "",
                                 codigoElemento = "", naturezaDespesa = "",
                                 flagCredor = 0, cgcCpfCredor = "",
                                 nomeCredor = "", flagEmpenhado = 1,
                                 flagLiquidado = 0, flagPago = 0
                                 ){
  paste0(
    '<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Header>
    <AutenticacaoHeader xmlns="http://fazenda.sp.gov.br/wstransparencia">
    <Usuario></Usuario>
    <Senha></Senha>
    </AutenticacaoHeader>
    </soap:Header>
    <soap:Body>
    <ConsultarDespesas xmlns="http://fazenda.sp.gov.br/wstransparencia">
      <ano>',ano,'</ano>
      <codigoOrgao>',codigoOrgao,'</codigoOrgao>
      <codigoUo>',codigoUo,'</codigoUo>
      <codigoUnidadeGestora>',codigoUnidadeGestora,'</codigoUnidadeGestora>
      <codigoFonteRecursos>',codigoFonteRecursos,'</codigoFonteRecursos>
      <codigoTipoLicitacao>',codigoTipoLicitacao,'</codigoTipoLicitacao>
      <codigoFuncao>',codigoFuncao,'</codigoFuncao>
      <codigoSubfuncao>',codigoSubfuncao,'</codigoSubfuncao>
      <codigoPrograma>',codigoPrograma,'</codigoPrograma>
      <codigoAcao>',codigoAcao,'</codigoAcao>
      <codigoFuncionalProgramatica>',codigoFuncionalProgramatica,'</codigoFuncionalProgramatica>
      <codigoMunicipio>',codigoMunicipio,'</codigoMunicipio>
      <codigoCategoria>',codigoCategoria,'</codigoCategoria>
      <codigoGrupo>',codigoGrupo,'</codigoGrupo>
      <codigoModalidade>',codigoModalidade,'</codigoModalidade>
      <codigoElemento>',codigoElemento,'</codigoElemento>
      <naturezaDespesa>',naturezaDespesa,'</naturezaDespesa>
      <flagCredor>',flagCredor,'</flagCredor>
      <cgcCpfCredor>',cgcCpfCredor,'</cgcCpfCredor>
      <nomeCredor>',nomeCredor,'</nomeCredor>
      <flagEmpenhado>',flagEmpenhado,'</flagEmpenhado>
      <flagLiquidado>',flagLiquidado,'</flagLiquidado>
      <flagPago>',flagPago,'</flagPago>
    </ConsultarDespesas>
    </soap:Body>
    </soap:Envelope>'
  )
}

#' consultaDespesa Parse
#'
#' Parse results from consultaDespesa.
#'
#' @param xml a xml document (a path to a xml file or a connection returned by
#' consultaDespesa or a file read by read_xml function)
#'
#' @export
consultaDespesa_parse <- function(xml){

  if(class(xml) == "character"){
    xml <- xml2::read_xml(xml)
  } else if(class(xml) == "response"){
    xml <- httr::content(xml, "parsed")
  }

  itens <- xml %>%
    xml2::xml_child("soap:Body") %>%
    xml2::xml_child("d1:ConsultarDespesasResponse") %>%
    xml2::xml_child("d1:ConsultarDespesasResult") %>%
    xml2::xml_child("d1:ListaItensDespesa") %>%
    xml2::xml_children()

  fields <- consultaDespesa_fields()
  dados <- purrr::map_df(fields, ~get_child(itens, .x))
  dados <- dados[-nrow(dados),]
  dados <- dplyr::mutate_at(dados, dplyr::vars(dplyr::starts_with("Valor")), to_numeric)

  return(dados)
}

#' consultaDespesa Fields
#'
#' Fields available in the consultaDespesa webservice.
#'
#' @export
consultaDespesa_fields <- function(){
  campos <- c("CodigoNomeOrgao", "CodigoNomeUo", "CodigoNomeUg",
              "CodigoNomeFonteRecursos", "CodigoNomeTipoLicitacao",
              "CodigoNomeFuncao", "CodigoNomeSubFuncao", "CodigoNomePrograma",
              "CodigoNomeAcao", "CodigoNomeProgramaTrabalho",
              "CodigoNomeMunicipio", "CgcCpfFavorecido", "CodigoNomeElemento",
              "NaturezaDespesaNomeItem", "ValorDotacaoInicial", "ValorEmpenhado",
              "ValorLiquidado", "ValorPago", "ValorPagoAnosAnteriores"
  )
  names(campos) <- campos
  return(campos)
}

#' get_child
#'
#' An util that gets the child of all itens.
#'
#' @param itens itens xml_nodeset.
#' @param child name of the field to get
#'
get_child <- function(itens, child){
  itens %>% xml2::xml_child(sprintf("d1:%s", child)) %>% xml2::xml_text()
}

#' to_numeric
#'
#' An utility function to parse text to numeric.
#'
#' @param x convert x to numeric
#'
to_numeric <- function(x){
  readr::parse_number(x, locale = readr::locale(decimal_mark = ","))
}
