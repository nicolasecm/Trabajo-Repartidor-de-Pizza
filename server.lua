function CambiaarTeam()
	local team = getTeamFromName("Trabajadores")
	setPlayerTeam( source, team)
	local resp = getElementModel(source)
	setElementData  (source, "SkinF", resp)
	setElementModel(source,155)
	setPlayerNametagColor (source, 229,236,17)
end
addEvent( "CambiarTeamTrabajoPizza", true)
addEventHandler( "CambiarTeamTrabajoPizza", getRootElement(), CambiaarTeam)

function DardyproPizza (Dinero1,dinRan1,dinRan2 )
local PDin1 = Dinero1
givePlayerMoney ( source, PDin1)
randomMoney = math.random ( dinRan1, dinRan2)
givePlayerMoney ( source, randomMoney)
outputChatBox("[Pizzeria]#ffffffTu propina fue de:".. randomMoney .. " ",source, 229, 247, 3,true)
end
addEvent( "DardyproPizza", true)
addEventHandler( "DardyproPizza", getRootElement(), DardyproPizza)

function darPlataFinPizza (dinFin)
givePlayerMoney ( source, dinFin)
end
addEvent( "DarPlataFinalPizza", true)
addEventHandler( "DarPlataFinalPizza", getRootElement(), darPlataFinPizza)

function CambiarOcupacion()
    setElementData(source,"Ocupacion", "Repartidor Pizza", true)
	setElementData(source,"VehiTrabajo", 0, true)
	setElementData(source,"ConPedidosPizza", false, true)
end
addEvent( "CambiarOcupacionPizza", true)
addEventHandler( "CambiarOcupacionPizza", getRootElement(), CambiarOcupacion)

Motos = {}

function CrearMotoPizz()
local comprobar = getElementData(source, "VehiTrabajo")
	if(getElementData(source, "ConPedidosPizza" ) == false) then
		if (comprobar == 0) then
		Motos[source] = createVehicle ( 448, 2095.7783203125, -1819.7177734375, 13.3828125, 0, 0, 360, "Pizza" )
		warpPedIntoVehicle(source,Motos[source])
		setElementData(source,"VehId",Motos[source])
		setElementData(source,"ConPedidosPizza",true)
		else
		outputChatBox("[Pizzeria]#ffffffYa esta en un vehiculo",source, 229, 247, 3,true)
		end
	else
	outputChatBox("[Pizzeria]#ffffffAun tienes pedidos vuelve cuando termines o espera que se destruya tu moto", source,229, 247, 3,true)
	end
end

addEvent( "CrearMotoPizza", true)
addEventHandler( "CrearMotoPizza", getRootElement(), CrearMotoPizz)

function DestruirMotoPizz()
local Veh = getElementData(source ,"VehId")
		if isElement(Veh)then
			destroyElement(Veh)
			setElementData(source,"ConPedidosPizza", false)
			outputChatBox("[Pizzeria]#ffffffSu moto a sido destruida, ve por otra",source,229, 247, 3,true)		
		else
		end
end
addEvent( "DesMotoPizzaTemp", true)
addEventHandler( "DesMotoPizzaTemp", getRootElement(), DestruirMotoPizz)

