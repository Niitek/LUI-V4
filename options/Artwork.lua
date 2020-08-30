-- ####################################################################################################################
-- ##### Setup and Locals #############################################################################################
-- ####################################################################################################################
---@type Opt
local optName, Opt = ...
local LUI = LibStub("AceAddon-3.0"):GetAddon("LUI4")
-- local module = LUI:GetModule("Artwork")
-- local db = module.db.profile
local L = LUI.L

-- ####################################################################################################################
-- ##### Utility Functions ############################################################################################
-- ####################################################################################################################

Opt.options.args.Artwork = Opt:Group("Artwork", nil, nil, "tab", true, nil, Opt.GetSet(db))
Opt.options.args.Artwork.handler = mod
local Artwork = {

}

Opt.options.args.Artwork.args = Artwork