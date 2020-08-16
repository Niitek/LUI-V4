-- ####################################################################################################################
-- ##### Setup and Locals #############################################################################################
-- ####################################################################################################################
---@type Opt
local optName, Opt = ...
local LUI = LibStub("AceAddon-3.0"):GetAddon("LUI4")
local L = LUI.L
local mod = LUI:GetModule("Colors")

-- ####################################################################################################################
-- ##### Utility Functions ############################################################################################
-- ####################################################################################################################


Opt.options.args.Colors = Opt:Group("Colors", nil, 2, "tab", true, nil, Opt.GetSet(mod.db.profile))
Opt.options.args.Colors.handler = mod
local Colors = Opt.options.args.Colors.args