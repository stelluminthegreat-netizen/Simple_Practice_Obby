local Products = require(script.Parent.Products)
local MPS = game:GetService("MarketplaceService")

MPS.ProcessReceipt = function(receiptInfo)
    local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)

	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local handler = Products[receiptInfo.ProductId]

	if handler then
		local success, result = pcall(handler, receiptInfo, player)

		if success and result then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end
