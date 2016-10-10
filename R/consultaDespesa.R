#' consultaDespesa
#'
#' @param ano ano
#' @param codigoOrgao codigoOrgao
#'
consultaDespesa <- function(ano, codigoOrgao = "Consolidado", ...){
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
consultaDespesa_body <- function(ano, codigoOrgao = "Consolidado"){
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
    <codigoUo></codigoUo>
    <codigoUnidadeGestora></codigoUnidadeGestora>
    <codigoFonteRecursos></codigoFonteRecursos>
    <codigoTipoLicitacao></codigoTipoLicitacao>
    <codigoFuncao></codigoFuncao>
    <codigoSubfuncao></codigoSubfuncao>
    <codigoPrograma></codigoPrograma>
    <codigoAcao></codigoAcao>
    <codigoFuncionalProgramatica></codigoFuncionalProgramatica>
    <codigoMunicipio></codigoMunicipio>
    <codigoCategoria></codigoCategoria>
    <codigoGrupo></codigoGrupo>
    <codigoModalidade></codigoModalidade>
    <codigoElemento></codigoElemento>
    <naturezaDespesa></naturezaDespesa>
    <flagCredor>0</flagCredor>
    <cgcCpfCredor></cgcCpfCredor>
    <nomeCredor></nomeCredor>
    <flagEmpenhado>1</flagEmpenhado>
    <flagLiquidado>0</flagLiquidado>
    <flagPago>0</flagPago>
    </ConsultarDespesas>
    </soap:Body>
    </soap:Envelope>'
  )
}
