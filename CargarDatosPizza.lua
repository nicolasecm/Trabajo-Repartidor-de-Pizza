local ValorPorEntrega = nil
local ValorPorFinEntregas = nil
local ValorMinimoPropina = nil
local ValorMaximoPropina = nil

function InicioResourceVG()
if source ~= getResourceRootElement() then return end
Archivo = xmlLoadFile ( "config.xml", true) 
if Archivo then
		local XmlValorEntrega = xmlFindChild(Archivo,"ValorPorEntrega",0)
		local XmlValorFinEntrega = xmlFindChild(Archivo,"ValorPorFinEntregas",0)
		local XmlValorMinProp = xmlFindChild(Archivo,"ValorMinimoPropina",0)
		local XmlValorMaxProp = xmlFindChild(Archivo,"ValorMaximoPropina",0)
		ValorPorEntrega = xmlNodeGetValue (XmlValorEntrega)
		ValorPorFinEntregas = xmlNodeGetValue (XmlValorFinEntrega)
		ValorMinimoPropina = xmlNodeGetValue (XmlValorMinProp)
		ValorMaximoPropina = xmlNodeGetValue (XmlValorMaxProp)
		xmlUnloadFile(Archivo)
else
	outputChatBox ( "Error al cargar los datos de config.xml" )
end
end
addEventHandler ( "onClientResourceStart", root, InicioResourceVG )

addEvent( "SolicitarDatosXmlPizza", true)
addEventHandler( "SolicitarDatosXmlPizza", getRootElement(), 
function ()
	triggerEvent("CargarValoresEntreg",getLocalPlayer(),ValorPorEntrega,ValorPorFinEntregas,ValorMinimoPropina,ValorMaximoPropina)
end)