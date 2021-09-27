local ColorTexto = tocolor(229, 247, 3, 255)
local ColorTextoNe = tocolor(0, 0, 0, 255)
local marcaMoto = nil
local marcaCasa = nil
local variable = nil
local pizza = nil
local ValorEnt1 = nil
local ValorEnt2 = nil
local ValorEnt3 = nil
local ValorEnt4 = nil

--------BLIP----------
blipPizza = createBlip ( 2102.35546875, -1810.04296875, 13.5546875 ,56, 1, 255, 0, 0, 255, 0, 300 )
--------MARKER----------
markertPizza = createMarker (2102.35546875, -1810.04296875, 12.5546875, "cylinder",1.8, 229, 236, 17, 255 )
markervPizza = createMarker (2095.7783203125, -1819.7177734375, 12.3828125,"cylinder",2, 229, 236, 17, 255)

function CargarValoresEntreg(PValPre1,PValPre2,PValPre3,PValPre4)
ValorEnt1 = PValPre1
ValorEnt2 = PValPre2
ValorEnt3 = PValPre3
ValorEnt4 = PValPre4
end
addEvent( "CargarValoresEntreg", true)
addEventHandler( "CargarValoresEntreg", getRootElement(), CargarValoresEntreg)


local marcadoresTrabajo= {
	[1]={2494.236328125, -1681.5849609375, 12.338358879089, 2495.21484375, -1689.99609375, 13.765625},
	[2]={2457.9287109375, -1402.205078125, 22.900955200195,2487.1865234375, -1409.7890625, 27.837409973145},
	[3]={2193.4521484375, -1375.974609375, 22.991731643677,2185.140625, -1365.39453125, 24.82928276062},
	[4]={1914.2314453125, -1924.556640625, 12.546875, 1914.587890625, -1915.6162109375, 14.03270816803},
	[5]={1715.357421875, -2118.66796875, 12.546875,1715.283203125, -2124.1572265625, 12.875},
	[6]={1683.408203125, -1633.4150390625, 12.546875,1676.71484375, -1635.154296875, 13.2265625},
	[7]={2148.01953125, -1228.63671875, 22.9765625,2153.41796875, -1241.0751953125, 24.127502441406},
	[8]={2311.224609375, -1256.9736328125, 22.970247268677,2325.130859375, -1251.1455078125, 26.9765625},
	[9]={2232.7470703125, -1476.6845703125, 22.792919158936,2232.794921875, -1470.423828125, 23.048027038574}
}

function crearMarcadoresPizza(variable)
	local rand = math.random ( #marcadoresTrabajo )
	local x, y, z = marcadoresTrabajo[rand][1], marcadoresTrabajo[rand][2], marcadoresTrabajo[rand][3]
	local xx, yy, zz = marcadoresTrabajo[rand][4], marcadoresTrabajo[rand][5], marcadoresTrabajo[rand][6]
	local px, py, pz = getElementPosition(getLocalPlayer())
	triggerEvent("SolicitarDatosXmlPizza",getLocalPlayer())
	outputChatBox("[Pizzeria]#ffffffVe a la casa verde para entregar la pizza", 229, 247, 3,true)
	setElementData(localPlayer,"ConPedidosPizza", true)
	marcaMoto = crearMarcadorPizza(x,y,z,3)
	mm = createBlipAttachedTo(marcaMoto,31)
	addEventHandler('onClientMarkerHit', marcaMoto,
	function ( hitPlayer )
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Repartidor Pizza") then
			marcaCasa = crearMarcadorPizza(xx,yy,zz,2)
			mc = createBlipAttachedTo(marcaCasa,41)
			setElementVelocity (getPedOccupiedVehicle(getLocalPlayer()), 0, 0, 0)
			setControlState ( "enter_exit", true )
			cancelarAcciones()
			triggerEvent ( "comprobarMarcadorPizza", getLocalPlayer(),marcaMoto,mm)
			setElementData(localPlayer,"ConPedidosPizza", true)
			setTimer (function ( )
			setPedAnimation(getLocalPlayer(),"CARRY","crry_prtial",0,true,false,true,true)
			pizza = createObject(1582,px,py,pz)
			attachElements(pizza,getLocalPlayer(), 0,0.5,0.3,0,0,0)
			end,1000, 1)
			addEventHandler('onClientMarkerHit', marcaCasa,
			function ( hitPlayer )
				activarAcciones()
				detachElements ( pizza, getLocalPlayer() )
				destroyElement(pizza)
				triggerEvent ( "comprobarMarcadorPizza", getLocalPlayer(),marcaCasa,mc)
				triggerServerEvent ( "DardyproPizza", getLocalPlayer(), ValorEnt1,ValorEnt3,ValorEnt4)
				variable = variable + 1
				if(variable==4)then	
				finRuta()
				triggerServerEvent ( "DarPlataFinalPizza", getLocalPlayer(),ValorEnt2 )
				setElementData(localPlayer,"ConPedidosPizza", false)
				outputChatBox("[Pizzeria]#ffffffFinalizaste la ruta ten "..ValorEnt2.." mas, vuelve por otro pedido",  229, 247, 3,true)
				else
				crearMarcadoresPizza(variable)
				end
			end)
			function cancelarTodo()
				triggerEvent ( "comprobarMarcadorPizza", getLocalPlayer(),marcaMoto,mm)
				triggerEvent ( "comprobarMarcadorPizza", getLocalPlayer(),marcaCasa,mc)
				setElementData(localPlayer, "ConPedidosPizza", false)
				triggerServerEvent ( "DesMotoPizzaTemp", getLocalPlayer())
				if isElement(pizza)then
				detachElements (pizza, getLocalPlayer() )
				destroyElement(pizza)
				end
			end
		end
    end
	end )
end

function crearMarcadorPizza(posx,posy,posz,tama)
Marker = createMarker( posx, posy, posz, "cylinder",tama, 229, 236, 17, 255)
return Marker
end
addEvent( "crearMarcadorPizza", true)
addEventHandler( "crearMarcadorPizza", getRootElement(), crearMarcadorPizza)

function comprobarMarcador(marcador,blip)
	if isElement(marcador)then
		destroyElement(marcador)
		destroyElement(blip)
	else			
	end
end
addEvent( "comprobarMarcadorPizza", true)
addEventHandler( "comprobarMarcadorPizza", getRootElement(), comprobarMarcador)

function cancelarAcciones()
			toggleControl ( "accelerate", false )
			toggleControl ( "brake_reverse", false )
			toggleControl ( "handbrake", false )
			toggleControl ( "fire", false )
			toggleControl ( "next_weapon", false )
			toggleControl ( "previous_weapon", false )
			toggleControl ( "change_camera", false )
			toggleControl ( "jump", false )
			toggleControl ( "look_behind", false )
			toggleControl ( "crouch", false )
end

function activarAcciones()
			toggleControl ( "accelerate", true )
			toggleControl ( "brake_reverse", true )
			toggleControl ( "handbrake", true )
			toggleControl ( "fire", true )
			toggleControl ( "next_weapon", true )
			toggleControl ( "previous_weapon", true )
			toggleControl ( "change_camera", true )
			toggleControl ( "jump", true )
			toggleControl ( "look_behind", true )
			toggleControl ( "crouch", true )
			toggleControl ( "enter_exit",true)
end

addEventHandler ( "onClientPlayerVehicleExit", localPlayer,
	function(vehicle)
		if ( getVehicleID ( vehicle ) == 448 ) then
				displayCountDown(0, 0, 30, "%02s")
		else
		end
	end)

function displayCountDown(hh, mm, ss, format)
    local function convertSecondsToMinutes(ms)
        local hours = math.floor (ms/3600000) -- convert ms to hours
        local mins = math.floor (ms/60000) -- convert ms to mins
        local secs = math.floor ((ms/1000) % 60) -- convert ms to secs
        return string.format ( format, secs )  -- print hh:mm:ss format
        -- "%02s : %02s : %02s" is the default format
    end 
    local function countdownFin() 
        cancelarTodo()
		activarAcciones()
		triggerEvent ( "comprobarMarcadorPizza", getLocalPlayer(),marcaMoto,mm)
    end 
    direction = 0
    if (hh ~= nil) then
        if (hh <= 23) and ((hh >= 0)) then
            hh = hh * 3600000
            direction = direction + hh
        else
            outputChatBox("[ERROR] Hours must be between 0 and 24",255,0,0)
            direction = nil
        end
    end
    if (direction ~= nil) then
        if (mm ~= nil) then
            if (mm <= 59) and ((mm >= 0)) then
                mm = mm * 60000
                direction = direction + mm
            else
                outputChatBox("[ERROR] Minutes must be between 0 and 60",255,0,0)
                direction = nil
            end
        end
    end
    if (direction ~= nil) then
        if (ss ~= nil) then
            if (ss <= 60) and ((ss >= 0)) then
                ss = ss * 1000
                direction = direction + ss
            else
                outputChatBox("[ERROR] Seconds must be between 0 and 60",255,0,0)
                direction = nil
            end
        end
    end
    if (direction ~= nil) then
        countDownTimes = (direction / 1000) -- Convert direction into seconds to prevent debug warnings by setTimer function
        countdown = setTimer(countdownFin, direction+1000, 1)
    end
    local function drawText(text)
        local function drawTextZG()
            dxDrawText("Tiempo para volver a la moto: ".. text, 348, 639, 707, 671, ColorTextoNe, 1.6, "sans", "center", "center", false, false, true, false, false)
			dxDrawText("Tiempo para volver a la moto: ".. text, 348, 637, 707, 669, ColorTextoNe, 1.6, "sans", "center", "center", false, false, true, false, false)
			dxDrawText("Tiempo para volver a la moto: ".. text, 346, 639, 705, 671, ColorTextoNe, 1.6, "sans", "center", "center", false, false, true, false, false)	
			dxDrawText("Tiempo para volver a la moto: ".. text, 346, 637, 705, 669, ColorTextoNe, 1.6, "sans", "center", "center", false, false, true, false, false)
			dxDrawText("Tiempo para volver a la moto: ".. text, 345, 638, 706, 670, ColorTexto, 1.6, "sans", "center", "center", false, false, true, false, false)
				
        end
        addEventHandler ( "onClientPreRender", root, drawTextZG) -- draw evrey screen render
        setTimer(
            function()
                removeEventHandler ( "onClientPreRender", root, drawTextZG) -- remove text after each second
            end
        , 1000, 1) -- do this function evrey second once
    end
    if (direction ~= nil) then
        masCan = setTimer( 
            function() 
                drawText(convertSecondsToMinutes(getTimerDetails(countdown))) -- sends hh:mm:ss foramt to dx draw function
            end
        , 1000, countDownTimes-1)
    end
	local function cancelarTimerPrin()
	if (isTimer(fun_tim) == true) then
		killTimer ( fun_tim )
	end
	if (isTimer(countdown) == true) then
	killTimer ( countdown )
	end
	if (isTimer(masCan) == true) then
	killTimer ( masCan )
	end
	end
	addEventHandler ( "onClientPlayerVehicleEnter", localPlayer,
	function(vehicle)
		if ( getVehicleID ( vehicle ) == 448 ) then
				cancelarTimerPrin()
		else
		end
	end)
	
end

local sx,sy = guiGetScreenSize()
local px,py = 1440,900
local x,y =  (sx/px), (sy/py)

function PanelPizza()
    window = guiCreateWindow(x*456, y*212, x*520, y*452, "Trabajo Repartidor de pizza", false)
    guiWindowSetSizable(window, false)

    local obtenernombreinicio = getPlayerName(getLocalPlayer())	
    memomision1 = guiCreateMemo(x*10, y*25, x*242, y*417, "" .. obtenernombreinicio ..  " a partir de ahora trabajaras como repartidor de pizza, tu decides si aceptar o no", false, window)
    guiMemoSetReadOnly(memomision1, true)
    botonaceptar = guiCreateButton(x*279, y*25, x*227, y*76, "Aceptar Trabajo", false, window)
    botonsalir = guiCreateButton(x*278, y*339, x*228, y*82, "Salir", false, window)
    
	showCursor(true)
	addEventHandler("onClientGUIClick", botonaceptar, empezartPizza, false)
	addEventHandler("onClientGUIClick", botonaceptar, dieHandler, false)
	addEventHandler("onClientGUIClick", botonaceptar, salir1, false)	
	addEventHandler("onClientGUIClick", botonsalir, salir1, false)
	addEventHandler("onClientGUIClick", botonaceptar, activarAcciones, false)	
end

function dieHandler(p)
	addEventHandler ("onClientRender", getRootElement(), IniciarTrabajo)
	setTimer(function() removeEventHandler("onClientRender",getRootElement(),IniciarTrabajo) end,10000,1)
end

function finRuta(p)
	addEventHandler ("onClientRender", getRootElement(), FinalizarRuta)
	setTimer(function() removeEventHandler("onClientRender",getRootElement(),FinalizarRuta) end,10000,1)
end

function empezartPizza ()
	showCursor(false)
	triggerServerEvent ( "CambiarTeamTrabajoPizza", getLocalPlayer() ) 
	triggerServerEvent ( "CambiarOcupacionPizza", getLocalPlayer() )
end

function IniciarTrabajo ()
    dxDrawText("Trabajo iniciado", 212, 611, 820, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 212, 609, 820, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 210, 611, 818, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 210, 609, 818, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 211, 610, 819, 645, tocolor(229, 247, 3, 255),1.6, "sans", "center", "center", false, false, true, false, false)
end

function FinalizarRuta ()
    dxDrawText("Entregas Finalizadas, vuelve por mas", 212, 611, 820, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Entregas Finalizadas, vuelve por mas", 212, 609, 820, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Entregas Finalizadas, vuelve por mas ", 210, 611, 818, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Entregas Finalizadas, vuelve por mas", 210, 609, 818, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Entregas Finalizadas, vuelve por mas", 211, 610, 819, 645, tocolor(229, 247, 3, 255),1.6, "sans", "center", "center", false, false, true, false, false)
end

function salir1()
	showCursor(false)
	destroyElement(window)
end

addEventHandler('onClientMarkerHit', markertPizza,
function ( hitPlayer )
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Repartidor Pizza") then
			outputChatBox("[Pizzeria]#ffffffUsted ya tiene este trabajo", 229, 247, 3,true)
			else
			if(isPedInVehicle (getLocalPlayer()))then
				outputChatBox("[Pizzeria]#ffffffNo puedes usarlo si estas en un vehiculo", 229, 247, 3,true)
			else
			if(getElementData(localPlayer, "Ocupacion" ) == "Civil") then
				if( isElementWithinMarker(localPlayer, markertPizza))then
				PanelPizza()
				else
				end
				else
					outputChatBox("[Pizzeria]#ffffff tienes que ser civil para tener este trabajo, usa el comando /civil", 229, 247, 3,true)
				end
			end
		end
    end
end )

addEventHandler('onClientMarkerHit', markervPizza,
function ( hitPlayer )
local Veh = getElementData(localPlayer ,"VehId")
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Repartidor Pizza") then
			if(getElementData(localPlayer, "ConPedidosPizza" ) == false) then
				if isElement(Veh)then
					local conta = 1
					crearMarcadoresPizza(conta)
				else
					triggerServerEvent ( "CrearMotoPizza", getLocalPlayer())
					local conta = 1
					crearMarcadoresPizza(conta)
				end
			else
			outputChatBox("[Pizzeria]#ffffffAun tienes entregas, espera que se destruya tu moto o termina",229, 247, 3,true)		
			end
		end
    end
end )
