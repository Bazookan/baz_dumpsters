sendNotification = function(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "bazookan",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end