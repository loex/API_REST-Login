#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "RESTFUL.CH"

/*/{Protheus.doc} PRLG01AA
//TODO Descri��o auto-gerada.
@author author
@since 25/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Function u_PRLG01AA
Return

/*/{Protheus.doc} ACESSO
//TODO Descri��o auto-gerada.
@author User
@since 25/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/

WSRESTFUL ACESSO DESCRIPTION "Servi�o responsavel por retornar a situa��o cadastral dos motoristas no protheus"

	WSDATA CGC	    As String // Armazena o CGC para acesso
	WSDATA DATANASC As String // Pega a data de nascimento para acesso
	
	WSMETHOD GET  DESCRIPTION "Retorna Funcionarios" 	WSSYNTAX ""

ENDWSRESTFUL

/*/{Protheus.doc} GET
//TODO Descri��o auto-gerada.
@author User
@since 25/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/

WSMETHOD GET WSRECEIVE CGC,DATANASC  WSSERVICE ACESSO
	
	Local lRet          := .T. 
	Local aArea         := GetArea()
	Local cJson         := ""
	Local cCGC          := Self:CGC
	Local dDataNasc     := Self:DATANASC
	Local oFuncionario := Funcionario():New()
	//Local oResponse     := Response:New()
	
	oResponse := oFuncionario:RETSITFOL(cCGC,dDataNasc) 
	  
	::SetContentType("application/json")	
	
	cJson := FWJsonSerialize(oResponse)
	
	::SetResponse(cJson)
	
	RestArea(aArea)
	
	// --> Deserializa a string JSON
	FWJsonDeserialize(cJson, @oResponse)
	
Return(lRet)