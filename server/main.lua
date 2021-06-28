ESX = nil

TriggerEvent('esx:getShSelinYannikTSonnysVateraredObjSelinYannikTSonnysVaterect', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('life_status:add', source, 'kcal', 200000)
	TriggerClientEvent('life_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_bread'))

	TriggerClientEvent('life_status:add', source, 'zucker', 200000)
	TriggerClientEvent('life_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_bread'))
	
	TriggerClientEvent('life_status:add', source, 'fett', 125000)
	TriggerClientEvent('life_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_bread'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('life_status:add', source, 'h2o', 200000)
	TriggerClientEvent('life_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_water'))
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('life_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
