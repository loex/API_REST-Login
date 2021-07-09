#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} PRLG01AB
//TODO Descrição auto-gerada.
@author author
@since 25/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Function u_PRLG01AB
Return

/*/{Protheus.doc} Funcionario
//TODO Descrição auto-gerada.
@author User
@since 30/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/

Class Funcionario
	
	//DATA aFuncionario As Array
	DATA cMatricula   As String
	DATA cNome        As String
	DATA cSitFol      As String
	DATA cCIC         As String
	DATA cNasc        As String
	
	Method New() Constructor
	Method RETSITFOL()
	Method FREECLASS()

EndClass

/*/{Protheus.doc} New
//TODO Descrição auto-gerada.
@author author
@since 30/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Method New() Class Funcionario
	//Self:aFuncionario := {}
	Self:cMatricula   := ""
	Self:cNome        := ""
	Self:cSitFol      := ""
	Self:cCIC         := "" 
	Self:cNasc        := ""	
Return(Self)

/*/{Protheus.doc} RETSITFOL
//TODO Descrição auto-gerada.
@author author
@since 30/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Method RETSITFOL(pCGC,pDATANASC) Class Funcionario

	Local cCGC      := pCGC
	Local cDataNasc := pDATANASC
	Local oRet     
	
	oRet := CONSFUNSRA(cCGC,cDataNasc)      

Return (oRet)

/*/{Protheus.doc} CONSFUNSRA
//TODO Descrição auto-gerada.
@author author
@since 30/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Static Function CONSFUNSRA(pCGC,pDataNasc)

	Local cCGC         := pCGC
	Local cDataNasc    := pDATANASC
	Local cAlFunc      := GetNextAlias()
	Local aRet         := {}
	Local nQtde        := 0
	Local oFuncionario := Funcionario():New() 
	
	//Efetua a consulta do funcionario	
	BeginSql Alias cAlFunc
	
		SELECT RA_MAT,
		       RA_NOME,
		       RA_SITFOLH,
		       RA_CIC,
		       RA_NASC,
		       RA_TIPOADM 
		FROM   %Table:SRA%
		WHERE  %NOTDEL%
		AND    RA_CIC  = %Exp:cCGC%
		AND    RA_NASC = %Exp:cDataNasc%
		 
	EndSql
	
	If !(cAlFunc)->(Eof())		
	
		DbSelectArea(cAlFunc)
		Count to nQtdReg
		(cAlFunc)->(DbGoTop())	
		
		While !(cAlFunc)->(Eof())			
			If nQtdReg = 1 		
				oFuncionario:cMatricula := (cAlFunc)->RA_MAT
				oFuncionario:cNome      := (cAlFunc)->RA_NOME
				oFuncionario:cSitFol    := (cAlFunc)->RA_SITFOLH
				oFuncionario:cCIC       := (cAlFunc)->RA_CIC 
				oFuncionario:cNasc      := (cAlFunc)->RA_NASC 
				//aAdd(aRet,{(cAlFunc)->RA_MAT,(cAlFunc)->RA_NOME,(cAlFunc)->RA_SITFOLH,(cAlFunc)->RA_CIC,(cAlFunc)->RA_NASC})
			Else				
				If RA_TIPOADM == "9C"
					oFuncionario:cMatricula := (cAlFunc)->RA_MAT
					oFuncionario:cNome      := (cAlFunc)->RA_NOME
					oFuncionario:cSitFol    := (cAlFunc)->RA_SITFOLH
					oFuncionario:cCIC       := (cAlFunc)->RA_CIC 
					oFuncionario:cNasc      := (cAlFunc)->RA_NASC				
					//aAdd(aRet,{(cAlFunc)->RA_MAT,(cAlFunc)->RA_NOME,(cAlFunc)->RA_SITFOLH,(cAlFunc)->RA_CIC,(cAlFunc)->RA_NASC})
				EndIf				
			EndIf				
			(cAlFunc)->(DbSkip())
		EndDo	
	Else
		aAdd(aRet,{"SRA Empty"})
	EndIf
	
	(cAlFunc)->(DbCloseArea())

Return(oFuncionario)

/*/{Protheus.doc} FREECLASS
//TODO Descrição auto-gerada.
@author author
@since 30/10/2018
@version version
@example
(examples)
@see (links_or_references)
/*/

Method FREECLASS() Class Funcionario
Return FreeObj(Self)