ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('nopat', function(source)
	TriggerClientEvent('noppajuttu:nopat', source)
end)

RegisterServerEvent('noppajuttu:noppakomento')
AddEventHandler('noppajuttu:noppakomento', function()
	local xPlayer    = ESX.GetPlayerFromId(source)
	local nopat = xPlayer.getInventoryItem('nopat')

	if nopat.count > 0 then
		TriggerClientEvent('noppajuttu:nopat', source)
	else
		TriggerClientEvent('esx:showNotification', source, 'Ei sulla oo noppia')
	end
end)

RegisterServerEvent('noppajuttu:arpa')
AddEventHandler('noppajuttu:arpa', function(id, numero)
	TriggerClientEvent('noppajuttu:numeronnaytto', id, source, numero)
end)